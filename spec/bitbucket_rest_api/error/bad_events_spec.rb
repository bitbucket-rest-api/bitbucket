require 'spec_helper'

describe BitBucket::Error::BadEvents do
  context 'an event that does not exist is passed in BitBucket::Repos::Webhooks#create or BitBucket::Repos::Webhooks#edit' do
    it 'should raise an error with a message' do
      expect { raise described_class.new('bad:event') }.
      to raise_error(BitBucket::Error::BadEvents, "The event: 'bad:event', does not exist :(")
    end
  end
end
