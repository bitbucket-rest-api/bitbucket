require 'spec_helper'

describe BitBucket::API, '#actions' do
  let(:api) { BitBucket::Repos::Keys }

  context 'when class' do
    it "lists all available actions for an api" do
      expect(api.actions).to match_array([:actions, :all, :create, :delete, :edit, :list])
    end
  end

  context 'when instance' do
    it "lists all available actions for an api" do
      expect(api.new.actions).to match_array([:actions, :all, :create, :delete, :edit, :list])
    end
  end
end
