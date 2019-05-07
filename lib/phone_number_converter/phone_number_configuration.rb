module PhoneNumberConverter
  class PhoneNumberConfiguration
    attr_accessor :to_global_converter
    attr_accessor :to_domestic_converter
    attr_accessor :domestic_phone_number_regexp
    attr_accessor :global_phone_number_regexp
  end
end
