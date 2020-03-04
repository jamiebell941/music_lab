require('pg')
require_relative('albums')
require_relative('../db/sql_runner.rb')

class Artist

attr_reader :id
attr_accessor :name

  def initialize(options)
    @id = options ['id'].to_i if options ['id']
    @name = options['name']
  end

  def save()
      db = PG.connect ({dbname:'music', host:'localhost'})
      sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
      values = [@name]
      db.prepare("save", sql)
      result = db.exec_prepared("save", values)
      db.close
      @id = result[0]['id'].to_i
  end

  def albums_by
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album| Album.new(album)}
    end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map {|artist| Artist.new(artist)}

  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

end
