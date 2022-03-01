class PublicationsController < ApplicationController
  before_action :publication_find, only: %i[show edit update destroy]

  def index
    @publications = Publication.where(user_id: current_user.followings.ids).order(created_at: :desc)
  end

  def show

  end

  def new
    @publication = Publication.new
  end

  def edit
  end

  def create
    @publication = Publication.new(publication_params)
    if @publication.update(publication_params)
      redirect_to publication_path(@publication)
    else
      render :edit
    end
  end

  def destroy
    @publication.destroy
  end
end


private

  def publication_find
    @forest = Forest.find(params[:id])
  end

  def publication_params
    params.require(:publication).permit(:content)
  end
