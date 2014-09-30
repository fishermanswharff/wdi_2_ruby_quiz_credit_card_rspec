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

end