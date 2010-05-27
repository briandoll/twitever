require 'rubygems'
require 'json'
require 'yaml'
$KCODE = 'UTF8' # have to set this before requiring twitter-text
require 'twitter-text'
include Twitter::Extractor

  def me
    @me ||= `whoami`.chop
  end

  def config
    @config ||= (YAML.load_file("/Users/#{me}/.twitever.yml") || {})
  end
  
  def get_latest_favorite_id
    `touch #{config["dotfile"]}`
    last_favorite = File.read(config["dotfile"])
    (last_favorite.length > 0) ? last_favorite.to_i : 0
  end

  def get_favorites
    JSON.parse(`curl http://twitter.com/favorites.json -u "#{config["user"]}:#{config["pass"]}"`)
  end

  def get_urls_from_favorites
    latest_favorite_id = get_latest_favorite_id
    favorite_ids = []
    favorite_urls = {}
    get_favorites.each do |favorite|
      favorite_id = favorite['id'].to_i
      if favorite_id > latest_favorite_id
        favorite_ids << favorite_id
        tweet = cleanup_tweet(favorite['text'])
        screen_name = favorite['user']['screen_name']
        extract_urls(tweet) do |url|
          favorite_urls[url] = "@#{screen_name}: #{tweet}"
        end
      end
    end
    update_last_favorite_id(favorite_ids.max)
    favorite_urls
  end
  
  def cleanup_tweet(tweet)
    tweet.gsub("\"", "")
  end
  
  def update_last_favorite_id(id)
    if id
      fave = File.open(config["dotfile"], "w")
      fave << id
    end
  end
  
  def add_recent_favorite_urls_to_evernote
    get_urls_from_favorites.each do |url, tweet|
      `osascript #{config["script_path"]}/add_note_to_evernote_by_url.scpt #{url} "#{tweet}"`
    end
  end

# do it!
add_recent_favorite_urls_to_evernote