require 'spec_helper'

describe BitBucket::User do
  let(:options) do
    {
      client_id:     'mX63DfWHZg5wu3naXc',
      client_secret: 'xXqSdMCFD65YgLVPymSEAPdnvm6Ur3bQ',
      oauth_token:   'cxLFBj3mJBS8Fp6hKw',
      oauth_secret:  'k9nNg7EB5GGU3aCpFqe5YzxK7Qfz3dSf',
      adapter:       :net_http
    }
  end

  before do
    @user = BitBucket::User.new(options)
  end

  describe '#profile' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user', {}, {})
      @user.profile
    end

    it "retrieves user's profile info" do
      VCR.use_cassette('user_profile') do
        profile = @user.profile
        expect(profile.repositories).to_not be_nil
      end
    end
  end

  describe '#update' do
    let(:params) do
      { first_name: 'first-name', last_name: 'last-name', avatar: '' }
    end

    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:put, '/1.0/user', params, {})
      @user.update(params)
    end
  end
end
