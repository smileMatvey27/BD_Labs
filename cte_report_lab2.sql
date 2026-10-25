WITH flight_revenue AS (
    SELECT 
        f.id AS flight_id,
        f.flight_number,
        COUNT(b.id) AS tickets_sold,
        SUM(b.price_paid) AS total_revenue,
        AVG(b.price_paid) AS avg_ticket_price
    FROM flight f
    JOIN booking b ON f.id = b.flight_id
    WHERE b.status = 'paid'
    GROUP BY f.id, f.flight_number
),
overall_stats AS (
    SELECT 
        SUM(total_revenue) AS grand_total_revenue
    FROM flight_revenue
)
SELECT 
    fr.flight_number AS "Номер рейса",
    fr.tickets_sold AS "Продано билетов",
    fr.total_revenue AS "Общая выручка",
    ROUND(fr.avg_ticket_price, 2) AS "Средний чек",
    ROUND((fr.total_revenue / os.grand_total_revenue) * 100, 2) AS "Доля в выручке (%)"
FROM flight_revenue fr
CROSS JOIN overall_stats os
ORDER BY fr.total_revenue DESC;