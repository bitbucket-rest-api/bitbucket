require 'spec_helper'

describe BitBucket::Invitations do
  subject { described_class.new }

  describe '#invitations' do
    before do
      expect(subject).to receive(:request).with(
        :post,
        "/1.0/invitations/mock_username/mock_repo/mock_email_address",
        { :permission => 'read' },
        {}
      )
    end

    it 'sends a POST request for an invitation belonging to the given repo' do
      subject.invite('mock_username', 'mock_repo', 'mock_email_address', 'read')
    end
  end
end

