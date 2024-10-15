try
    @eval using Revise
catch e
    @warn "Error initializing Revise" exception = (e, catch_backtrace())
end

# this also works, no idea which is better
# using Pkg: Pkg
if isinteractive()
    using Pkg: Pkg
end

# replacing first line with
# if isinteractive()
# also works (?) here (without `using Pkg: Pkg`)

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
