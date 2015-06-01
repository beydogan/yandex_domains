require 'spec_helper'

describe YandexDomains::Admin::Domain do
  before do
    @client = YandexDomains::Client.new("PDD")
  end

  describe "/register" do
    before do
      stub_post('/admin/domain/register')
      .with(query: {domain: 'google.com'}, :headers => {'Pddtoken'=>'PDD'})
      .to_return(
          body: fixture('connect_domain.json'),
          headers: {content_type: 'application/json; charset=utf-8'}
      )
    end

    it 'requests the correct resource on GET' do
      @client.connect_domain("google.com")
      expect(a_post('/admin/domain/register').with(query: {domain: 'google.com'})).to have_been_made
    end

    it 'returns parsed response' do
      resp = @client.connect_domain("google.com")
      expect(resp).to be_a Hash
    end
  end

  # it '/registration_status' do
  #   pending "TODO"
  # end
  #
  # it '/details' do
  #   pending "TODO"
  # end
  #
  # it '/delete' do
  #   pending "TODO"
  # end
  #
  # it '/set_country' do
  #   pending "TODO"
  # end
end
