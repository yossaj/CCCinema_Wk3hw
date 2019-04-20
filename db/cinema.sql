DROP TABLE tickets;
DROP TABLE screening_times;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT8

);

CREATE TABLE films(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price INT8
);

CREATE TABLE screening_times(
  id SERIAL8 PRIMARY KEY,
  screening_time VARCHAR(255),
  available_tickets INT8,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE tickets(
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE,
  screening_time_id INT8 REFERENCES screening_times(id) ON DELETE CASCADE
);
