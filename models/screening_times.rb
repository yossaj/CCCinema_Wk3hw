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
  #
  # def self.delete_all
  #   sql = "DELETE FROM tickets"
  #   SqlRunner.run(sql)
  # end
  #
  # def self.all
  #   sql = "SELECT * FROM tickets"
  #   results = SqlRunner.run(sql)
  #   tickets = results.map{|ticket| Ticket.new(ticket)}
  #   return tickets
  # end




end
