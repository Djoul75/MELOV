class LikesController < ApplicationController
  before_action :find_publication

  def create
    @like = Like.new(publication_id: @publication.id)
    @like.user = current_user
    authorize @like
    @like.save!

    redirect_to "/"
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    authorize @like
    @like.destroy!

    redirect_to "/"
  end

  private

  def find_publication
    @publication = Publication.find(params[:publication_id])
  end
end
