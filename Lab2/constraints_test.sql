INSERT INTO passenger (id, full_name, passport, email, phone, birth_date)
VALUES (100, 'Тестов Тест Тестович', '9999 999999', 'ivanov@mail.ru', '+70000000000', '1990-01-01');

INSERT INTO flight (flight_number, aircraft_id, departure_airport_id, arrival_airport_id,
                    departure_time, arrival_time, base_price)
VALUES ('SU999', 1, 1, 3, '2026-12-01 10:00:00', '2026-12-01 12:00:00', -5000.00);

INSERT INTO flight (flight_number, aircraft_id, departure_airport_id, arrival_airport_id,
                    departure_time, arrival_time, base_price)
VALUES ('SU998', 1, 1, 1, '2026-12-02 10:00:00', '2026-12-02 12:00:00', 10000.00);

INSERT INTO flight (flight_number, aircraft_id, departure_airport_id, arrival_airport_id,
                    departure_time, arrival_time, base_price)
VALUES ('SU997', 1, 1, 3, '2026-12-03 12:00:00', '2026-12-03 10:00:00', 10000.00);

INSERT INTO airport (code, name, city_id)
VALUES ('svo', 'Тестовый аэропорт', 1);

INSERT INTO booking (passenger_id, flight_id, seat_number, booking_class, status, price_paid)
VALUES (1, 1, '99Z', 'premium', 'booked', 30000.00);


INSERT INTO booking (passenger_id, flight_id, seat_number, booking_class, status, price_paid)
VALUES (2, 1, '12A', 'economy', 'booked', 25000.00);