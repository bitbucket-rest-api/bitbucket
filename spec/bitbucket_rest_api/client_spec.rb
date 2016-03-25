require 'spec_helper'

describe BitBucket::Client do
  let(:client) { described_class.new }

  it "returns the a new object of the correct class" do
    expect(client.issues).to be_a BitBucket::Issues
    expect(client.repos).to be_a BitBucket::Repos
    expect(client.users).to be_a BitBucket::Users
    expect(client.user_api).to be_a BitBucket::User
    expect(client.invitations).to be_a BitBucket::Invitations
  end
end
