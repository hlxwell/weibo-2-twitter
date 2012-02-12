class YamlConfigStore
  class << self
    def load! file_path, provider
      loaded_data = YAML.load_file real_path(file_path)
      if !loaded_data.is_a?(Hash) or loaded_data[provider].nil?
        loaded_data = create_a_config_node_for(provider, file_path)
      end
      loaded_data[provider]
    end

    def update file_path, provider, data_hash
      persist_data real_path(file_path) do |config|
        config[provider] = data_hash
      end
    end

    private

    def persist_data file_path
      # load config
      if file_path and File.exists?(file_path)
        loaded_data = YAML.load_file file_path
      end

      loaded_data ||= {}

      # update config
      yield loaded_data

      # save back
      File.open file_path, "w" do |f|
        f.write YAML.dump(loaded_data)
      end

      loaded_data
    end

    def real_path file_path
      File.join(File.dirname(__FILE__), "..", "config", file_path)
    end

    def create_a_config_node_for provider, file_path
      update file_path, provider, nil
    end
  end
end