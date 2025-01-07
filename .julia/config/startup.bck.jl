# TODO bash command under key
# import REPL
# import REPL.LineEdit

# const mykeys = Dict{String,Function}(
#     "" => (s::LineEdit.MIState, o...) -> begin
#         # LineEdit.edit_input(s, (a...) -> run(`bash`))
#         LineEdit.edit_insert_newline(s)
#         return nothing
#     end
# )

# function customize_keys(repl::REPL.LineEditREPL)
#     repl.interface = REPL.setup_interface(repl; extra_repl_keymap = mykeys)
# end

# atreplinit() do repl
#     customize_keys(repl)
# end

# TODO or bash mode (no idea what for)
# function bash_run(cmd::AbstractString)
#     return quote
#         cmd = $(Expr(:quote, cmd))
#         run(`bash -c "$cmd"`)
#         return nothing
#     end
# end

# atreplinit() do repl
#     # try
#         @eval using ReplMaker
#         @eval import REPL
#         @eval initrepl(
#             bash_run;
#             prompt_text="bash> ",
#             prompt_color=:cyan,
#             completion_provider = REPL.ShellCompletionProvider(),
#             start_key='>',
#             mode_name="bash_mode",
#         )
#     # catch
#     # end
# end

