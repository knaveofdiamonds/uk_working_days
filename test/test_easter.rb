require 'helper'

class TestEaster < Test::Unit::TestCase
  should "be on the 4th of April in 2010" do
    assert_equal Date.new(2010,4,4), Date.easter(2010)
  end
end
