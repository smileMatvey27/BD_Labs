SELECT 
    b.id AS booking_id,
    p.full_name AS passenger_name,
    f.flight_number,
    dep.city_id AS departure_city_id,
    arr.city_id AS arrival_city_id,
    f.departure_time,
    b.seat_number,
    b.status,
    b.price_paid
FROM booking b
JOIN passenger p ON b.passenger_id = p.id
JOIN flight f ON b.flight_id = f.id
JOIN airport dep ON f.departure_airport_id = dep.id
JOIN airport arr ON f.arrival_airport_id = arr.id
WHERE b.status = 'paid'
ORDER BY f.departure_time DESC, p.full_name
LIMIT 10;


SELECT 
    p.id AS passenger_id,
    p.full_name,
    p.email
FROM passenger p
LEFT JOIN booking b ON p.id = b.passenger_id
WHERE b.id IS NULL;


SELECT DISTINCT
    f.flight_number,
    f.departure_time,
    f.base_price
FROM flight f
JOIN booking b ON f.id = b.flight_id
WHERE f.departure_time >= '2026-12-01' AND f.departure_time < '2027-01-01'
  AND b.status = 'paid'
  AND b.booking_class IN ('business', 'first')
ORDER BY f.departure_time;

SELECT 
    booking_class,
    COUNT(*) AS total_bookings,
    COUNT(DISTINCT passenger_id) AS unique_passengers,
    SUM(price_paid) AS total_revenue
FROM booking
WHERE status = 'paid' OR status = 'booked'
GROUP BY booking_class
ORDER BY total_revenue DESC;


SELECT 
    f.flight_number,
    COUNT(b.id) AS paid_bookings,
    SUM(b.price_paid) AS total_revenue,
    AVG(b.price_paid) AS avg_price
FROM flight f
JOIN booking b ON f.id = b.flight_id
WHERE b.status = 'paid'
GROUP BY f.flight_number
HAVING SUM(b.price_paid) > 40000
ORDER BY total_revenue DESC;


SELECT 
    DATE_TRUNC('month', f.departure_time)::date AS departure_month,
    COUNT(b.id) AS tickets_sold,
    MIN(b.price_paid) AS min_price,
    MAX(b.price_paid) AS max_price,
    ROUND(AVG(b.price_paid), 2) AS avg_price
FROM booking b
JOIN flight f ON b.flight_id = f.id
WHERE b.status = 'paid'
GROUP BY DATE_TRUNC('month', f.departure_time)::date
ORDER BY departure_month;