class TweetsController < ApplicationController

  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Tweet.all.order(created_at: :desc)
    # @tweet = Tweet.new
  end

  def show
  end

  def new
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    if @tweet.save!
      redirect_to tweets_path, notice: "Tweet was successfully created."
    else
      redirect_to tweets_path, notice: "Tweet was not created."
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
