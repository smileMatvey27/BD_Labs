BEGIN;

INSERT INTO passenger (full_name, passport, email, phone, birth_date)
VALUES ('Новиков Алексей Петрович', '4599 111222', 'novikov@mail.ru', '+79991112233', '1992-04-18');

INSERT INTO booking (passenger_id, flight_id, seat_number, booking_class, status, booking_date, price_paid)
VALUES (currval('passenger_id_seq'), 22, '01A', 'economy', 'booked', NOW(), 20000.00);

COMMIT;

SELECT p.id, p.full_name, b.flight_id, b.seat_number, b.status
FROM passenger p
JOIN booking b ON p.id = b.passenger_id
WHERE p.email = 'novikov@mail.ru';


BEGIN;

UPDATE booking
SET status = 'paid'
WHERE passenger_id = 2 AND flight_id = 9;

COMMIT;

SELECT id, passenger_id, flight_id, status
FROM booking
WHERE passenger_id = 2 AND flight_id = 9;


BEGIN;

UPDATE booking
SET status = 'cancelled'
WHERE flight_id IN (
    SELECT id FROM flight 
    WHERE departure_time >= '2027-01-01' AND departure_time < '2027-02-01'
) AND status = 'booked';

COMMIT;

SELECT flight_id, status, COUNT(*)
FROM booking
WHERE flight_id IN (SELECT id FROM flight WHERE departure_time >= '2027-01-01')
GROUP BY flight_id, status
ORDER BY flight_id;


BEGIN;

DELETE FROM booking 
WHERE passenger_id = 19 AND flight_id = 19 AND status = 'cancelled';

COMMIT;

SELECT * FROM booking WHERE passenger_id = 19 AND flight_id = 19;

BEGIN;

UPDATE flight SET base_price = base_price * 2 WHERE id = 22;

SELECT id, flight_number, base_price FROM flight WHERE id = 22;

ROLLBACK;

SELECT id, flight_number, base_price FROM flight WHERE id = 22;