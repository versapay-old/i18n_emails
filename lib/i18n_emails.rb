require 'i18n'
require 'active_support'
require 'active_support/core_ext/module/aliasing'
require 'active_support/core_ext/module/attribute_accessors'
require 'action_view'
require "yaml"
require "i18n_emails/i18n_extension"

module I18nEmails
  
  mattr_accessor :load_path
  self.load_path = "config/locales/en"
  
  class Email
    
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper # to use simple_format
    
    BODY_SPLIT = /^-{3,}\n/
    
    class << self
      # Recursivly merges the content of all .email files contained the in the
      # passed in directory into a hash for use in I18n
      def load_all(dir = I18nEmails.load_path)
        hash = {}
      
        Dir[File.join(dir, "*")].each do |file_or_folder|
          if File.directory?(file_or_folder)
            hash[File.basename(file_or_folder)] = Email.load_all(file_or_folder)
          else
            if email_file?(file_or_folder)
              email = Email.new(file_or_folder)
              hash[email.key] = email.to_hash
            end
          end
        end
      
        hash
      end
    
      protected
      
      def email_file?(filename)
        filename =~ /.email$/
      end
    end
    
    def initialize(path)
      @path = path
      @file_contents = File.read(path)
    end
    
    def key
      File.basename(@path).gsub(".email", '')
    end
    
    def to_hash
      header, body = @file_contents.split(BODY_SPLIT)
      YAML::load(header).merge({'body' => simple_format(body)})
    end

    
  end
end