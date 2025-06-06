try
    @eval using Revise
    # @eval __revise_mode__ = :eval
catch e
    @warn "Error initializing Revise" exception = (e, catch_backtrace())
end

if isinteractive()
    using Pkg: Pkg
end

atreplinit() do repl
    try
        @eval using OhMyREPL
    catch e
        @warn "error while importing OhMyREPL" e
    end
end

if haskey(ENV, "JULIA_LOCAL_INIT")
    if isfile(ENV["JULIA_LOCAL_INIT"])
        include(ENV["JULIA_LOCAL_INIT"])
    elseif isfile(ENV["JULIA_LOCAL_INIT"] * "/startup.jl")
        include(ENV["JULIA_LOCAL_INIT"] * "/startup.jl")
    end
end
