class AddLatitudeAndLongitudeToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :latitude, :float
    add_column :venues, :longitude, :float
    add_column :venues, :address, :string
  end
end
