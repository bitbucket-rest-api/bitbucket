# encoding: utf-8

require 'spec_helper'

describe BitBucket::ApiFactory do

  subject(:factory) { described_class }

  context '#new' do
    it 'throws error if klass type is ommitted' do
      expect { factory.new nil }.to raise_error(ArgumentError)
    end

    it 'instantiates a new object' do
      expect(factory.new('Issues')).to be_a BitBucket::Issues
    end
  end

  context '#create_instance' do
    it 'creates class instance' do
      expect(factory.create_instance('User', {})).to be_kind_of(BitBucket::User)
    end
  end

  context '#convert_to_constant' do
    it 'knows how to convert nested classes' do
      expect(factory.convert_to_constant('Repos::Changesets')).to eql(BitBucket::Repos::Changesets)
    end
  end
end # BitBucket::ApiFactory
