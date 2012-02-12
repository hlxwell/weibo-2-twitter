require 'yaml_config_store'

class CredentialManager
  @@oauth_tokens_file_path = "oauth_tokens.yml"

  class << self
    def load! provider
      YamlConfigStore.load! @@oauth_tokens_file_path, provider
    end

    def update auth_hash
      provider          = auth_hash["provider"]
      oauth_credentials = auth_hash["credentials"]
      YamlConfigStore.update @@oauth_tokens_file_path, provider, oauth_credentials
    end
  end
end