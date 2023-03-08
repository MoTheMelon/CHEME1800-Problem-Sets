
"""
    read_compounds_file(path::String) -> Dict{String, MyChemicalCompoundModel}

    Reads the information contained in the file, creating a Dictionary{String,MyChemicalCompoundModel} with the name of the compounds
    as keys and a MyChemicalCompoundModel objects as values. 
    
    input: path::String     The path to the data file this function will read.
    output: Dict{String,MyChemicalCompoundModel}    The dictionary of the data in the file stored with keys (String) and values (MyChemicalCompoundModel).
    """
function read_compounds_file(path::String)::Dict{String, MyChemicalCompoundModel}
    
    # check: is path legit?
    # in production we would check this path, assume ok for now

    # initialize -
    compounds = Dict{String, MyChemicalCompoundModel}()

    # use example pattern from: https://varnerlab.github.io/CHEME-1800-Computing-Book/unit-1-basics/data-file-io.html#program-read-a-csv-file-refactored
    open(path, "r") do io # open a stream to the file
        for line in eachline(io) # read each line from the stream
            if (contains(line,"#") == false)
                
                # splits around the ','
                fields = split(line, ',');

                # grab the fields -
                name = string(fields[1]);
                compound = string(fields[2]);
                composition = Dict{Char, Int64}()

                # build - 
                model = build(MyChemicalCompoundModel, name, compound, composition);

                # store -
                compounds[name] = model;
            end
        end
    end

    # return -
    return compounds
end