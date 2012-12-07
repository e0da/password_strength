require 'spec_helper'

class String

  describe '.password_entropy and .password_strength' do
    {
      'aaaaaaaa'            => [ 4+(2*7),              :weak   ],
      'friendlygh'          => [ 4+(2*7)+(2*1.5),      :weak   ],
      'aaaaaaaA'            => [ 4+(2*7)+3,            :weak   ],
      'aaaaaaA5'            => [ 4+(2*7)+3+3,          :ok     ],
      'jT123456'            => [ 4+(2*7)+3+3,          :ok     ],
      'bottlerocket'        => [ 4+(2*7)+(4*1.5),      :ok     ],
      'Very$trong?'         => [ 4+(2*7)+(3*1.5)+3+3,  :strong ],
      'Boxxy2Boxxy'         => [ 4+(2*7)+(3*1.5)+3+3,  :strong ],
      'write way more code' => [ 4+(2*7)+(11*1.5)+3,   :strong ],

      'a really, really, really long one that is just so very long' => [ 4+(2*7)+(12*1.5)+(39*1)+3, :strong ]
    }.each_pair do |password, entropy_and_rating|

      entropy = entropy_and_rating[0]
      rating  = entropy_and_rating[1]
      it %[%-20s     is %6s] % [password, rating] do
        password.password_strength.should == rating
      end

      it %[%-20s weighs %6d] % [password, entropy] do
        password.weighted_entropy.should == entropy
      end
    end
  end
end
