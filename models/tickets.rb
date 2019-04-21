require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('films')
require('pry')


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

  def self.best_seller
      tickets = self.all
      screenings = tickets.map{|ticket|ticket.screening_time_id.to_s}
      screening_tally = Hash.new(0)
      screenings.each{|screening| screening_tally[screening] += 1}
      screening_tally
      best_sell = screening_tally.max_by{|k,v| v}
      best_sell[0]
  end

  def self.show_best_seller
    best_seller = self.best_seller
    sql = "SELECT films.*, screening_times.* FROM films
          INNER JOIN screening_times
          ON films.id = screening_times.film_id
          WHERE screening_times.id = $1; "
    values = [best_seller]
    results = SqlRunner.run(sql,values)
    top_movie = results.map{|result| result}.first
    return "The best selling movie this month is #{top_movie["title"]}.There are #{top_movie["available_tickets"]} tickets left for the #{top_movie["screening_time"]} screening!"
  end


  # chickens_tally = chickens_with_dupes.reduce({}) do |tally, chicken|
  #   if tally.include?(chicken)
  #     tally[chicken] += 1
  #   else
  #     tally[chicken] = 1
  #   end
  #   tally
  # end

#   names = ["Jason", "Jason", "Teresa", "Judah", "Michelle", "Judah", "Judah", "Allison"]
# counts = Hash.new(0)
# names.each { |name| counts[name] += 1 }


end
