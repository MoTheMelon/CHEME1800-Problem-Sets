"""
    encrypt(plaintext::String) -> Dict{Int64,String}

*** write here how the function works as a whole
"""
function encrypt(plaintext::String)::Dict{Int64,String}

    #initialize the output message as correct output type, Dict{Int64, String}
    message = Dict{Int64, String}()
    #always start character counter at 0
    charCount = 0

    encryption_model = _build(DNAEncryptionKey)
    encryptionkey = encryption_model.encryptionkey

    for c in uppercase(plaintext)     
        #for each character in the plaintext, add another component to the dictionary that corresponds to the encrytion of that character 
        message[charCount] = encryptionkey[c]
        #after looking at the current character, go through the for loop again for the next character (charCount += 1)
        charCount += 1
    end 

    #output the dictionary containing the encrytion that corresponds to the message
    return message
end


"""
    decrypt(encrypteddata::Dict{Int64,String}) -> String

Fill me in
"""
function decrypt(encrypteddata::Dict{Int64,String})::String

    
end