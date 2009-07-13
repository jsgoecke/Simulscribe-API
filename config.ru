require 'rubygems'
require 'sinatra'
 
ROOT_DIR = File.expand_path(File.dirname(__FILE__))
 
Sinatra::Application.set(
  :run         => false,
  :environment => :production
)
 
require 'simulscribe_server.rb'
run Sinatra::Application