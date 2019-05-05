require "phone_number_converter/version"

class PhoneNumberConfiguration
  attr_accessor :to_global_converter
  attr_accessor :to_domestic_converter
  attr_accessor :domestic_phone_number_regexp
  attr_accessor :global_phone_number_regexp
end

module PhoneNumberConverter
  class InvalidPhoneNumberError < StandardError;
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @config ||= PhoneNumberConfiguration.new
  end

  def self.domestic_phone_number_regexp
    configuration.domestic_phone_number_regexp
  end

  def self.global_phone_number_regexp
    configuration.global_phone_number_regexp
  end

  def self.to_global_converter
    configuration.to_global_converter
  end

  def self.to_domestic_converter
    configuration.to_domestic_converter
  end

  def self.domestic_phone_number_prefix
    Regexp.union(to_global_converter.keys.map { |str| Regexp.new(str) }).freeze
  end

  def self.global_phone_number_prefix
    Regexp.union(to_domestic_converter.keys.map { |str| Regexp.new(Regexp.escape str) }).freeze
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
