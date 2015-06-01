[![Gem Version](https://badge.fury.io/rb/yandex_domains.svg)](http://badge.fury.io/rb/yandex_domains)
[![Build Status](https://travis-ci.org/beydogan/yandex_domains.svg)](https://travis-ci.org/beydogan/yandex_domains)
[![Code Climate](https://codeclimate.com/github/beydogan/yandex_domains/badges/gpa.svg)](https://codeclimate.com/github/beydogan/yandex_domains)
[![Test Coverage](https://codeclimate.com/github/beydogan/yandex_domains/badges/coverage.svg)](https://codeclimate.com/github/beydogan/yandex_domains/coverage)
# YandexDomains

Ruby client for [Yandex.Mail for Domains API](https://tech.yandex.com/domain). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yandex_domains'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex_domains
    
## Documentation

http://www.rubydoc.info/github/beydogan/yandex_domains/

## Usage

This client works with only **Administrator** access. More details about Administrator user is [here](https://tech.yandex.com/domain/doc/concepts/termin-docpage/).  In order to use the client and API features, the PDD token is required. You can get a PDD token on the [token management](https://pddimp.yandex.ru/api2/admin/get_token)  page by entering a domain name that has already been verified.

**Initialize a client**
```ruby
client = YandexDomains::Client.new(pdd_token)
```

## Usage Examples
After configuring a client, you can do the followings.

**Signing up a domain**
```ruby
client.connect_domain('google.com')
```

**Adding a mailbox for a domain**
```ruby
client.add_mailbox('google.com', 'hi', 'strongpassword')
```

**Deleting a mailbox on a domain**
```ruby
client.delete_mailbox('google.com', 'hi')
```

[More examples here](http://www.rubydoc.info/github/beydogan/yandex_domains/)

## Contributing

1. Fork it ( https://github.com/beydogan/yandex_domains/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
