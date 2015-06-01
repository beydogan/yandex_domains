require 'spec_helper'

describe YandexDomains::Admin::Domain do
  before do
    @client = YandexDomains::Client.new("PDD")
  end

  describe "#register" do
    before do
      stub_post('/admin/domain/register')
      .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
      .to_return(
          body: fixture('connect_domain.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
      )
    end

    it 'requests the correct resource on POST' do
      @client.connect_domain("google.com")
      expect(a_post('/admin/domain/register').with(query: {domain: 'google.com'})).to have_been_made
    end

    it 'returns parsed response' do
      resp = @client.connect_domain("google.com")
      expect(resp).to be_a Hash
    end
  end

  describe '#registration_status' do
    context 'if waiting activation' do
      before do
        stub_get('/admin/domain/registration_status')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('activate_domain.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on GET' do
        @client.registration_status("google.com")
        expect(a_get('/admin/domain/registration_status').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with status: domain-activate' do
        resp = @client.registration_status("google.com")
        expect(resp).to be_a Hash
        expect(resp["status"]).to eq("domain-activate")
      end
    end

    context 'if connected' do
      before do
        stub_get('/admin/domain/registration_status')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('added_domain.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on GET' do
        @client.registration_status("google.com")
        expect(a_get('/admin/domain/registration_status').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with status: domain-activate' do
        resp = @client.registration_status("google.com")
        expect(resp).to be_a Hash
        expect(resp["status"]).to eq("added")
      end
    end
  end

  describe '#details' do
    context 'if waiting activation' do
      before do
        stub_get('/admin/domain/details')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('waiting_activation_domain_details.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on GET' do
        @client.details("google.com")
        expect(a_get('/admin/domain/details').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with status: domain-activate' do
        resp = @client.details("google.com")
        expect(resp).to be_a Hash
        expect(resp["status"]).to eq("domain-activate")
        expect(resp["domain"]).to eq("google.com")
      end
    end

    context 'if connected' do
      before do
        stub_get('/admin/domain/details')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('added_domain_details.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on GET' do
        @client.details("google.com")
        expect(a_get('/admin/domain/details').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with status: added' do
        resp = @client.details("google.com")
        expect(resp).to be_a Hash
        expect(resp["status"]).to eq("added")
        expect(resp["domain"]).to eq("google.com")
      end
    end

    context 'if does not exist' do
      before do
        stub_get('/admin/domain/details')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('none_domain_details.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on GET' do
        @client.details("google.com")
        expect(a_get('/admin/domain/details').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with status: none' do
        resp = @client.details("google.com")
        expect(resp).to be_a Hash
        expect(resp["status"]).to eq("none")
        expect(resp["domain"]).to eq("google.com")
      end
    end
  end

  describe '#delete' do
    context 'if exist' do
      before do
        stub_post('/admin/domain/delete')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('ok_delete_domain.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on POST' do
        @client.delete("google.com")
        expect(a_post('/admin/domain/delete').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with success: ok' do
        resp = @client.delete("google.com")
        expect(resp).to be_a Hash
        expect(resp["success"]).to eq("ok")
        expect(resp["domain"]).to eq("google.com")
      end
    end

    context 'if does not exist' do
      before do
        stub_post('/admin/domain/delete')
        .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
        .to_return(
            body: fixture('error_delete_domain.json'),
            headers: {content_type: 'application/json; charset=utf-8'}
        )
      end

      it 'requests the correct resource on POST' do
        @client.delete("google.com")
        expect(a_post('/admin/domain/delete').with(query: {domain: 'google.com'})).to have_been_made
      end

      it 'returns parsed response with status: error' do
        resp = @client.delete("google.com")
        expect(resp).to be_a Hash
        expect(resp["success"]).to eq("error")
        expect(resp["domain"]).to eq("google.com")
      end
    end
  end

  #
  # it '/set_country' do
  #   pending "TODO"
  # end
end
