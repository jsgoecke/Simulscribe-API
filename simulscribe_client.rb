require 'rubygems'
require 'curb'
require 'xmlsimple'
require './lib/simulscribe_db'

config = YAML::load(File.open('config.yml'))
key = Time.now.to_i.to_s

curl = Curl::Easy.new config["simulscribe_url"]
curl.multipart_form_post = true
curl.http_post Curl::PostField.file('message[file_data]', ARGV[0]),
               Curl::PostField.content('account_did', config['account_did']),
               Curl::PostField.content('api_key', config['api_key']),
               Curl::PostField.content('message[external_id]', key),
               Curl::PostField.content('message[requesting_host]', config['requesting_host'])

#Save the transcription request details to the database
Transcription.create!({ :query_id => key, :filename => ARGV[0] })

body_hash = XmlSimple.xml_in curl.body_str
p "Result: " + curl.response_code.to_s 
p body_hash
