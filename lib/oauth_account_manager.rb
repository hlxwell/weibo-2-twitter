require 'yaml_config_store'

class OauthAccountManager
  @@config_file_path = "oauth_accounts.yml"

  class << self
    def load! provider
      YamlConfigStore.load!(@@config_file_path, provider)
    end
  end
end
