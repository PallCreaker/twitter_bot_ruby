# require './config.rb'
require 'yaml'

# 環境設定の読み込み
config = YAML.load_file("config.yml")

client = Twitter::REST::Client.new do |conf|
  conf.consumer_key = config['twitter_api']['CONSUMER_KEY']
  conf.consumer_secret = config['twitter_api']['CONSUMER_SECRET']
  conf.access_token = config['twitter_api']['ACCESS_TOKEN']
  conf.access_token_secret = config['twitter_api']['ACCESS_TOKEN_SECRET']
end

# 新たなデータの取得
client.search('#グラドル自画撮り部', {:result_type => 'recent', :include_entities => true}).each do |obj|
  break if count > 100
  if obj.is_a?(Twiiter::Tweet)
    # URL取得
    obj.match.each do |o|
      puts o.media_url
      @db.query("instert ignore tweet_table (url) values ('#{o.media_url}')")
      count +=1
    end
  end
end