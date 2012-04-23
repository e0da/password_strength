class String

  #
  # Strength of the string as a password.
  #
  # Returns one of :weak, :ok, or :strong.
  #
  def password_strength
    case weighted_entropy
    when 0..22
      :weak
    when 22..24
      :ok
    when 24..1000
      :strong
    end
  end

  def weighted_entropy

    #
    # This is based in part on NIST Special Publication 800-63, but we're going
    # to skip the dictionary part. This doesn't hurt us since it's just a bonus
    # that we won't apply.
    #
    #   * The first character gives you 4 bits.
    #   * Characters 2 through 8 give you 2 bits each.
    #   * Characters 9 through 20 give you 1.5 bits each.
    #   * Characters 21 and above give you 1 bit each.
    #   * You get a 3-bit bonus for using capitals and lowercase
    #   * You get a 3-bit bonus for non-alphabetic characters.
    #

    entropy = 4
    2.upto([ 8, length].min) { entropy += 2   }
    9.upto([20, length].min) { entropy += 1.5 }
    21.upto(length)          { entropy += 1   }
    entropy += 3 if match(/[A-Z]/) && match(/[a-z]/)
    entropy += 3 if match(/[^a-z]/i)

    entropy
  end
end
