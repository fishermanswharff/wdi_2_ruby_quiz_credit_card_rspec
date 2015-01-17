# Credit card spec 
require 'spec_helper'
require "rubygems"
require 'json'
require 'date'
require 'pry'

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
    expect(@cc.card_type).to eq("Visa")
  end

  it 'has valid expiration date that happens in the future' do
    expect(@cc.cc_expire).to be_truthy
  end

  it 'has a valid CCV number' do
    expect(@cc.cc_ccv).to eq("234")
  end
  
  it 'has a valid zip code' do 
    expect(@cc.cc_zip).to eq("02138")
  end

  it 'has a valid name' do 
    expect(@cc.cc_name).to eq("Jason Wharff")
  end

  describe '#convert_to_array' do
    it 'converts the cc number string into an array of digits' do
      expect(@cc.convert_to_array).to eq [4,0,2,4,0,0,7,1,6,6,1,7,5,1,4,0]
    end
  end

  describe '#pop' do
    it 'removes the last item in the array and saves it' do
      expect(@cc.cc_num_pop).to eq [4,0,2,4,0,0,7,1,6,6,1,7,5,1,4]
    end
  end

  describe '#cc_num_reverse' do
    it 'reverses the array and returns the reversed array' do
      expect(@cc.cc_num_reverse).to eq [4,1,5,7,1,6,6,1,7,0,0,4,2,0,4]
    end
  end

  describe '#mutate_array' do
    it 'multiplies the odd positioned numbers (0+1 index), subtracts 9 if the product is greater than 9' do
      expect(@cc.mutate_array).to eq [8,1,1,7,2,6,3,1,5,0,0,4,4,0,8]
    end
  end

  describe '#sum_array' do
    it 'sums the values of the entire array plus the checksum' do
      expect(@cc.sum_array).to eq 50
    end
  end

  describe '#luhn_truthy' do
    it 'returns a boolean based on the sum' do
      expect(@cc.luhn_truthy).to eq true
    end
  end
end







