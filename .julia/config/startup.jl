try
    @eval using Revise
    # @eval __revise_mode__ = :eval
catch e
    @warn "Error initializing Revise" exception = (e, catch_backtrace())
end

if isinteractive()
    @eval import REPL
    @eval import REPL.LineEdit
end

atreplinit() do repl
    # copied from https://github.com/Moelf/JLFzf.jl
    try
        @eval import JLFzf
    catch
        return
    end
    mykeys = Dict{Any,Any}(
        "^R" => function (mistate, o, c)
            line = JLFzf.inter_fzf(JLFzf.read_repl_hist(), 
            "--read0", 
            "--tiebreak=index",
            "--preview-window=hidden",
           );
            JLFzf.insert_history_to_repl(mistate, line)
        end,
    )
    repl.interface = REPL.setup_interface(repl; extra_repl_keymap = mykeys)
end

if haskey(ENV, "JULIA_LOCAL_INIT")
    if isfile(ENV["JULIA_LOCAL_INIT"])
        include(ENV["JULIA_LOCAL_INIT"])
    elseif isfile(ENV["JULIA_LOCAL_INIT"] * "/startup.jl")
        include(ENV["JULIA_LOCAL_INIT"] * "/startup.jl")
    end
end
