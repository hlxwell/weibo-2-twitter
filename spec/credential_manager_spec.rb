require "./lib/credential_manager"

describe 'Credential manager' do
  it "should load provider config" do
    CredentialManager.load!("weibo").should be_is_a(Hash)
  end

  it "should not overwrite original config if has data" do
    CredentialManager.load!("weibo").should be_is_a(Hash)
    CredentialManager.load!("weibo").should be_is_a(Hash)
  end

  it "should be able to update credential" do
    credentials = {"token" => "testtoken", "secret" => "testsecret"}
    original_credentials = CredentialManager.load!("weibo")
    original_credentials.should_not eq(credentials)
    CredentialManager.update({"provider" => "weibo", "credentials" => credentials})
    CredentialManager.load!("weibo").should eq(credentials)
    # recovery
    CredentialManager.update({"provider" => "weibo", "credentials" => original_credentials})
  end
end