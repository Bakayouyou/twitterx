class PagesController < ApplicationController
  skip_before_action :authenticate

  def home
  end

  def close_modal
    session[:show_modal] = false
    redirect_to root_path
  end
end
