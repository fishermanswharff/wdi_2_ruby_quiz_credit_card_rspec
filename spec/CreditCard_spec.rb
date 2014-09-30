# Credit card spec 
require 'spec_helper'
require "rubygems"
require "json"
require_relative '../lib/CreditCard.rb'

describe CreditCard do
  before(:all) do
    @cc = CreditCard.new('tmp/tmp.json')
  end

  it 'has json' do
    expect(@cc.cc).to be_a Hash
  end  

  it 'has a valid card number' do
    expect(@cc.valid_number).to be_truthy
  end

  it 'has valid expiration date' do
    expect(@cc.cc_expire).to be_truthy
  end

  # it 'has a valid CCV number' do

  # end

  # it 'has a valid Name' do

  # end

  # it 'has a valid zip code' do 

  # end

end