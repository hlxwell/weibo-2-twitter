require "./lib/yaml_config_store"

describe 'Yaml config store' do
  it "should create file when there is no file" do
    File.exists?("test.yml").should be_false
    YamlConfigStore.update("test.yml", "weibo", {"user" => "test"})
    File.exists?("test.yml").should be_true
    File.delete("test.yml")
  end
end