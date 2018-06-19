$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "one_drive"
require "test/unit"
include Test::Unit::Assertions
Given("we have a valid token") do
  @one_drive = OneDrive::V1.new('000000004422588C','http://app.dimomohit.com/drive/one-drive')
  token="EwAoA8l6BAAURSN/FHlDW5xN74t6GzbtsBBeBUYAAboFO3Xu8r7Nvt8vvWO7au8icrHeCJbZaZfYI5HsAbugVgYc46j3wnpxiQWJNCjhUNqpktQ/staw4WKd6Io2UThpe3TpIZpJVy%2bYW/1ZfPXnQrkIbJaHIS30n3%2bnMKttWshNKAqD1nNuGSeNy2tdmMS4JZfxoO5a2QvsZj0C6/WrYsByixepVRMNstka3Q0NcYOVF7AO7p%2b7M59mCM94EHqxavZUZGOX5daXyuYlMIA%2bHuj29JlwtUVrzFYt8b9w/1VVy8Xf5xnSs1U2BsoPQwp/ChQ5Bp3F2tTNA/TKUJ8%2bNkJ%2b4S2y4cg72254hf/2vOHo8KSqAs2/Ey96NbrdIQ8DZgAACKFLfKt3KBf6%2bAEZjoKvfoXrfCxVGPcEgjNJRmilZOX9Sp%2b7IHf6LYSODHY8rc4DrrFR/sB2rJxe6w6Xm23aGc79RzPjkNmlBndhX6y29yl1w2e%2bouSh2zgjXchOm%2b0WHAZzqc1c79RR/2jPlcR2FRhS6u1F3MZZTpY%2b5n4hvTH5xHuaYZ5SZMIJIJ/5rMNsxkc16zByZlb9TtSyk2X5NU2TnzcR1e3eNI8nadrg8Vyt10RpDIMwPKxVkyTaTLJIpf5B/Izj5i5ayMeO/jXdYqm6jNifmbVNU0A7VAadLM0Kg/72tnz5Tws93DZpq1C2h7KvYtrK4qJkCwxHfuwry5XaDZzTAE44rEocxwPtBAI5Oe6nIhCVW%2b01yTkG6WByleRc3Qk9GRjM8jqgabOz0Lf7MH%2b3bvJiyAr/BSo%2bOW%2bNoGEST3NPY2eodREerL45ppiyWCGrJxeZAoQVvID1JP8EoOyVyVxLT9HL1Qx9Iu%2bGtuVYLOQ7YVGrwUSQ57F985IHTSeiujLaFohpWFugyUlx/quTk2KY%2bRnz97rSNQeijKXndV1AiqcKhcXgHynP9pwqcmb93Q2X9RIjm6mpdwbZEcXRfZ8uy8X80ymCmSWuIIhP7IHCZPCOIigtGRPMkJm0m9ZYUY1m5R15bqfIVMblZo51X2s3WKRleDyWRJei7u4lAg%3d%3d"
  assert_equal @one_drive.set_token(token,3600),true
end

When("visited the drive url with response_token is header") do
  @drives = @one_drive.get_drives
  assert_equal @drives['value'].count > 0,true
end

Then("we should get the drive list") do
  assert_equal @drives['value'].count > 0,true
end

When("visited the my drive with response_token is header") do
  # pending # Write code here that turns the phrase above into concrete actions
  @my_drive = @one_drive.get_my_drive
  assert_equal @my_drive.include?('error'),false
end

When("visited the recent drive with response_token is header") do
  # pending # Write code here that turns the phrase above into concrete actions
  @recent_drive = @one_drive.recent
  assert_equal @recent_drive.include?('error'),false
end

When("visited the document drive with response_token is header") do
  # pending # Write code here that turns the phrase above into concrete actions
  @special_drive = @one_drive.get_special_folder_by_name 'Photos'
  assert_equal @special_drive.include?('error'),false
end

Then("we should get my drive") do
  assert_equal @one_drive.my_drive.nil?,false
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("we should get the recent drive") do
  assert_equal @one_drive.recent_drive.nil?,false
  #pending # Write code here that turns the phrase above into concrete actions
end

Then("we should get the special drive") do
  assert_equal @one_drive.special_drive.nil?,false
  #pending # Write code here that turns the phrase above into concrete actions
end
