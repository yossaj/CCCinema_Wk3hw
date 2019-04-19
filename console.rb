require('pry')
require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')

film1 = Film.new('title'=>'Zatoichi', 'price' => '5')
film1.save
