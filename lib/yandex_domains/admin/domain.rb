module YandexDomains
  module Admin
    module Domain
      # Used for signing up a domain.
      # @param domain [String]
      # @return [Hash]
      # @see https://api.yandex.com.tr/kurum/doc/reference/domain-register.xml
      def connect_domain(domain)
        req = self.class.post("/admin/domain/register", {query: {domain: domain}})
        req.parsed_response
      end

      # Used for getting the results of the last check, the date and time the check was performed,
      # and the date and time of the next check.
      # @param [String] domain
      # @return [Hash] Parsed Response
      # @see https://api.yandex.com.tr/kurum/doc/reference/domain-registrationstatus.xml
      def registration_status(domain)
        req = self.class.get("/admin/domain/registration_status", {query: {domain: domain}})
        req.parsed_response
      end

      # Get current domain properties: the status of connecting and delegating the domain to Yandex,
      # the mailbox interface language and design, and the POP and IMAP modes.
      # @param [String] domain
      # @return [Hash] Parsed Response
      # @example Example Usage
      #   client.details('google.com)
      # @example Return Hash
      #   {
      #       "domain": "{domain name}",
      #       "status": "{domain status}",
      #       "stage": "{service key}",
      #       "delegated": "{status of delegating domain to Yandex}",
      #       "country": "{interface language}",
      #       "imap_enabled": "{status of IMAP operation}",
      #       "pop_enabled": "{status of POP operation}",
      #       "default_theme": "{design theme ID}",
      #       "success": "{status of request execution}"
      #   }
      # @see https://tech.yandex.com/domain/doc/reference/domain-details-docpage/
      def details(domain)
        req = self.class.get("/admin/domain/details", {query: {domain: domain}})
        req.parsed_response
      end

      # Used for deleting a domain that was connected by a user. All the domain's mailboxes will also be deleted.
      # @param [String] domain
      # @return [Hash] Parsed Response
      # @example Example Usage
      #   client.delete('google.com)
      # @example Return Hash if domain exists
      #   {
      #       "domain": "google.com",
      #       "success": "ok"
      #   }
      # @example Return Hash if domain doesn't exist
      #   {
      #       "domain": "google.com",
      #       "success": "error",
      #       "error": "not_allowed"
      #   }
      # @see https://tech.yandex.com/domain/doc/reference/domain-delete-docpage/
      def delete(domain)
        req = self.class.post("/admin/domain/delete", {query: {domain: domain}})
        req.parsed_response
      end

      # Used for setting the language of the email interface for the domain.
      # @param [String] domain
      # @param [String] country code
      # @return [Hash] Parsed Response
      # @example Example Usage
      #   client.delete('google.com)
      # @example Return Hash if domain exists
      #   {
      #       "country": "en",
      #       "domain": "google.com",
      #       "success": "ok"
      #   }
      # @example Return Hash if domain doesn't exist
      #   {
      #       "domain": "google.com",
      #       "success": "error",
      #       "error": "not_allowed"
      #   }
      # @see https://tech.yandex.com/domain/doc/reference/domain-settings-set-country-docpage/
      def set_country(domain, country)
        req = self.class.post("/admin/domain/settings/set_country", {query: {domain: domain, country: country}})
        req.parsed_response
      end
    end
  end
end