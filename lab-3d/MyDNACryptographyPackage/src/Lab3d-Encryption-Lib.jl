"""
    encrypt(plaintext::String) -> Dict{Int64,String}

    needs to take in plaintext and reference individual characters so 
    for i in length of plaintext string needs to be assigned a new value based on that input
        new values found in factory so need to get those
   
        char = plaintext[begin]

    encryption = Dict{Int64, String}()
        encryption[1] = char
    return encryption

   
"""
function encrypt(plaintext::String)::Dict{Int64,String}
    
    message = Dict{Int64, String}()
    counter = 0

    encryption_model = _build(DNAEncryptionKey)
    encryptionkey = encryption_model.encryptionkey

    for x in uppercase(plaintext)        
        message[counter] = encryptionkey[x]
        counter += 1
    end 

    return message
end

"""
    decrypt(encrypteddata::Dict{Int64,String}) -> String
"""
function decrypt(encrypteddata::Dict{Int64,String})::String
    
    
end