require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('films')


class Ticket

  attr_reader :film_id, :customer_id, :screening_time_id, :id

  def initialize(options)
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @screening_time_id = options['screening_time_id'].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO tickets(film_id, customer_id, screening_time_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@film_id,@customer_id, @screening_time_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
    tickets = results.map{|ticket| Ticket.new(ticket)}
    return tickets
  end




end
