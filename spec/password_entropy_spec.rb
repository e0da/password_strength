require 'spec_helper'

module PasswordEntropy

  describe '.entropy' do

    examples = [
      ['a', 4],
      ['ab', 6],
      ['aa', 6],
      ['1a', 6],
      ['12345678', 18]
    ]

    examples.each do |password, entropy|

      it "should return #{entropy} for #{password}" do
        PasswordEntropy.entropy(password).should == entropy
      end
    end
  end
end
