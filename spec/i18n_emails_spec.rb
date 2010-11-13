require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "I18nEmails" do
  describe "loading a file" do
    
    let(:email_file) {File.expand_path("../fixtures/forgotten_password.email", __FILE__)}
    let(:email) { I18nEmails::Email.new(email_file) }
    
    it "should load the email header keys" do
      email.to_hash["subject"].should == "Forgotten password"
      email.to_hash["heading"].should == "It's ok, we all forget our passwords sometimes"
    end
    
    it "should load the email body" do
      email.to_hash["body"].should == "Hi %{username},\n\nClick here to reset your password %{link}.\n\nHave a great day!"
    end
    
    context "with a different split" do
      let(:email_file) {File.expand_path("../fixtures/with_shorter_split.email", __FILE__)}
      
      it "should load the email header keys" do
        email.to_hash["subject"].should == "Forgotten password"
        email.to_hash["heading"].should == "It's ok, we all forget our passwords sometimes"
      end

      it "should load the email body" do
        email.to_hash["body"].should == "Hi %{username},\n\nClick here to reset your password %{link}.\n\nHave a great day!"
      end
    end
    
    it "should raise an exception if no file" do
      lambda {
        I18nEmails::Email.new("/my/non/existent/file")
      }.should raise_exception(Errno::ENOENT)
    end
  end
  
  describe "loading files" do
    
    let(:email_dir) {File.expand_path("../fixtures/", __FILE__)}
    
    it "should load all files in a directory" do
      I18nEmails::Email.load_all(email_dir).keys.should include("with_shorter_split", "forgotten_password", "nested")
    end
    
    context "from a subdirectory" do
      it "should load files in a nested hash" do
        I18nEmails::Email.load_all(email_dir)["nested"].keys.should include("a_nested")
      end
      it "should load files nested twice" do
        I18nEmails::Email.load_all(email_dir)["nested"]["second_nest"].keys.should == ["second_nest"]
      end
    end
    
    it "should should only load .email files" do
      I18nEmails::Email.load_all(email_dir).keys.should_not include("dont_load.me")
    end
  end
   
  describe "loading translations into I18n" do
    it "should load into a backend" do
      I18n.load_path = [File.expand_path("../fixtures/en.yml", __FILE__)]
      I18nEmails.load_path = File.expand_path("../fixtures", __FILE__)
      I18n.reload!
      I18n.t("hello").should == "World"
      I18n.t("forgotten_password.subject").should == "Forgotten password"
    end
  end
end
