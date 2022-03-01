class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :spotify_token, :string
    add_column :users, :token, :string
  end
end
