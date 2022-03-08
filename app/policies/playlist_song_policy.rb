class PlaylistSongPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    true
  end

  def destroy?
    playlist_user = Playlist.find(@record.playlist_id).user_id
    playlist_user == user.id
  end
end
