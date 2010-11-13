module I18n
  class << self
    def reload_with_emails!
      reload_without_emails!
      I18n.backend.store_translations(I18n.default_locale, I18nEmails::Email.load_all)
    end
    
    alias_method_chain :reload!, :emails
  end
end