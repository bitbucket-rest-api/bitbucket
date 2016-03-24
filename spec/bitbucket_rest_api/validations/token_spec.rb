require 'spec_helper'

describe BitBucket::Validations::Token do
  let(:token) { Class.new.extend(described_class) }

  describe ".validates_token_for" do
    it 'returns false if authentication token is not required' do
      expect(token.validates_token_for(:get, '/anotherpath')).to be false
    end

    it 'returns true if authentication token is required' do
      expect(token.validates_token_for(:get, '/user')).to be true
      expect(token.validates_token_for(:get, '/repos/a/b/comments')).to be true
    end
  end
end
