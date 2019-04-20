require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('films')
require_relative('./tickets.rb')


class ScreeningTime

  attr_reader :film_id, :id
  attr_accessor :available_tickets, :screening_time

  def initialize(options)
    @screening_time = options['screening_time']
    @available_tickets = options['available_tickets'].to_i
    @film_id = options['film_id'].to_i
    @id = options["id"].to_i if options["id"]
  end
  #
  def save()
    sql = "INSERT INTO screening_times (screening_time, available_tickets, film_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@screening_time, @available_tickets,@film_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update
    sql = "UPDATE screening_times SET (screening_time, available_tickets, film_id) = ($1,$2,$3) WHERE id = $4;"
    values = [@screening_time,@available_tickets,@film_id, @id]
    SqlRunner.run(sql, values)
  end

  # def reduce_available_tickets
  #     sql = "SELECT tickets.*
  #           FROM tickets INNER JOIN screening_times
  #           ON tickets.film_id = screening_times.film_id
  #           WHERE screening_times.film_id = $1;
  #        "
  #     values = [@film_id]
  #     result = SqlRunner.run(sql,values).count
  #     @available_tickets -= result
  #     self.update
  # end
  def self.show_all_available_tickets
      sql = "SELECT films.title, screening_times.screening_time, screening_times.available_tickets FROM films
  INNER JOIN screening_times
  ON films.id = screening_times.film_id;"
      results = SqlRunner.run(sql)
      table = results.map{|times| times}
  end
  #
  def self.delete_all
    sql = "DELETE FROM screening_times"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM screening_times"
    results = SqlRunner.run(sql)
    screening_times = results.map{|screening_time| ScreeningTime.new(screening_time)}
    return screening_times
  end






end
