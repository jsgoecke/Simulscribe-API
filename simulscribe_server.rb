require 'rubygems'
require 'sinatra'
require 'xmlsimple'
require './lib/simulscribe_db'

get '/' do
  "Doing a ditty here. You really want to do a post to /receive_transcription"
end

post '/receive_transcription' do
  results = XmlSimple.xml_in params["response"]
  p "Incoming transcription request with: "
  p results
  p "*"*50
  if results["trans-xml"][0]["result"][0] == "transcribed"
    transcription = Transcription.find_by_query_id results["external-id"][0]
    if transcription
      transcription.result = results["trans-xml"][0]["message"][0]
      transcription.save
    else
      p "Could not find a transcription record with query_id == #{results["external-id"][0]}"
    end
  else
    p "Transcription failed for query_id == #{results["external-id"][0]}"
  end
end