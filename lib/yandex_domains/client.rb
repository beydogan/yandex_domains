require "yandex_domains/version"
require "yandex_domains/admin/domain"
require "yandex_domains/admin/email"
require "httparty"

module YandexDomains
  class Client
    include HTTParty
    attr_accessor :pdd_token
    base_uri 'https://pddimp.yandex.ru/api2'

    # Initializes a new Client
    #
    # @param pdd_token [String]
    # @return [YandexDomains::Client]
    def initialize(pdd_token)
      self.pdd_token = pdd_token
      self.class.headers 'PddToken' => pdd_token
    end

    include YandexDomains::Admin::Domain
    include YandexDomains::Admin::Email
  end
end
