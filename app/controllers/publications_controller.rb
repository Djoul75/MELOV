class PublicationsController < ApplicationController
  before_action :publication_find, only: %i[show edit update destroy]

  def index
    @publications = Publication.where(user_id: current_user.followings.ids).order(created_at: :desc)
  end

  def show
    authorize @publication

  end

  def new
    @publication = Publication.new
    authorize @publication
  end

  def edit
    authorize @publication
  end

  def create
    @publication = Publication.new(publication_params)
    @publication.user = current_user
    authorize @publication
    @publication.save!
    if @publication.save
      redirect_to publications_path(anchor: "publication-#{@publication.id}")
    else
      render :show
    end
  end

  def update
    authorize @publication
    if @publication.update(publication_params)
      redirect_to publication_path(@publication)
    else
      render :edit
    end
  end

  def destroy
    authorize @publication
    @publication.destroy
  end
end


private

  def publication_find
    @forest = Publication.find(params[:id])
  end

  def publication_params
    params.require(:publication).permit(:content)
  end
