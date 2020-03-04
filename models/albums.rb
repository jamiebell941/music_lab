require('pg')
require_relative('artists')
require_relative('../db/sql_runner.rb')

class Album

attr_reader :id, :artist_id
attr_accessor :title, :genre

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options ['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
      db = PG.connect ({dbname:'music', host:'localhost'})
      sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
      values = [@title, @genre, @artist_id]
      db.prepare("save", sql)
      result = db.exec_prepared("save", values)
      db.close
      @id = result[0]['id'].to_i
    end

    def by_artist
      sql = "SELECT * FROM artists WHERE id = $1"
      values = [@artist_id]
      musician = SqlRunner.run(sql, values)
      return musician.map {|artist| Artist.new(artist)}
      end


    def self.all()
      sql = "SELECT * FROM albums"
      result = SqlRunner.run(sql)
      return result.map {|album| Album.new(album)}
    end

    def self.delete_all
      sql = "DELETE FROM albums"
       SqlRunner.run(sql)
    end
end
