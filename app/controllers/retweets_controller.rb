class RetweetsController < ApplicationController

  before_action :set_tweet

  def create
    retweet = Tweet.create!(retweet_params)
    raise
    redirect_to retweet, notice: "Retweeted"
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def retweet_params
    {
      user: params[:user],
      retweet: @tweet,
      body: @tweet.body
    }
  end

end
