require "yandex_domains/version"
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

    # Used for signing up a domain.
    # @param domain [String]
    # @return [Hash]
    # @see https://api.yandex.com.tr/kurum/doc/reference/domain-register.xml
    def connect_domain(domain)
      req = self.class.post("/admin/domain/register", {query: {domain: domain}})
      req.parsed_response
    end

    # The request is used for getting the results of the last check, the date and time the check was performed,
    # and the date and time of the next check.
    # @param [String] domain
    # @return [Hash] Parsed Response
    # @see https://api.yandex.com.tr/kurum/doc/reference/domain-registrationstatus.xml
    def registration_status(domain)
      req = self.class.get("/admin/domain/registration_status", {query: {domain: domain}})
      req.parsed_response
    end

    # Used for adding a mailbox for the domain.
    # @param domain [String] Name of the domain.
    # @param login [String] The email address of the mailbox, in the format “username@domain.ru” or “username”.
    # @param password [String] User's password.
    #   The password must:
    #   contain from 6 to 20 characters — Latin letters, numbers, and the symbols “!”, “@”, “#”, “$”, “%”, “^”, “&”, “*”, “(”, “)”, “_”, “-”, “+”, “:”, “;”, “,”, “.”
    #   be different from the username.
    # @return [Hash] Parsed Response
    # @example Example create hi@google.com with strongpassword
    #   client.add_mailbox('google.com', 'hi', 'strongpassword')
    # @example Return Hash
    #   {
    #     "domain": "{domain name}",
    #     "login":"{email address of the mailbox}",
    #     "uid": "{mailbox ID}",
    #     "success": "{status of request execution}"
    #   }
    #
    # @see https://api.yandex.com.tr/kurum/doc/reference/email-add.xml
    def add_mailbox(domain, login, password)
      req = self.class.post("/admin/email/add", {query: {domain: domain, login: login, password: password}})
      req.parsed_response
    end

    # Used for getting a list of the domain's mailboxes.
    # @param domain [String] Name of the domain.
    # @param options [Hash]
    # @option options [Integer] :page Page number in the response. The default value is 1. #TODO
    # @option options [Integer] :on_page Number of mailboxes on each response page. The default value is 30. #TODO
    # @return [Hash]
    # @see https://tech.yandex.com/domain/doc/reference/email-list-docpage/
    # @todo Add support for options
    def get_mailboxes(domain, options = {})
      req = self.class.get("/admin/email/list", {query: {domain: domain}})
      req.parsed_response['accounts']
    end

    # Used for editing mailbox parameters: password, user's first and last name, and so on.
    # @param domain [String] Name of the domain.
    # @param login [String] The email address of the mailbox, in the format “username@domain.com” or “username”.
    # @param options [Hash]
    # @option options [String] :password User's new password.
    # @option options [String] :iname User's first name.
    # @option options [String] :fname User's last name.
    # @option options [String] :enabled Whether the mailbox is enabled.
    #   Possible values:
    #   yes — Mailbox is enabled
    #   no — Mailbox is blocked (for example, due to spam distribution or suspected hacking).
    # @option options [Integer] :birth_date User's date of birth in the format YYYY-MM-DD.
    # @option options [Integer] :sex User's gender.
    #   Possible values:
    #   0 — Not specified.
    #   1 — Male.
    #   2 — Female.
    # @option options [Integer] :hintq Secret question.
    # @option options [Integer] :hinta Answer to the secret question.
    # @return [Hash]
    # @example Example Usage
    #   client.update_mailbox('google.com', 'hi', {sex: 0, birth_date: "1998-09-04"})
    # @example Example Response
    #   {
    #       "domain": "{domain name}",
    #       "login":"{email address of the mailbox}",
    #       "uid": "{mailbox ID}",
    #       "success": "{status of request execution}",
    #       "account":
    #       {
    #           "uid": "{mailbox ID}",
    #           "iname": "{user's name}",
    #           "sex": "{user's gender}",
    #           "ready": "{mailbox readiness}",
    #           "hintq": "{pet's favorite food ???}",
    #           "aliases":
    #           [
    #               "{alias name}",
    #           ...
    #           ],
    #           "enabled": "{whether mailbox is working}",
    #           "maillist": "{mailing list flag}",
    #           "fname": "{user's last name}",
    #           "birth_date": "{user's date of birth}",
    #           "login": "{mailbox email address}",
    #           "fio": "{user's full name}"
    #       }
    #   }
    # @see https://tech.yandex.com/domain/doc/reference/email-edit-docpage/
    def update_mailbox(domain, login, options = {})
      query = {domain: domain, login: login}
      query = query.merge(options)
      req = self.class.post("/admin/email/edit", query: query)
      req.parsed_response
    end
    # Used for deleting a mailbox on a domain
    # @param domain [String] Name of the domain.
    # @param login [String] The email address of the mailbox, in the format “username@domain.com” or “username”.
    # @return [Hash] Parsed Response
    # @example Example Usage
    #   client.delete_mailbox('google.com', 'hi')
    # @example Example Response
    #   {
    #       "domain": "{domain name}",
    #       "login":"{mailbox address}",
    #       "success": "{status of request execution}"
    #   }
    # @see https://api.yandex.com.tr/kurum/doc/reference/email-del.xml
    def delete_mailbox(domain, login)
      req = self.class.post("/admin/email/del", {query: {domain: domain, login: login}})
      req.parsed_response
    end

  end
end
