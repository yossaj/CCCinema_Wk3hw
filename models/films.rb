require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('tickets')


class Film
  attr_reader :title, :price, :id

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO films(title, price) VALUES ($1, $2) RETURNING id"
    values = [@title,@price]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end


end
