require "yandex_domains/version"
require "httparty"

module YandexDomains
  class Client
    include HTTParty
    attr_accessor :pdd_token
    base_uri 'https://pddimp.yandex.ru/api2'

    def initialize(pdd_token, x)
      self.pdd_token = pdd_token
      self.class.headers 'PddToken' => pdd_token
    end

    def get_mailboxes(domain)
      req = self.class.get("/admin/email/list", {query: {domain: domain}})
      req.parsed_response['accounts']
    end

  end
end
