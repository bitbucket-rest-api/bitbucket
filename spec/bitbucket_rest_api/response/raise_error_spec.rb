require 'spec_helper'

describe BitBucket::Response::RaiseError do
  describe '.on_complete' do
    before do
      @raise_error = BitBucket::Response::RaiseError.new
    end

    it 'raises a BadRequest error on 400 status code' do
      expect{ @raise_error.on_complete({status: 400}) }.to raise_error BitBucket::Error::BadRequest
    end

    it 'raises an Unauthorized error on 401 status code' do
      expect{ @raise_error.on_complete({status: 401}) }.to raise_error BitBucket::Error::Unauthorized
    end

    it 'raises a Forbidden error on 403 status code' do
      expect{ @raise_error.on_complete({status: 403}) }.to raise_error BitBucket::Error::Forbidden
    end

    it 'raises a NotFound error on 404 status code' do
      expect{ @raise_error.on_complete({status: 404}) }.to raise_error BitBucket::Error::NotFound
    end

    it 'raises an UnprocessableEntity error on 422 status code' do
      expect{ @raise_error.on_complete({status: 422}) }.to raise_error BitBucket::Error::UnprocessableEntity
    end

    it 'raises an InternalServerError error on 500 status code' do
      expect{ @raise_error.on_complete({status: 500}) }.to raise_error BitBucket::Error::InternalServerError
    end

    it 'raises a ServiceUnavailable error on 503 status code' do
      expect{ @raise_error.on_complete({status: 503}) }.to raise_error BitBucket::Error::ServiceUnavailable
    end

    it 'raises a ServiceError when another status code' do
      expect{ @raise_error.on_complete({status: 501}) }.to raise_error BitBucket::Error::ServiceError
    end
  end
end
