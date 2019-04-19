require('pry')
require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')

Ticket.delete_all
Film.delete_all
Customer.delete_all



film1 = Film.new('title'=>'Zatoichi', 'price' => '5')
film1.save

film2 = Film.new('title'=>'Godzilla', 'price' => '8')
film2.save

film3 = Film.new('title'=>'Silence', 'price' => '8')
film3.save



customer1 = Customer.new('name'=> 'Bill', 'funds' => '500')
customer1.save

customer2 = Customer.new('name'=> 'Amy', 'funds' => '250')
customer2.save


customer3 = Customer.new('name'=> 'Sean', 'funds' => '200')
customer3.save

customer4 = Customer.new('name'=> 'Tim', 'funds' => '30')
customer4.save()

customer5 = Customer.new('name'=> 'Ashley', 'funds' => '400')
customer5.save()



ticket1 = Ticket.new('film_id' => film1.id, 'customer_id' => customer1.id)
ticket1.save

ticket2 = Ticket.new('film_id' => film2.id, 'customer_id' => customer1.id)
ticket2.save

ticket3 = Ticket.new('film_id' => film3.id, 'customer_id' => customer2.id)
ticket3.save

film1.price = '10'
film1.update

# p Ticket.all()
# p Film.all()
# p Customer.all()

customer1.booked
p film1.all_customers
