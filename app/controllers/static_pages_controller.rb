class StaticPagesController < ApplicationController
  def home
    @spell = current_user.spells.build if logged_in?
  end

  def help
  end
end
