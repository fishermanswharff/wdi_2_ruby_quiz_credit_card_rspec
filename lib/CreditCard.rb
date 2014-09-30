require 'pry'
require 'rubygems'
require 'json'

class CreditCard
  attr_reader :cc

  def initialize(filename)
    @cc = JSON.parse( IO.read(filename) )
  end

end
