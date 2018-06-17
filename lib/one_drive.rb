require "one_drive/version"
require "httparty"
module OneDrive
  class V1
    attr_accessor :client_id,:scope,:redirect_uri,:code,:token,:drives,:items,:current_drive,:current_item,:expires_in,:token_type
    def initialize(client_id,redirect_uri,scope='files.read')
      @client_id = client_id
      @scope = scope
      @redirect_uri = redirect_uri
    end
    def token_url
      # OAuth URI token
      # GET https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id={client_id}&scope={scope}
      #   &response_type=token&redirect_uri={redirect_uri}
      "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=#{@client_id}&scope=#{@scope}&response_type=token&redirect_uri=#{@redirect_uri}"
    end
    def code_url
      # Get code
      # https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id={client_id}&scope={scope}
      # &response_type=code&redirect_uri={redirect_uri}
      "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=#{@client_id}&scope=#{@scope}&response_type=code&redirect_uri=#{@redirect_uri}"

      #Get a new access token or refresh token
      # POST https://login.microsoftonline.com/common/oauth2/v2.0/token
      # Content-Type: application/x-www-form-urlencoded
      #
      # client_id={client_id}&redirect_uri={redirect_uri}&client_secret={client_secret}
      # &refresh_token={refresh_token}&grant_type=refresh_token
    end
    def get_drives type = nil,id=nil
      # GET /me/drives
      # GET /users/{userId}/drives
      # GET /sites/{siteId}/drives
      # GET /groups/{groupId}/drives
      case type
      when 'users'
        url = "https://graph.microsoft.com/v1.0/users/#{id}/drives"
      when 'sites'
        url = "https://graph.microsoft.com/v1.0/sites/#{id}/drives"
      when 'groups'
        url = "https://graph.microsoft.com/v1.0/groups/#{id}/drives"
      else
        url = "https://graph.microsoft.com/v1.0/me/drives"
      end
      @drives = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    def set_token token,expires_in=3600,token_type='bearer'
      # &token_type=bearer&expires_in=3600&scope=Files.Read
      @token = token
      @expires_in = expires_in
      @token_type = token_type
      true
    end
    def set_code code
      @code = code
    end
    def get_item
      # Get item
      # GET /drives/{drive-id}/items/{item-id}
      # GET /drives/{drive-id}/root:/{item-path}
      # GET /groups/{group-id}/drive/items/{item-id}
      # GET /groups/{group-id}/drive/root:/{item-path}
      # GET /me/drive/items/{item-id}
      # GET /me/drive/root:/{item-path}
      # GET /sites/{siteId}/drive/items/{itemId}
      # GET /sites/{siteId}/drive/root:/{item-path}
      # GET /users/{userId}/drive/items/{itemId}
      # GET /users/{userId}/drive/root:/{item-path}
    end
    def download
      # Download
      # GET /drives/{drive-id}/items/{item-id}/content
      # GET /groups/{group-id}/drive/items/{item-id}/content
      # GET /me/drive/root:/{item-path}:/content
      # GET /me/drive/items/{item-id}/content
      # GET /sites/{siteId}/drive/items/{item-id}/content
      # GET /users/{userId}/drive/items/{item-id}/content
      # GET /drive/items/{item-id}/content?format={format}
      # GET /drive/root:/{path and filename}:/content?format={format}
    end
    def get_list
      # Find Children
      # GET /drives/{drive-id}/items/{item-id}/children
      # GET /groups/{group-id}/drive/items/{item-id}/children
      # GET /me/drive/items/{item-id}/children
      # GET /sites/{site-id}/drive/items/{item-id}/children
      # GET /users/{user-id}/drive/items/{item-id}/children
    end
    def set_headers
      {"Content-Type"=> 'application/json',"Authorization"=>"bearer #{@token}"}
    end
    
  end
end
