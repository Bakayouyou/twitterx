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
    # Crée un nouvel objet tweet associé à l'utilisateur actuellement connecté (Current.user)
    tweet = Current.user.tweets.new(tweet_params)

    # Vérifie si le tweet peut être enregistré dans la base de données
    if tweet.save
      # Si le tweet est enregistré avec succès, retourne une réponse Turbo Streams.
      # Turbo Streams est un mécanisme de Rails pour mettre à jour dynamiquement le contenu de la page côté client sans recharger toute la page.

      render(turbo_stream: [
        # Ajoute le nouveau tweet au début de la liste des tweets dans la vue actuelle
        turbo_stream.prepend(
          "tweets",
          partial: "tweets/tweet",
          locals: {
            tweet: tweet,
            new_content: true
          }
        ),
        # Remplace le formulaire de création de tweet dans la vue actuelle pour permettre une nouvelle soumission sans recharger la page entière.
        turbo_stream.replace(
          "tweet_form",
          partial: "tweets/form",
          locals: { tweet: Tweet.new, new_content: true, remote: true, placeholder: "" }
        )
      ])
    else
      redirect_to root_path, alert: "Tweet failed, try again."
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
