require 'spec_helper'

describe BitBucket::Teams do
  let(:team) { described_class.new }

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
      ).and_return({"values" => ['member1', 'member2', 'member3']})
    end

    context "without a block" do
      it 'sends a GET request for the members of the team' do
        team.members('team_name')
      end
    end

    context "with a block" do
      it 'sends a GET request for the members of the team' do
        team.members('team_name') { |member| member }
      end
    end
  end

  describe '.followers' do
    before do
      expect(team).to receive(:request).with(
        :get,
        '/2.0/teams/team_name/followers',
        {},
        {}
      ).and_return({"values" => ['follower1', 'follower2', 'follower3']})
    end

    context "without a block" do
      it 'sends a GET request for the followers of the team' do
        team.followers('team_name')
      end
    end

    context "with a block" do
      it 'sends a GET request for the followers of the team' do
        team.followers('team_name') { |follower| follower }
      end
    end
  end

  describe '.following' do
    before do
      expect(team).to receive(:request).with(
        :get,
        '/2.0/teams/team_name/following',
        {},
        {}
      ).and_return({"values" => ['following1', 'following2', 'following3']})
    end

    context "without a block" do
      it 'sends a GET request for accounts the team is following' do
        team.following('team_name')
      end
    end

    context "with a block" do
      it 'sends a GET request for accounts the team is following' do
        team.following('team_name') { |followee| followee }
      end
    end
  end

  describe '.repos' do
    before do
      expect(team).to receive(:request).with(
        :get,
        '/2.0/repositories/team_name',
        {},
        {}
      ).and_return({"values" => ['repo1', 'repo2', 'repo3']})
    end

    context "without a block" do
      it 'sends a GET request for the repos for the team' do
        team.repos('team_name')
      end
    end

    context "with a block" do
      it 'sends a GET request for the repos for the team' do
        team.repos('team_name') { |repo| repo }
      end
    end
  end
end
