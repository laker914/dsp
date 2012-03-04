require 'test_helper'

class CalcsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "get employee " do
     employee = Employee.new(:empname => "Laker914",
                  :empidn => "2011029310391",
                  :sex => 1,
                  :job => 'CTO',
                  :bargain_begin => DateTime.parse("2012-01-01"),
                  :bargain_end => DateTime.parse("2012-12-31"),
                  :insure_base => 20000,
                  :provident_base => 4000,
                  :hukou => 1 ,
                  :company => 1)
    employee.save 
    calc = Calcs.new(:yearmonth => "201202")
    employees = calc.findEmployees(employee.bargain_begin , employee.bargain_end)
    assert_equal 1 , employees.size
    
    employees = calc.findEmployees(DateTime.parse("2014-03-01") , DateTime.parse("2012-02-01"))
    assert_equal 0 , employees.size
  end
end
