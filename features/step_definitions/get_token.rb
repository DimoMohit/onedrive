$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "one_drive"
require "test/unit"
include Test::Unit::Assertions

Given("client_id, redirect_uri and scope is known") do
  @one_drive = OneDrive::V1.new('000000004422588C','http://app.dimomohit.com/drive/one-drive')
  # "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=000000004422588C&scope=files.read&response_type=token&redirect_uri=http://app.dimomohit.com/drive/one-drive"
  assert_equal !@one_drive.nil?,true
end

When("visited the authorize uri with response_type as code") do
  assert_equal (/^https\:\/\/login\.microsoftonline\.com\/common\/oauth2\/v2\.0\/authorize\?client\_id\=[a-zA-Z0-9]+\&scope\=[a-zA-Z0-9.]+\&response\_type\=code\&redirect\_uri\=[a-zA-Z0-9:\/\/]+/ =~ @one_drive.code_url) >=0,true
end

Then("we should get the token") do
  p @one_drive.token_url
  assert_equal (/^https\:\/\/login\.microsoftonline\.com\/common\/oauth2\/v2\.0\/authorize\?client\_id\=[a-zA-Z0-9]+\&scope\=[a-zA-Z0-9.]+\&response\_type\=token\&redirect\_uri\=[a-zA-Z0-9:\/\/]+/ =~ @one_drive.token_url) >=0,true
end

When("visited the authorize uri with response_type as refresh_token") do
  assert_equal true,true
  #pending
end
