$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "one_drive"
require 'minitest/spec'
require 'minitest/autorun'

include Minitest::Assertions
Given("client_id, redirect_uri and scope is known") do
  @one_drive = OneDrive::V1.new('000000004422588C','http://app.dimomohit.com/drive/one-drive')
  # "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=000000004422588C&scope=files.read&response_type=token&redirect_uri=http://app.dimomohit.com/drive/one-drive"
  assert !@one_drive.nil?
end

When("visited the authorize uri with response_type as code") do
  assert (/^https\:\/\/login\.microsoftonline\.com\/common\/oauth2\/v2\.0\/authorize\?client\_id\=[a-zA-Z0-9]+\&scope\=[a-zA-Z0-9.]+\&response\_type\=code\&redirect\_uri\=[a-zA-Z0-9:\/\/]+/ =~ @one_drive.code_url) >=0
end

Then("we should get the token") do
  p @one_drive.token_url
  assert (/^https\:\/\/login\.microsoftonline\.com\/common\/oauth2\/v2\.0\/authorize\?client\_id\=[a-zA-Z0-9]+\&scope\=[a-zA-Z0-9.]+\&response\_type\=token\&redirect\_uri\=[a-zA-Z0-9:\/\/]+/ =~ @one_drive.token_url) >=0
end

When("visited the authorize uri with response_type as refresh_token") do
  assert true
  #pending
end
