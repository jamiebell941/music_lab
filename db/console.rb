require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all
Artist.delete_all

artist1 = Artist.new( { 'name' => 'Mac Miller' } )

artist1.save

album1 = Album.new( { 'title' => 'Swimming', 'genre' => 'Hip Hop', 'artist_id' => artist1.id } )
album2 = Album.new({ 'title' => 'Circles', 'genre' => 'Hip Hop', 'artist_id' => artist1.id})

album1.save
album2.save

binding.pry
nil
