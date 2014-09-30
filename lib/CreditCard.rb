require 'pry'
require 'rubygems'
require 'json'
require 'date'

class CreditCard
  attr_reader :cc, :valid_number, :cc_number, :cc_name, :cc_expire, :cc_zip, :cc_ccv

  def initialize(filename)
    @cc = JSON.parse( IO.read(filename) )
    @cc_number = @cc["number"]
    @cc_name = @cc["name"]
    @cc_expire_month = @cc["expire_month"]
    @cc_expire_year = @cc["expire_year"]
    @cc_zip = @cc["zip"]
    @cc_ccv = @cc["CCV"]
    cc_num_check
    cc_check_date
  end

  def cc_num_check
    @cc_number.length == 16 ? @valid_number = true : @valid_number = false
  end

  def cc_check_date

  end

end
