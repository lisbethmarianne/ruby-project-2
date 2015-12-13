class CaesarsCipher
  def supported_characters
    ('a'..'z').to_a
  end

  def cipher(rotate)
    characters_encrypt = supported_characters.rotate(rotate)
    Hash[supported_characters.zip characters_encrypt]
  end

  def encrypt(rotate, string)
    letters = string.split("")
    result = letters.map do |letter|
      if supported_characters.include?(letter)
        cipher(rotate)[letter]
      elsif supported_characters.include?(letter.downcase)
        new_letter = cipher(rotate)[letter.downcase]
        new_letter = new_letter.upcase
      else
        letter
      end
    end
    result.join
  end

  def decrypt(rotate, string)
    rotate = supported_characters.length - rotate
    encrypt(rotate, string)
  end
end
