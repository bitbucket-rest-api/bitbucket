require 'spec_helper'

describe BitBucket::Validations::Required do
  class SpecClass
    include BitBucket::Validations::Required
  end

  let(:spec_class) { SpecClass.new }
  let(:params_with_blank) do
    {
      'title' => "mock_title",
      'source' => {
        'branch' => {
          'name' => ""
        }
      }
    }
  end

  describe '#parse_values' do
    it 'parses a colon separated string to an array' do
      result = spec_class.parse_values('hello:world')
      expectation = ['hello', 'world']

      expect(result).to eq(expectation)
    end
  end

  describe '#assert_required_values_present' do
    it 'raises an instance of BitBucket::Error::BlankValue if a required string is left blank' do
      expect do
        spec_class.assert_required_values_present(
          params_with_blank,
          'title',
          'source:branch:name'
        )
      end.to raise_error(
        BitBucket::Error::BlankValue,
        "The value for: 'source:branch:name', cannot be blank :("
      )
    end
  end
end
