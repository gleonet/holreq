require 'test_helper'

class LegalDayTest < ActiveSupport::TestCase
  setup do
    @legal_day = legal_days(:one)
    @creation_params = { name: @legal_day.name,
                         year: @legal_day.year,
                         start_date: @legal_day.start_date,
                         site_id: @legal_day.site_id
    }
  end

  test "Name is mandatory" do
    legal_day = LegalDay.new(@creation_params)
    legal_day.name = nil
    assert_not legal_day.save
  end

  test "Year is mandatory" do
    legal_day = LegalDay.new(@creation_params)
    legal_day.year = nil
    assert_not legal_day.save
  end

  test "Start Date is mandatory" do
    legal_day = LegalDay.new(@creation_params)
    legal_day.start_date = nil
    assert_not legal_day.save
  end

  test "Site is mandatory" do
    legal_day = LegalDay.new(@creation_params)
    legal_day.site_id = nil
    assert_not legal_day.save
  end
end
