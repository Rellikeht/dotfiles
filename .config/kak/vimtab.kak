# Replicate expandtab from vim.
declare-option -docstring "Expand <tab> to spaces based on tabstop." bool expandtab yes

# Replicate softtabstop from vim.
declare-option -docstring "Make tabstop number of spaces feel like a <tab> when pressing <tab> or <backspace> in insert mode." int softtabstop 4

# Helper function for inserting a <tab>
def softtabstop-insert-tab -hidden %{
    evaluate-commands -no-hooks -draft -itersel %{
        try %sh{
            tabstop=$kak_opt_softtabstop
            if [ $tabstop -lt 0 ]; then
                tabstop=$kak_opt_indentwidth
            fi
            # Determine if this is an append operation (end column > start column). If so, prefix with ';'
            prefix=$(echo $kak_selections_display_column_desc | awk -F '[.,]' '{if($4 > $2) {print ";"}}')
            if [ $tabstop -eq 0 ]; then
                # if tabstop is 0 that means we are just inserting tabs
                printf "execute-keys '${prefix}i<tab><esc>'\n"
                # expand tabs to spaces if needed
                [ $kak_opt_expandtab = "true" ] && printf "%s\n" 'execute-keys h<ret>@'
            else
                # compute the number of spaces needed to reach the next softtabstop
                display_column=$((kak_cursor_display_column - 1)) # adjust for 1-based indexing
                end_column=$((display_column % tabstop))
                space_count=$((tabstop - end_column))
                # insert enough spaces to reach the next softtabstop
                printf "execute-keys '${prefix}i%${space_count}s<esc>'\n"
                # if not expanding tabs, convert *all* preceding whitespace to a mix of spaces and
                # tabs, not just the spaces that were inserted (this is how vim behaves)
                [ $kak_opt_expandtab = "false" ] && printf "execute-keys '<a-?>\h+<ret><a-:>H<a-@>'"
            fi
        }
    }
}

# Helper function for deleting whitespace a <tab>
def softtabstop-insert-backspace -hidden %{
    evaluate-commands -no-hooks -draft -itersel -save-regs ^ %{
        # save off the current selection in case the try block fails
        try %sh{
            tabstop=$kak_opt_softtabstop
            if [ $tabstop -lt 0 ]; then
                tabstop=$kak_opt_indentwidth
            fi
            if [ $tabstop -gt 0 ]; then
                # compute the end display column based on tabstop and the number of
                # number spaces needed to reach it
                display_column=$((kak_cursor_display_column - 1)) # adjust for 1-based indexing
                num_spaces=$((display_column % tabstop))
                [ $num_spaces -eq 0 ] && num_spaces=$tabstop
                end_display_column=$((display_column - num_spaces))
                # extract any preceding whitespace
                echo "evaluate-commands -draft %{
                    execute-keys '<a-?>\h+<ret><a-;>H'
                    echo -to-file $kak_response_fifo %val{selection}
                }" > $kak_command_fifo
                whitespace="$(cat $kak_response_fifo)"
                # count the number of mixed tabs and spaces needed to reach the end display column
                tab=$(printf "\t")
                num_whitespaces=0
                adjust_cursor="<a-:>;"
                while [ -z "$non_ws" ] \
                    && [ -n "$whitespace" ] \
                    && [ $display_column -gt $end_display_column ];
                do
                    # iterate over the whitespace right-to-left, early out after reaching the
                    # first non whitespace
                    prefix=${whitespace%?};
                    ws="${whitespace#$prefix}";
                    case "$ws" in
                        $tab) display_column=$((display_column - $kak_opt_tabstop));
                              # the first whitespace encountered is a tab. when '@' is pressed, the
                              # cursor moves (or extends) one char to the right. account for this here
                              [ $num_whitespaces -eq 0 ] && adjust_cursor="${adjust_cursor}h";;
                         " ") display_column=$((display_column - 1));;
                           *) non_ws="true";;
                    esac
                    whitespace=$prefix;
                    if [ -z "$non_ws" ]; then
                        num_whitespaces=$((num_whitespaces + 1));
                    fi
                done
                if [ $num_whitespaces -gt 0 ]; then
                    # * select the number of mixed tabs and spaces computed above
                    # * convert to spaces and adjust the cursor position
                    # * select the number of spaces to reach the end column and delete them
                    echo "execute-keys '<a-:>;h<a-?>\h{$((num_whitespaces - 1))}<ret>@${adjust_cursor}<a-?> {,$((num_spaces - 1))}<ret>d'"
                else
                    echo "fail"
                fi
            else
                echo "fail"
            fi
        } catch %{
            # in normal mode, delete previous character
            execute-keys 'hd'
        }
    }
}

# Use a hook to enable/disable key mappings such that '\' properly allows disabling specialized <tab> behavior
hook global ModeChange 'push:.+:insert' %{
    map buffer insert <tab> '<a-;>:softtabstop-insert-tab<ret>'
    map buffer insert <backspace> '<a-;>:softtabstop-insert-backspace<ret>'
}
hook global ModeChange 'pop:insert:normal' %{
    unmap buffer insert <tab> '<a-;>:softtabstop-insert-tab<ret>'
    unmap buffer insert <backspace> '<a-;>:softtabstop-insert-backspace<ret>'
}
