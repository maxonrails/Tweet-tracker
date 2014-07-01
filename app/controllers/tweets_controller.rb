class TweetsController < ApplicationController
  def index
    user = current_user
    @tweets = user.tweets
  end

  def new
    @user = current_user
    # Search form
  end

  def search
    # Important: portfolio dependency
    @results = Tweet.tweets_by_user(params[:handle])
    render :json => @results.to_json
  end

  def find
    @user = current_user
    if params[:handle]
      @results = Tweet.tweets_by_user(params[:handle])
    elsif params[:keywords]
      @results = Tweet.tweets_by_keywords(params[:keywords])
    else
      @results = Tweet.tweets_by_hashtag(params[:hashtag])
    end
  end

  def create
    user = current_user
    tweet = Tweet.create({handle: params[:handle], content: params[:content], link: params[:link]})
    if tweet.save
      tweet >> user.tweets
    else
      Tweet.find_by(link: params[:link]) >> user.tweets
    end
    redirect_to user_tweets_path(user)
  end

  def show
  end

  def destroy
    @tweet = Tweet.delete(params[:id])
    redirect_to tweets_path
  end
end
