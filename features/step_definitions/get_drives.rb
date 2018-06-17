$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "one_drive"
require "test/unit"
include Test::Unit::Assertions
Given("we have a valid token") do
  @one_drive = OneDrive::V1.new('000000004422588C','http://app.dimomohit.com/drive/one-drive')
  token="EwAoA8l6BAAURSN/FHlDW5xN74t6GzbtsBBeBUYAAfxekYa3bkjIswV7lc/37VOH6siXgkpgANl1eFK/GbMz6zu3W4hUZf5D0KNCTUQgaBPOI9yg99mUPq84qhmofEUXGV445E0iq6aSLDAfPDjd2oi6Fknd%2brEGFDrr32N%2b61i8Tfofyw40RnNCxapklKIX4RcrxHaOKtGy0GeUBO6kRit2DpGY%2bU8yDBUKdoxYp9YoJ5f3QCe2jRm5jwn/zkOo4J5XhLb8KxOGdP1HXOn48iTCc15YOSiRszm85%2bZ014f3dOmtBvJ3JCI1EJh3k9KwcCEUx6IIUfoWmgPR/PbLvu5gChpSMzXNhrjmMf7mEixfq6QBKJSL2%2bzeRBoukycDZgAACOuUdmf4ejc8%2bAHYrDjvi2wkM3vySI80btK%2btPtXiKaugJoQzHe3XQA3yT0QLUzaDE590c1wNRdHpWw48Bh1yEW5PBGmZ%2bvRJ5Ddz4mm0HZYdal03AFdfBGRXb2bzqc5USYLUFja3AdET9/8oN9RwEjZRG3uAbTwUWkdJaeIGHU/CzPuGUXQEl%2bBYnce8/V2zcNG6AAPzT7pTnjjxlO7zTEXAwcriMQwPrwoPwWNKS4z06aZgjzx8ROHlSyfFSzd22CPaV4%2bd108m5PPqMWvv1BfTSGDc8qXt0%2by8iG8sdu3UmO6NHqWQnFYkNdcqMisgc2F%2bKzGa1tEzHjKDYBt%2bp2GQgVLItlEcR3vmagnyBroSCoY6HmEW8Ep0r3MZYsGyn9NChKQ50G98fWVf8RsHm0V/NRy6gXgBZfTncEhzgLplectfK3/sHTWaMCVz9vq9NpuFPEyOh%2bfqJWJG9jnenujh9P6NAtk/SH4dSd3nM9p%2bKBFCtAJNN6NEVBZZOSJYY%2b1XEXW/sb1I961SDKtU8eZgAX7Extfv5/yOhSnf31ptTAQg6BFzifSqdiAVPqKvCtzwGVBZjwXqE6Du72PYSS68nR1Pg%2bamFuus740JzNzYftc7W96iRd6O2mYpfZPr329cTT8La6Ip1fMGH/Wr6hrCcqr1HVU/T1iUcZ4VrSBfEAlAg%3d%3d"
  assert_equal @one_drive.set_token(token,3600),true
end

When("visited the drive url with response_token is header") do
  @drives = @one_drive.get_drives
  assert_equal @drives['value'].count > 0,true
end

Then("we should get the drive list") do
  p @one_drive.drives['value']
  assert_equal @drives['value'].count > 0,true
end
