require "./lib/yaml_config_store"

describe 'Yaml config store' do
  it "should create file when there is no file" do
    File.exists?("config/test.yml").should be_false
    YamlConfigStore.update("test.yml", "weibo", {"user" => "test"})
    File.exists?("config/test.yml").should be_true
    File.delete("config/test.yml")
  end
end