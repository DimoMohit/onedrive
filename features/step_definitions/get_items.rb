$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "one_drive"
require 'minitest/spec'
require 'minitest/autorun'

include Minitest::Assertions
@one_drive = OneDrive::V1.new('000000004422588C','http://app.dimomohit.com/drive/one-drive')
When("visited the item url with drive id") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("we should get the item list") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("visited the item url without drive id") do
  pending # Write code here that turns the phrase above into concrete actions
end
