require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('tickets')


class Film
  attr_reader :id
  attr_accessor :title, :price
  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO films(title, price) VALUES ($1, $2) RETURNING id;"
    values = [@title,@price]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def all_customers
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql,values)
    customers = results.map{|customer| Customer.new(customer)}
    return customers
  end

  def update
    sql = "UPDATE films SET (title, price) = ($1,$2) WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def show_available_tickets
      sql = "SELECT films.title, screening_times.screening_time, screening_times.available_tickets FROM films
            INNER JOIN screening_times
            ON films.id = screening_times.film_id WHERE film_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql,values)
      table = results.map{|times| times}
  end

def self.delete_all
  sql = "DELETE FROM films;"
  SqlRunner.run(sql)
end

def self.all
  sql = "SELECT * FROM films;"
  results = SqlRunner.run(sql)
  films = results.map{|film| Film.new(film)}
  return films
end



end
