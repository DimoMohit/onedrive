require "one_drive/version"
require "httparty"
module OneDrive
  class OneDriveExceptions < StandardError
    attr_reader :detail
    def initialize(message="OneDriveExceptions", detail="")
      @detail = detail
      super(message)
    end
  end

  class V1
    attr_accessor :client_id,:scope,:redirect_uri,:code,:token,:drives,:items,:current_drive,
    :current_item,:expires_in,:token_type,:my_drive,:recent_drive,:special_drive,:special_items,
    :item
    def initialize(client_id,redirect_uri,scope='files.read')
      @client_id = client_id
      @scope = scope
      @redirect_uri = redirect_uri
    end
    def base_api_url
      "https://graph.microsoft.com/v1.0"
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
    # Get a drive by ID
    def get_drive drive_id
      url = base_api_url + "/drives/#{drive_id}"
      @drives = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # Get a user's OneDrive
    def get_users_drive id_or_user_principal_name
      url = base_api_url + "/users/#{id_or_user_principal_name}/drive"
      @drives = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # Get a current user's OneDrive
    def get_my_drive
      url = base_api_url + "/me/drive"
      @my_drive = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # Get the document library for a site
    def get_library_for_site site_id
      url = base_api_url + "/sites/#{site_id}/drive"
      @drives = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # Get a special folder by name
    def get_special_folder_by_name name
      url = base_api_url + "/me/drive/special/#{name}"
      @special_drive = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # Get children of a special folder
    def get_children_of_special_folder name
      url = base_api_url + "/me/drive/special/#{name}/children"
      @special_items = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # List items shared with the signed-in user
    def items_shared_with_me
      url = base_api_url + "/me/drive/sharedWithMe"
      @shared_items = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    # GET /drives/{remoteItem-driveId}/items/{remoteItem-id}

    def recent
      url = base_api_url + '/me/drive/recent'
      @recent_drive = JSON.parse(HTTParty.get(url,headers: set_headers).body)
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
    def get_item options={}
      url = "https://graph.microsoft.com/v1.0"
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
      if options.include? :drive_id
        url = "/drives/#{options[:drive_id]}/"
      elsif options.include? :group_id
        url = "/groups/#{options[:group_id]}/"
      elsif options.include? :site_id
        url = "/sites/#{options[:site_id]}/"
      elsif options.include? :user_id
        url = "/users/#{options[:user_id]}/"
      else
        url = "/me/drive/"
      end
      if options.include? :item_id
        url = url + "items/#{options[:item_id]}"
      elsif options.include? :item_path
        url = url + "root:/#{options[:item_path]}"
      else
        return "OneDrive URL is not valid"
      end
      @items = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    def search options ={}
      if options.include? :drive_id
        # GET /drives/{drive-id}/root/search(q='{search-text}')
        url = base_api_url + "/drives/#{options[:drive_id]}/root/search(q='#{options[:search_text]}')"
      elsif options.include? :group_id
        # GET /groups/{group-id}/drive/root/search(q='{search-text}')
        url = base_api_url + "/groups/#{options[:group_id]}/drive/root/search(q='#{options[:search_text]}')"
      elsif options.include? :site_id
        # GET /sites/{site-id}/drive/root/search(q='{search-text}')
        url = base_api_url + "/sites/#{options[:site_id]}/drive/root/search(q='#{options[:search_text]}')"
      elsif options.include? :user_id
        # GET /users/{user-id}/drive/root/search(q='{search-text}')
        url = base_api_url + "/users/#{options[:user_id]}/drive/root/search(q='#{options[:search_text]}')"
      else
        # GET /me/drive/root/search(q='{search-text}')
        url = base_api_url + "/me/drive/root/search(q='#{options[:search_text]}')"
      end
      @items = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    def download options ={}
      # Download
      # GET /drives/{drive-id}/items/{item-id}/content
      # GET /groups/{group-id}/drive/items/{item-id}/content
      # GET /me/drive/root:/{item-path}:/content
      # GET /me/drive/items/{item-id}/content
      # GET /sites/{siteId}/drive/items/{item-id}/content
      # GET /users/{userId}/drive/items/{item-id}/content
      # GET /drive/items/{item-id}/content?format={format}
      # GET /drive/root:/{path and filename}:/content?format={format}
      url = "https://graph.microsoft.com/v1.0"
      if options.include? :drive_id
        url = url + "/drives/#{options[:drive_id]}/"
      elsif options.include? :group_id
        url = url + "/groups/#{options[:group_id]}/drive/"
      elsif options.include? :site_id
        url = url + "/sites/#{options[:site_id]}/drive/"
      elsif options.include? :user_id
        url = url + "/users/#{options[:user_id]}/drive/"
      else
        url = url + "/me/drive/"
      end
      if options.include? :item_id
        url = url + "items/#{options[:item_id]}/content"
      elsif options.include? :item_path
        url = url + "root:/#{options[:item_path]}:/content"
      else
        return "OneDrive URL : Item id is not valid"
      end
      if options.include? :format
        url = url + "?format=#{options[:format]}"
      end
      @current_item = @item = (HTTParty.get(url,headers: set_headers).body)
    end
    def get_list options={}
      url = "https://graph.microsoft.com/v1.0"
      p '------------------------'
      # Find Children
      # GET /drives/{drive-id}/items/{item-id}/children
      # GET /groups/{group-id}/drive/items/{item-id}/children
      # GET /me/drive/items/{item-id}/children
      # GET /sites/{site-id}/drive/items/{item-id}/children
      # GET /users/{user-id}/drive/items/{item-id}/children
      if options.include? :drive_id
        url = url + "/drives/#{options[:drive_id]}/"
      elsif options.include? :group_id
        url = url + "/groups/#{options[:group_id]}/"
      elsif options.include? :site_id
        url = url + "/sites/#{options[:site_id]}/"
      elsif options.include? :user_id
        url = url + "/users/#{options[:user_id]}/"
      else
        url = url + "/me/drive/"
      end
      if options.include? :item_id
        url = url + "items/#{options[:item_id]}/children"
      else
        return "OneDrive URL : Item id is not valid"
      end
      p url
      @items = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    end
    def set_headers
      {"Content-Type"=> 'application/json',"Authorization"=>"bearer #{@token}"}
    end

  end
end
