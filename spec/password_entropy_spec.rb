require 'spec_helper'

module PasswordEntropy

  describe '.entropy' do

    examples = [
      ['a', 4], # 1 char
      ['ab', 4+2], # 2 char
      ['1234567890', 0], # numbers only
      ['abcdefghij012345678', 4+(7*2)+(11*1.5)], # 19 char
      ['abcdefghij0123456789', 4+(7*2)+(12*1.5)], # 20 char
      ['abcdefghij0123456789f', 4+(7*2)+(12*1.5)+1], # 21 char
      ['abcdefghij0123456789flkjsijeflkj', 4+(7*2)+(12*1.5)+(12*1)], # over 21 char
      ['1A', 4+2+6], # non-alphabetic and capital
    ]

    examples.each do |password, entropy|

      it "should return #{entropy} for #{password}" do
        PasswordEntropy.entropy(password).should == entropy
      end
    end
  end
end
