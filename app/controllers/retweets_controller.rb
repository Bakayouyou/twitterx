class RetweetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_tweet

  def create
    @user = Tweet.find(params[:tweet_id]).user
    @retweet = Tweet.create!(retweet_params)
    redirect_to root_path, notice: "Retweeted"
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def retweet_params
    {
      user: Current.user,
      retweet: @tweet,
      body: @tweet.body
    }
  end

end
