class CredentialManager
  @@oauth_tokens_file_path = "./oauth_tokens.yml"

  class << self
    def load provider
      result = YAML.load_file @@oauth_tokens_file_path
      result.is_a?(Hash) ? result[provider] : nil
    end

    def update auth_hash
      provider          = auth_hash["provider"]
      oauth_credentials = auth_hash["credentials"]

      persist_oauth do |credentials|
        credentials[provider] = {}
        credentials[provider]["token"] = oauth_credentials["token"]
        credentials[provider]["secret"] = oauth_credentials["secret"]
        credentials
      end
    end

    private

    def persist_oauth
      # load config
      credentials = YAML.load_file @@oauth_tokens_file_path
      # update config
      credentials = yield credentials || {}
      # save back
      File.write oauth_tokens_file_path, YAML.dump(credentials)
      true
    rescue => e
      pp e
      false
    end
  end
end