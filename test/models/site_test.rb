require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Name is mandatory' do
    site = Site.new
    assert_not site.save
  end

  test 'Not uniq' do
    site1 = Site.new(name: 'First')
    site1.save
    site2 = Site.new(name: 'First')
    assert_not site2.save
  end
end
