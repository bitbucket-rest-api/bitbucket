require 'spec_helper'

describe BitBucket::Privileges do
  subject { described_class.new }

  describe '#list_on_repo' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        "/1.0/privileges/mock_username/mock_repo/",
        { 'filter' => 'admin' },
        {}
      )
    end

    it 'sends a GET request for privileges granted on the given repo filtered with filter param' do
      subject.list_on_repo('mock_username', 'mock_repo', filter: "admin")
    end
  end

  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        "/1.0/privileges/mock_username/",
        { 'filter' => 'admin' },
        {}
      )
    end

    it "sends a GET request for privileges granted on all user's repositories filtered with filter param" do
      subject.list('mock_username', filter: "admin")
    end
  end
end
