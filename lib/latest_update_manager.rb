class LastestUpdateManager
  @@latest_update_data_file_path = "./latest_update.yml"

  class << self
    def load provider
      result = YAML.load_file @@latest_update_data_file_path
      result.try(:[], provider)
    end

    def set_last_update_id provider, since_id
      persist_last_update_data do |update_data|
        update_data[provider] = since_id
      end
    end

    private

    def persist_oauth
      # load config
      update_data = YAML.load_file @@latest_update_data_file_path

      # update config
      yield update_data || {}

      # save back
      File.write @@latest_update_data_file_path, YAML.dump(update_data)
      true
    rescue => e
      pp e
      false
    end
  end
end