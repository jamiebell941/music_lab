require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all
Artist.delete_all

artist1 = Artist.new( { 'name' => 'Mac Miller' } )
artist2 = Artist.new( { 'name' => 'Malcom' } )

artist1.save

album1 = Album.new( { 'title' => 'Swimming', 'genre' => 'Hip Hop', 'artist_id' => artist1.id } )
album2 = Album.new({ 'title' => 'Circles', 'genre' => 'Hip Hop', 'artist_id' => artist1.id})
album3 = Album.new({ 'title' => 'GO:OD AM', 'genre' => 'R&B', 'artist_id' => artist1.id})

artist1.name = 'Malcom'
artist1.update
artist2.save

album1.save
album2.save
album3.save

album2.genre = 'R&B'
album2.update

album1.title = 'GO:OD AM'


binding.pry
nil
