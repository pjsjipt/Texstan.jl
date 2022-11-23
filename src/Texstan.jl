module Texstan

import CSV
import DataFrames: DataFrame

export AbstractTexstan, texstan_exe!, wine_exe!, texstan, read_ftn_header
export read_ftn

atex5_exe = Ref{String}("atex5.exe")
wine_exe = Ref{String}("wine")

abstract type AbstractTexstan end

function texstan_exe!(s)
    atex5_exe[] = s
end

function wine_exe!(s)
    wine_exe[] = s
end

function texstan(fname)
    path = tempdir()
    path_now = pwd()
    try
        #cd(path)
        if Sys.islinux()
            wf = wine_exe[]
            aexe = atex5_exe[]
            cmd = pipeline(`echo $fname`, `$wf $aexe`)
        else
            error("I don't know how to do this (yet!)")
        end
        run(cmd)
        # Read the output files
    catch e

    finally

        #cd(path_now)
    end
end

function read_ftn_header(fname)
    open(fname, "r") do f
        # Read stuff before the header
        for i in 1:4
            readline(f)
        end
        # Read the header:
        hstr = readline(f)
        idx = findfirst('#', hstr)
        [string(s) for s in split(hstr[(idx+1):end], ' ', keepempty=false)]
    end
        
end


function read_ftn(fname)
    # Let's try to get the variables:
    header = read_ftn_header(fname)
    return CSV.read(fname, DataFrame; skipto=6, header=header, delim=' ',
                    ignorerepeated=true)
end
        
            
            
# Write your package code here.

end
