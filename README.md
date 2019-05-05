# PhoneNumberConverter

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phone_number_converter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install phone_number_converter

## Usage

In your code, do like this:

```ruby
  PhoneNumberConverter.configure do |config|
    config.to_global_converter = {
      '090' => '+8190',
      '080' => '+8180',
      '070' => '+8170',
      '050' => '+8150'
    }
    config.to_domestic_converter = {
      '+8190' => '090',
      '+8180' => '080',
      '+8170' => '070',
      '+8150' => '050'
    }
    config.domestic_phone_number_regexp = /\A(090|080|070|050)\d{8}\z/
    config.global_phone_number_regexp = /\A(\+8190|\+8180|\+8170|\+8150)\d{8}\z/
  end
```

```ruby
  class Klass
    using PhoneNumberConverter
    
    def send_message
      domestic_mobile_number = '09011111111'
      MessageClient.new.send_message(domestic_mobile_number.to_global)
    end
  end
  
  class MessageClient
    def send_message(global_phone_number)
      # some implementation
    end
  end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ayumitamai97/phone_number_converter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
