$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "one_drive"
require "test/unit"
include Test::Unit::Assertions
Given("have drive list") do
  @drives = @one_drive.get_drives
  assert_equal @drives['value'].count > 0,true
end
When("visited the item url with drive id") do
  p '---------------ItemList-------------'
  p @one_drive.get_list({item_id: @drives['value'][0]['id']})
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("we should get the item list") do
  @one_drive.items
  # pending # Write code here that turns the phrase above into concrete actions
end

When("visited the item url without drive id") do
  @without_id_response= @one_drive.get_list
  assert_equal @without_id_response,"OneDrive URL : Item id is not valid"
end
Then("we should get the OneDriveExceptions") do
  assert_equal @without_id_response,"OneDrive URL : Item id is not valid"
end
When("visited the item url with its id {string}") do |string|
  # pending # Write code here that turns the phrase above into concrete actions
  response = @one_drive.download({item_id: string})
  assert_equal response.include?('error'),false
end

Then("we should get the item") do
  assert_equal @one_drive.item.include?('error'),false
end

When("we search for item {string}") do |string|
  result = @one_drive.search({search_text: 'dummy'})
  assert_equal result.include?('value'),true
end

Then("we should get the items") do
  assert_equal @one_drive.items.include?('error'),false
end
