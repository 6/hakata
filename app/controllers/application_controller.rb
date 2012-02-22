class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :initialize_cardview
  
  private
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  def initialize_cardview
    # Determine Flashcard View
    session[:cardview] ||= 'off'
  end
end
