
"""
    read_reaction_file(path::String) -> Dict{String, MyKeggReaction}

"""
function read_reaction_file(path::String)::Dict{String, MyKeggReaction}
    
    # check: is path legit?
    # in production we would check this path, assume ok for now

    # initialize -
    reactions = Dict{String, MyKeggReaction}()

    # use example pattern from: https://varnerlab.github.io/CHEME-1800-Computing-Book/unit-1-basics/data-file-io.html#program-read-a-csv-file-refactored
    open(path, "r") do io # open a stream to the file
        for line in eachline(io) # read each line from the stream
            if (contains(line,"#") == false)

                fields = split(line, ','); # splits around the ','

                # grab the fields -
                name = string(fields[1]);
                reactant = string(fields[2]);
                product = string(fields[3]);

                # build - 
                model = build(MyKeggReaction, name, reactant, product);

                # store -
                reactions[name] = model;
            end
        end
    end

    # return -
    return reactions;
end