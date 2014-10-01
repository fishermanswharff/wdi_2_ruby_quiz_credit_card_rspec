# Credit card spec 
require 'spec_helper'
require "rubygems"
require 'json'
require 'date'

require_relative '../lib/CreditCard.rb'

describe CreditCard do
  before(:all) do
    @cc = CreditCard.new('tmp/tmp.json')
  end

  it 'has json' do
    expect(@cc.cc).to be_a Hash
  end  

  it 'has a valid card number, that has the spaces and/or dashes stripped out' do
    expect(@cc.valid_number).to be_truthy
  end

  it 'has a valid card number accepted by the 4 major cc companies: AMEX, Visa, Mastercard, Discover' do
    expect(@cc.card_type).to eq("MasterCard")
  end

  it 'has valid expiration date that happens in the future' do
    expect(@cc.cc_expire).to be_truthy
  end

  # it 'has a valid CCV number' do

  # end

  # it 'has a valid Name' do

  # end

  # it 'has a valid zip code' do 

  # end

end