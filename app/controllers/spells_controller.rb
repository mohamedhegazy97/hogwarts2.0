class SpellsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,only: :destroy

  def new 

  end

  def show
    
  end

  def index

  end

  def create
    @spell = current_user.spells.build(spell_params)
    if @spell.save
      flash[:success] = "Spell created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @spell.destroy
    flash[:success] = "Spell deleted"
    if request.referrer.nil? || request.referrer == spells_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end

  def edit
    @spell = current_user.spells.find(params[:id])
  end

  def update
    @spell = current_user.spells.find(params[:id])
    if @spell.update(spell_params)
      flash[:success] = "Spell updated"
      redirect_to current_user
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

    def spell_params
      params.require(:spell).permit(:short_name , :description)
    end

    def correct_user
      @spell = current_user.spells.find_by(id: params[:id])
      redirect_to root_url if @spell.nil?
    end
end
