require 'rubygems'
require 'active_record'

db_config = YAML::load(File.open('database.yml'))

ActiveRecord::Base.establish_connection db_config

class Transcription < ActiveRecord::Base
end