require('pg')
require_relative('albums')
require_relative('../db/sql_runner.rb')

class Artist
attr_accessor :name, :id

  def initialize(options)
    @id = options ['id'].to_i if options ['id']
    @name = options['name']
  end

  def save()
      sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
      values = [@name]
      result = SqlRunner.run(sql, values)
      @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums_by
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album| Album.new(album)}
    end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map { |artist| Artist.new(artist)}
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
