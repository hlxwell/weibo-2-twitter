require './lib/yaml_config_store'

class SinceIdManager
  @@latest_update_data_file_path = "./latest_updates.yml"

  class << self
    def load! provider, client
      YamlConfigStore.load!(@@latest_update_data_file_path, provider) || find_and_create_since_id(client)
    end

    def update provider, since_id
      YamlConfigStore.update @@latest_update_data_file_path, provider, since_id
    end

    private

    def find_and_create_since_id client
      last_update = client.user_timeline(:count => 1).last
      update("weibo", !last_update.nil? ? last_update.id : nil)
    end
  end
end
