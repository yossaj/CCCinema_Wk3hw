require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('films')


class Tickets

  attr_reader :film_id, :customer_id, :id

  def initialize(options)
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO tickets(film_id, ticket_id) VALUES ($1, $2) RETURNING id"
    values = [@film_id,@customer_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  


end
