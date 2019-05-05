require 'spec_helper'

RSpec.describe PhoneNumberConverter do
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

  class Klass
    using PhoneNumberConverter

    def self.globalize(phone_number)
      phone_number.to_global
    end

    def self.localize(phone_number)
      phone_number.to_domestic
    end
  end

  it '国番号付きの電話番号を正しく国内電話番号に変更できる' do
    expect(Klass.localize('+819011111111')).to eq '09011111111'
  end

  it '国内電話番号を正しく国番号付きの電話番号に変更できる' do
    expect(Klass.globalize('09011111111')).to eq '+819011111111'
  end

  it '無効な国番号付きの電話番号を引数に渡すと例外を発生させる' do
    expect { Klass.localize('819011111111') }.to raise_error PhoneNumberConverter::InvalidPhoneNumberError
  end

  it '無効な国内電話番号を引数に渡すと例外を発生させる' do
    expect { Klass.globalize('19011111111') }.to raise_error PhoneNumberConverter::InvalidPhoneNumberError
  end
end
