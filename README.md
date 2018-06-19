# OneDrive

Welcome to your new gem one_drive!
You can use this gem to list your Microsoft OneDrive drives and read and write them.
To experiment with that code, run `bin/console` for an interactive prompt.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'one_drive'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install one_drive

## Usage

1. Initialize

    ` one_drive = OneDrive::V1.new(client_id, redirect_uri, scope) `

2. Generate code url to get refresh_token

    ` one_drive.code_url `

    Or Directly generate token url

    ` one_drive.token_url `

    Visit the url to generate the token

3. Set your token which you get on visiting the above url

    ` one_drive.set_token token `

    Note: only token is required you can leave expires_in and token_type as blank for expires_in=3600 and token_type='bearer'

4. List out all your drives

    ` drives = @one_drive.get_drives `

    ` drives = @one_drive.get_drives('users',id) `

    ` drives = @one_drive.get_drives('sites',id) `

    ` drives = @one_drive.get_drives('groups',id) `

    After calling the last function you can fetch last drive list which you fetched by calling

    ` one_drive.drives `
5. Search

    ` one_drive.search(options)`

    Here options is hash with `:search_text` as required key (this is used as search text)
    Optional keys are
    `:drive_id`
    `:group_id`
    `:site_id`
    `:user_id`

    Example: Say I want to search file name 'dummy' in a drive (123) then we need to pass options as
    ` one_drive.search({search_text: 'dummy',drive_id: '123'}) `

6. Download Item
    ` one_drive.download(options)`
    Here options is hash with `:item_id` or `:item_path` is required key (this is used as search item)
    Optional keys are
    `:drive_id`
    `:group_id`
    `:site_id`
    `:user_id`

7. Recent Drive
    ` one_drive.recent `

8. Special Folder
    ` one_drive.get_special_folder_by_name('Photos') `

9. My Drive
    ` one_drive.my_drive `

10. Items Shared with me
    ` one_drive.items_shared_with_me `

11. Get Item
    ` one_drive.get_item options `
    Here options is hash with `:item_id` or `:item_path` is required key (this is used as search item)
    Optional keys are
    `:drive_id`
    `:group_id`
    `:site_id`
    `:user_id`

Other Functions are

    `one_drive.get_children_of_special_folder(name)`

    `one_drive.get_children_of_special_folder()`

Once you have visited the functions the result is stored in attributes
    `:client_id,:scope,:redirect_uri,:code,:token,:drives,:items,:current_drive,
    :current_item,:expires_in,:token_type,:my_drive,:recent_drive,:special_drive,:special_items,
    :item`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DimoMohit/one_drive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OneDrive project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/DimoMohit/one_drive/blob/master/CODE_OF_CONDUCT.md).
