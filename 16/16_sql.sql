-- ЗАДАЧА 16-1

WITH tab (
    SELECT
        DATE_TRUNC('week', hitTime) AS start_of_week,
        COUNT(hitId) week_hits
    FROM hits
    GROUP BY DATE_TRUNC('week', hitTime)
)

SELECT
    start_of_week,
    week_hits,
    LAG(week_hits) OVER (ORDER BY start_of_week) AS previous_week
FROM tab;
