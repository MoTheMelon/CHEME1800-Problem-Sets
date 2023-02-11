using DNACryptographyPackage

plaintext = "Julia is awesome. The computer is my best friend, and it loves me. This is a test and only a test."

secretMessage = encrypt(plaintext)
decryptedMessage = decrypt(secretMessage)

println(secretMessage)
println(decryptedMessage)