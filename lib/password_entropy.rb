module PasswordEntropy

  #
  # Password entropy according to NIST Special Publication 800-63
  #
  # <http://en.wikipedia.org/wiki/Password_strength#NIST_Special_Publication_800-63>
  #
  #
  def self.entropy(password)

    total = 0

    # The entropy of the first character is four bits
    #
    total += 4 if password.length > 0

    # The entropy of the next seven characters are two bits per character
    #
    for i in 1...[password.length, 8].min 
      total += 2
    end

    # The ninth through the twentieth character has 1.5 bits of entropy per
    # character
    #
    for i in 8...[password.length, 20].min
      total += 1.5
    end



    ##   * Characters 21 and above have one bit of entropy per character.
    #   * A "bonus" of six bits is added if both upper case letters and
    #     non-alphabetic characters are used.
    #   * A "bonus" of six bits is added for passwords of length 1 through 19
    #     characters following an extensive dictionary check to ensure the password
    #     is not contained within a large dictionary. Passwords of 20 characters or
    #     more do not receive this bonus because it is assumed they are
    #     pass-phrases consisting of multiple dictionary words.

    total
  end
end
