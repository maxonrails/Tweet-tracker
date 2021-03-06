require "#{Rails.root}/lib/tweet_module.rb"

class Tweet < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :link, uniqueness: true

  def self.tweets_by_user(username)
    TweetSearch.username(username)
  end

  def self.tweets_by_keywords(keywords)
    TweetSearch.keywords(keywords)
  end

  def self.tweets_by_hashtag(hashtag)
    TweetSearch.hashtag(hashtag)
  end

  def self.tweets_by_topic(handle, keyword)
    TweetSearch.topic(handle, keyword)
  end
end


