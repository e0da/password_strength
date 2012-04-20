require 'spec_helper'

class String
  
  describe '.entropy' do
    { 
      'aaaaaaaa' => :weak,
      'friendlygh' => :weak,
      'aaaaaaaA' => :weak,
      'aaaaaaA5' => :ok,
      'jT123456' => :ok,
      'bottlerocket' => :ok,
      'Very$trong?' => :strong,
      'Boxxy2Boxxy' => :strong,
      'write way more code' => :strong
    }.each_pair do |password, rating|

      it %[says %20s is %6s] % [password, rating] do
        password.password_strength.should == rating
      end
    end
  end
end
