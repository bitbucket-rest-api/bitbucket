require 'spec_helper'

describe BitBucket::Error::BlankValue do
  context 'an event that does not exist is passed in BitBucket::Repos::Webhooks#create or BitBucket::Repos::Webhooks#edit' do
    it 'should raise an error with a message' do
      expect { raise described_class.new('required_key') }.
      to raise_error(
        BitBucket::Error::BlankValue,
        "The value for: 'required_key', cannot be blank :("
      )
    end
  end
end
