require('pry')
require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')

Ticket.delete_all
Film.delete_all
Customer.delete_all



film1 = Film.new('title'=>'Zatoichi', 'price' => '5')
film1.save

customer1 = Customer.new('name'=> 'Bill', 'funds' => '500')
customer1.save

ticket1 = Ticket.new('film_id' => film1.id, 'customer_id' => customer1.id)
ticket1.save

film1.price = '10'
film1.update

p Ticket.all()
p Film.all()
p Customer.all()
