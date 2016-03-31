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
      ).and_return({"values" => ['team1', 'team2', 'team3']})
    end

    context 'without a block' do
      it 'sends a GET request for the teams of which the user is a member' do
        team.list(:member)
      end
    end

    context 'with a block' do
      it 'sends a GET request for the teams of which the user is a member' do
        team.list(:member) { |team| team }
      end
    end
  end

  describe '.profile' do
    before do
      expect(team).to receive(:request).with(
        :get,
        '/2.0/teams/team_name',
        {},
        {}
      )
    end

    it 'sends a GET request for the profile for the team' do
      team.profile('team_name')
    end
  end

  describe '.members' do
    before do
      expect(team).to receive(:request).with(
        :get,
        '/2.0/teams/team_name/members',
        {},
        {}
      )
    end

    it 'sends a GET request for the members of the team' do
      team.members('team_name')
    end
  end
end
