class NoCredentalError < Error; end

class CredentialManager
  @@oauth_tokens_file_path = "./oauth_tokens.yml"

  class << self
    def load! provider
      credentials = YAML.load_file @@oauth_tokens_file_path
      raise(NoCredentalError.new) if !credentials.is_a?(Hash) or !credentials[provider].is_a?(Hash)
      credentials[provider]
    end

    def update auth_hash
      provider          = auth_hash["provider"]
      oauth_credentials = auth_hash["credentials"]

      persist_oauth do |credentials|
        credentials[provider] = {}
        credentials[provider]["token"] = oauth_credentials["token"]
        credentials[provider]["secret"] = oauth_credentials["secret"]
      end
    end

    private

    def persist_oauth
      # load config
      credentials = YAML.load_file @@oauth_tokens_file_path

      # update config
      yield credentials || {}

      # save back
      File.write oauth_tokens_file_path, YAML.dump(credentials)
      true
    rescue => e
      pp e
      false
    end
  end
end