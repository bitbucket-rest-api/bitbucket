require 'spec_helper'

describe BitBucket::User do
  let(:options) do
    {
      client_id:     'example_client_id',
      client_secret: 'example_client_secret',
      oauth_token:   'example_oauth_token',
      oauth_secret:  'example_oauth_secret',
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

  describe '#privileges' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user/privileges', {}, {})
      @user.privileges
    end
  end

  describe '#follows' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user/follows', {}, {})
      @user.follows
    end
  end

  describe '#repositories' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user/repositories', {}, {})
      @user.repositories
    end
  end

  describe '#repos' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user/repositories', {}, {})
      @user.repos
    end
  end

  describe '#overview' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user/repositories/overview', {}, {})
      @user.overview
    end
  end

  describe '#dashboard' do
    it 'sends the request to the right url' do
      expect(@user).to receive(:request).with(:get, '/1.0/user/repositories/dashboard', {}, {})
      @user.dashboard
    end
  end
end
