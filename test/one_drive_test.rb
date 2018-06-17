require "test_helper"

class OneDriveTest < ActiveSupport::TestCase
  include Test::Unit::Assertions
  setup do
    @one_drive = OneDrive::V1.new('000000004422588C','http://app.dimomohit.com/drive/one-drive')
  end
  def test_that_it_has_a_version_number
    refute_nil ::OneDrive::VERSION
  end
  def test_that_it_generates_token_url
    assert (/^https\:\/\/login\.microsoftonline\.com\/common\/oauth2\/v2\.0\/authorize\?client\_id\=[a-zA-Z0-9]+\&scope\=[a-zA-Z0-9.]+\&response\_type\=token\&redirect\_uri\=[a-zA-Z0-9:\/\/]+/ =~ @one_drive.token_url) >=0
  end
  def test_that_it_generates_code_url
    assert (/^https\:\/\/login\.microsoftonline\.com\/common\/oauth2\/v2\.0\/authorize\?client\_id\=[a-zA-Z0-9]+\&scope\=[a-zA-Z0-9.]+\&response\_type\=code\&redirect\_uri\=[a-zA-Z0-9:\/\/]+/ =~ @one_drive.code_url) >=0
  end
  def test_that_it_can_get_list_of_drives

  end
  def test_that_it_generates_downloads_items

  end
end
