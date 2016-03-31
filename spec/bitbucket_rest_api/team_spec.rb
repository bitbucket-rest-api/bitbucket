require 'spec_helper'

describe BitBucket::Team do
  let(:team) { BitBucket::Team.new }

  describe '.list' do
    before do
      expect(team).to receive(:request).with(
        :get,
        '/2.0/teams/?role=member',
        {},
        {}
      )
    end

    it 'should send a GET request for the teams of which the user is a member' do
      team.list(:member)
    end
  end
end
