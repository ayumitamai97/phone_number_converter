require 'phone_number_converter/phone_number_configuration'

module PhoneNumberConverter
  class InvalidPhoneNumberError < StandardError; end

  class << self
    def configure
      yield configuration
    end

    def configuration
      @config ||= PhoneNumberConfiguration.new
    end

    def domestic_phone_number_regexp
      configuration.domestic_phone_number_regexp
    end

    def global_phone_number_regexp
      configuration.global_phone_number_regexp
    end

    def to_global_converter
      configuration.to_global_converter
    end

    def to_domestic_converter
      configuration.to_domestic_converter
    end

    def domestic_phone_number_prefix
      Regexp.union(to_global_converter.keys.map { |str| Regexp.new(str) }).freeze
    end

    def global_phone_number_prefix
      Regexp.union(to_domestic_converter.keys.map { |str| Regexp.new(Regexp.escape str) }).freeze
    end
  end

  refine String do

    def to_global
      validate_domestic
      gsub(PhoneNumberConverter.domestic_phone_number_prefix, PhoneNumberConverter.to_global_converter)
    end

    def to_domestic
      validate_global
      gsub(PhoneNumberConverter.global_phone_number_prefix, PhoneNumberConverter.to_domestic_converter)
    end

    private

    def validate_domestic
      unless self.match?(PhoneNumberConverter.domestic_phone_number_regexp)
        raise InvalidPhoneNumberError, "'#{self}' is not a valid domestic phone number"
      end
    end

    def validate_global
      unless self.match?(PhoneNumberConverter.global_phone_number_regexp)
        raise InvalidPhoneNumberError, "'#{self}' is not a valid global phone number"
      end
    end
  end
end

