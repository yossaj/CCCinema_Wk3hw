require_relative('../db/sql_runner.rb')
require_relative('tickets')
require_relative('films')


class Customer
  attr_reader :name, :id
  attr_accessor :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO customers(name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name,@funds]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ($1,$2) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def booked()
    sql = "SELECT films.*
          FROM films INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql,values)
    movies = results.map{|film| Film.new(film)}
    return movies
  end



  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    customers = results.map{|customer| Customer.new(customer)}
    return customers
  end

  def buy_tickets
    movies = self.booked
    prices = movies.map{|movie| movie.price}
    total_price = prices.sum
    @funds -= total_price
    self.update
  end







end
