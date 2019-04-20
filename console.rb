require('pry')
require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')
require_relative('./models/screening_times.rb')

Ticket.delete_all
ScreeningTime.delete_all
Film.delete_all
Customer.delete_all



film1 = Film.new('title'=>'Zatoichi', 'price' => '5')
film1.save

film2 = Film.new('title'=>'Godzilla', 'price' => '8')
film2.save

film3 = Film.new('title'=>'Silence', 'price' => '8')
film3.save

film4 = Film.new('title'=>'Toy Story', 'price' => '10')
film4.save



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

screening_time1 = ScreeningTime.new('screening_time'=> '12:30', 'available_tickets' => '60', 'film_id' => film1.id)
screening_time1.save

screening_time2 = ScreeningTime.new('screening_time'=> '18:30', 'available_tickets' => '30', 'film_id' => film2.id)
screening_time2.save

screening_time3 = ScreeningTime.new('screening_time'=> '14:00', 'available_tickets' => '60', 'film_id' => film3.id)
screening_time3.save

screening_time4 = ScreeningTime.new('screening_time'=> '20:20', 'available_tickets' => '60', 'film_id' => film4.id)
screening_time4.save



ticket1 = Ticket.new('film_id' => film1.id, 'customer_id' => customer1.id,'screening_time_id' => screening_time1.id )
ticket1.save

ticket2 = Ticket.new('film_id' => film2.id, 'customer_id' => customer1.id, 'screening_time_id' => screening_time2.id)
ticket2.save

ticket3 = Ticket.new('film_id' => film3.id, 'customer_id' => customer2.id, 'screening_time_id' => screening_time3.id)
ticket3.save

ticket4 = Ticket.new('film_id'=>film4.id, 'customer_id' => customer1.id, 'screening_time_id' => screening_time4.id)
ticket4.save

ticket5 = Ticket.new('film_id'=>film1.id, 'customer_id' => customer3.id, 'screening_time_id' => screening_time1.id)
ticket5.save

film1.price = '10'
film1.update

# screening_time1.id
# p Ticket.all()
# p Film.all()
# p Customer.all()

customer1.booked
film1.all_customers

customer1.buy_tickets
customer2.buy_tickets
customer3.buy_tickets
customer4.buy_tickets
customer5.buy_tickets
# customer1.update()
# ScreeningTime.all()

p screening_time1.reduce_available_tickets
