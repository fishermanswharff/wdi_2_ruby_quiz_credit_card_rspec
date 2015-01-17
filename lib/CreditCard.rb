require 'pry'
require 'rubygems'
require 'json'
require 'date'

class CreditCard
    
  attr_accessor :cc_number,:card_type
  attr_reader :cc, :valid_card, :valid_number, :cc_name, :cc_expire, :cc_zip, :cc_ccv, :cc_ccv_valid, :cc_zip_valid

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
    ccv_valid?
    zip_valid?
    valid_name?
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
  end

  def ccv_valid?
    @cc_ccv = @cc_ccv.scan(/\d{3}/)[0]
  end

  def zip_valid? 
    @cc_zip = @cc_zip.scan(/[\d]{5}/)[0]
  end

  def valid_name?
    @cc_name = @cc_name.scan(/[A-Za-z]\w+/).join(" ")
  end

  def convert_to_array
    array = @cc_number.split('')
    array.map { |item| item.to_i }
  end

  def cc_num_pop
    array = convert_to_array
    @cc_popped_num = array.pop
    array
  end

  def cc_num_reverse
    cc_num_pop.reverse
  end

  def mutate_array
    array = cc_num_reverse
    product = []
    array.each_with_index { |item, index|  
      if index % 2 == 0
        item * 2 > 9 ? product << (item * 2) - 9 : product << item * 2
      else
        product << item
      end
    }
    product
  end

  def sum_array
    mutated = mutate_array
    mutated.reduce(:+) + @cc_popped_num
  end

  def luhn_truthy
    number = sum_array
    number % 10 == 0
  end

end

















