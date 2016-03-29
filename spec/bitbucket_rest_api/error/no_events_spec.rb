require 'spec_helper'

describe BitBucket::Error::NoEvents do
  context 'no events are passed in BitBucket::Repos::Webhooks#create or BitBucket::Repos::Webhooks#edit' do
    it 'should raise an error with a message' do
      expect { raise described_class.new }.
      to raise_error(BitBucket::Error::NoEvents, "At least one event is required, none given :(")
    end
  end
end
