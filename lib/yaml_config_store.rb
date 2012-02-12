class YamlConfigStore
  class << self
    def load! file_path, provider
      loaded_data = YAML.load_file file_path
      if !loaded_data.is_a?(Hash) or loaded_data[provider].nil?
        loaded_data = create_a_config_node_for(provider, file_path)
      end
      loaded_data[provider]
    end

    def update file_path, provider, data_hash
      persist_data file_path do |config|
        config[provider] = data_hash
      end
    end

    def persist_data file_path
      # load config
      loaded_data = YAML.load_file file_path
      loaded_data ||= {}

      # update config
      yield loaded_data

      # save back
      File.write file_path, YAML.dump(loaded_data)

      loaded_data
    end

    private

    def create_a_config_node_for provider, file_path
      update file_path, provider, nil
    end
  end
end