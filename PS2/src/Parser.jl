"""
    _recursive_compound_parser(q::Queue{Char}, elements::Array{Char,1}, values::Array{Int,1})

This function holds the logic behind the recursive parser. It sorts the queued compound characters into elements and values arrays to update the parser.

"""
function _recursive_compound_parser(q::Queue{Char}, elements::Array{Char,1}, values::Array{Int,1})

    # base case: we have no more characters in the character_arr - we are done
    if (isempty(q) == true)
        return nothing 
    else
        # grab the next_char -
        next_char = dequeue!(q)

        #test: is the character a number? & are we at the end of the queue?
        if (isnumeric(next_char) && isempty(q) == false)
            #if the queue is empty, we don't want to try and dequeue another character - it will throw an error.

            #pull the next character and see if it's a number too
            next_char2 = dequeue!(q)
            if (isnumeric(next_char2))
                #if it's a number, combine this character with the one before to create a number string and convert to int
                #add int to array
                num_str = string(next_char, next_char2)
                num = parse(Int, num_str)

                push!(values, num)

            else
                #if the next character in queue is an element,
                #put the single number in the number array
                num = parse(Int,next_char)
                push!(values, num)

                if (isempty(q) == true)
                    #if that was the last character, add it to the element array and give a value of 1
                    push!(elements, next_char2)
                    push!(values, 1)
                else
                    #if it wasn't the last character, simply add to elements array
                    push!(elements, next_char2)
                end

            end
        
        elseif (isnumeric(next_char) && isempty(q) == true)
            #if the last character is a number, put that number in the values array
            num = parse(Int, next_char)
            push!(values, num)
        
        elseif (isempty(q) == true)
            #if the last character is an element, put it in the elements array.
            push!(elements, next_char)
            #if the queue is empty after pushing a Char, that means there is 1 of that element, so give it a value of 1
            push!(values, 1)

        else
            #character is an element, so put it in the element array
            push!(elements, next_char)

        end
        # process the next character in the queue
        _recursive_compound_parser(q, elements, values);

    end
end

"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel}) -> Dict{String, MyChemicalCompoundModel}

Parser that reads the compound formula and stores the keys (elements) and values (values) in a composition dictionary. The inputted dictionary compounds is
updated and then returned.
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}
    # process each compound
    for (name, compound) ∈ compounds 
        
        composition = Dict{Char,Int}()
        q = Queue{Char}()
        elements = Array{Char,1}()
        values = Array{Int,1}()
        
        #for each compound, build an array that contains the characters of the compound
        character_arr = collect(compound.compound)
        for c ∈ character_arr
            enqueue!(q, c);
        end

        _recursive_compound_parser(q, elements, values);
        
        counter = 1
        for element ∈ elements    
            composition[element] = values[counter];
            counter += 1
        end
        compound.composition = composition
    end

    return compounds;
end