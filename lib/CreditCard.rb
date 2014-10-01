require 'pry'
require 'rubygems'
require 'json'
require 'date'

class CreditCard
    
  attr_accessor :cc_number,:card_type
  attr_reader :cc, :valid_card, :valid_number, :cc_name, :cc_expire, :cc_zip, :cc_ccv, :cc_number

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
    @cc_number.gsub!(/[ -]+/,"")
    @is_valid_card_number = @cc_number.scan(/^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$/)
    @is_valid_card_number.length == 1 ? @valid_number = true : @valid_number = false
    valid_type?
  end

  def valid_type?
    string = @is_valid_card_number.join('')
    visa = string.scan(/^4[0-9]{12}(?:[0-9]{3})/).length == 1 ? @card_type = "Visa" : false
    discover = string.scan(/^6(?:011|5[0-9]{2})[0-9]{12}/).length == 1 ? @card_type = "Discover" : false
    master_card = string.scan(/^5[1-5](?:[0-9]{14})/).length == 1 ? @card_type = "MasterCard" : false
    amex = string.scan(/^3[47][0-9]{13}/).length == 1 ? @card_type = "American Express" : false
  end

  def cc_check_date
    month = @cc_expire_month.scan(/[\d]{1,2}/)
    year = @cc_expire_year.scan(/[\d]{4}/)
    expiry_date = Date.new(year[0].to_i,month[0].to_i)
    now = DateTime.now
    cc_date_check = now <=> expiry_date
    cc_date_check == -1 ? @cc_expire = true : @cc_expire = false
    binding.pry
  end

end
