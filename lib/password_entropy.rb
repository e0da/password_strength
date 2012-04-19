module PasswordEntropy

  #
  # Password entropy according to NIST Special Publication 800-63, but without the dictionary check.
  #
  # <http://en.wikipedia.org/wiki/Password_strength#NIST_Special_Publication_800-63>
  #
  # The dictionary check is expensive and adds unnecessary complexity. We can
  # just do without the bonus points.  Just make your password longer or
  # something.
  #
  # We'll also do some stuff at the end to stop obviously bad passwords.
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


    # Characters 21 and above have one bit of entropy per character.
    #
    for i in 21..password.length
      total += 1
    end

    # A bonus of six bits is added if both upper case letters and
    # non-alphabetic characters are used.
    #
    total += 6 if password.match(/[A-Z]/) && password.match(/[^a-z]/i)

    # Numbers only get you a zero.
    #
    return 0 if password.match(/^\d+$/)

    # runs of consecutive letters or numbers get you a deduction of 6 bits each.
    # Exceptions for reasonable ones like "def".
    #
    %w[
      abc bcd efg fgh ijk jkl klm lmn mno
      nop opq pqr qrs rst stu tuv uvw vwx wxy xyz
    ].each do |run|
      total -= 6 if run.match password.downcase
    end


    total
  end
end
