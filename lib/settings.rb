require 'base64'

# Reads the settings from the yaml file
class Settings
  def self.all
    @settings ||= begin
      if ENV['ENV'] == 'test'
        YAML.load_file(File.join('.', 'spec/config.test.yml'))
      elsif ENV['YNAB_BANK_IMPORTER_CONFIG']
        settings_string = Base64.strict_decode64(ENV['YNAB_BANK_IMPORTER_CONFIG'])
        YAML.load(settings_string)
      else
        YAML.load_file(File.join('.', 'config.yml'))
      end
    end
  end
end
