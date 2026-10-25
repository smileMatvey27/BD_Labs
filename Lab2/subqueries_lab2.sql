SELECT 
    b.id AS booking_id,
    b.booking_class,
    b.price_paid,
    (
        SELECT ROUND(AVG(price_paid), 2) 
        FROM booking b2 
        WHERE b2.booking_class = b.booking_class
          AND b2.status = 'paid'
    ) AS avg_class_price
FROM booking b
WHERE b.status = 'paid' 
  AND b.price_paid > (
      SELECT AVG(price_paid) 
      FROM booking b2 
      WHERE b2.booking_class = b.booking_class
        AND b2.status = 'paid'
  )
ORDER BY b.booking_class, b.price_paid DESC;


SELECT 
    p.id AS passenger_id,
    p.full_name,
    p.email
FROM passenger p
WHERE EXISTS (
    SELECT 1 
    FROM booking b 
    WHERE b.passenger_id = p.id 
      AND b.status = 'cancelled'
)
ORDER BY p.id;


SELECT 
    f.id AS flight_id,
    f.flight_number,
    f.departure_time
FROM flight f
WHERE NOT EXISTS (
    SELECT 1 
    FROM booking b 
    WHERE b.flight_id = f.id 
      AND b.status = 'paid'
)
ORDER BY f.id;


SELECT 
    p.id AS passenger_id,
    p.full_name,
    (
        SELECT COUNT(*) 
        FROM booking b 
        WHERE b.passenger_id = p.id 
          AND b.status = 'paid'
    ) AS paid_flights_count
FROM passenger p
ORDER BY paid_flights_count DESC, p.full_name;