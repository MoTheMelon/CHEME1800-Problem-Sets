"""
    encrypt(plaintext::String) -> Dict{Int64,String}

Method which encrypts a String `plaintext` using a `DNAEncryptionKey` to store it in a Dict `message` and return `message`

input: String `plaintext`
output: Dict{Int64,String} `message`
    """
function encrypt(plaintext::String)::Dict{Int64,String}

    #initialize the output message as correct output type, Dict{Int64, String}
    message = Dict{Int64, String}()
    #always start character counter at 0
    charCount = 0

    encryptionModel = build(DNAEncryptionKey)
    encryptionkey = encryptionModel.encryptionkey

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

Method which decrypts an encoded message `encrypteddata` using an inverted encryption key to return a String `message`

input: Dict{Int64,String} `encrypteddata`
output: String `message`
"""   
function decrypt(encrypteddata::Dict{Int64,String})::String

    #get length of encrypted data
    numChars = length(encrypteddata)
    #initialize final plaintext (decryptedMessage) as being a vector of characters
    decryptedMessage = Vector{Char}()

    #create normal encryption key
    encryptionModel = build(DNAEncryptionKey)
    encryptionKey = encryptionModel.encryptionkey

    #invert the encryption key with a for loop to reassign all values to the reverse
    invertedEncryptionKey = Dict(str => c for (c, str) in encryptionKey)

    for c in 0:(numChars-1)

        #grab a character starting at an index of 0
        index = encrypteddata[c]
        value = invertedEncryptionKey[index]
        push!(decryptedMessage, value)

    end

    message = String(decryptedMessage)
    
    return message
end
