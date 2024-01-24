class FlashesController < ApplicationController
  before_action :redirect_if_authenticated

  private

  def redirect_if_authenticated
    redirect_to categories_path if user_signed_in?
  end
end