-- ЗАДАЧА 50-1

WITH sent_req AS (
    SELECT DISTINCT
        date,
        user_id_sender AS sender,
        user_id_receiver AS receiver,
        action
    FROM fb_friend_request
    WHERE action = 'sent'
), acc_req AS (
    SELECT
        date,
        user_id_sender AS sender,
        user_id_receiver AS receiver,
        action
    FROM fb_friend_request
    WHERE action = 'accepted'
)

SELECT
    date,
    COUNT(a.action) / COUNT(s.action) AS rate
FROM sent_req AS s
LEFT JOIN acc_req AS a ON a.date = s.date AND a.sender = s.sender AND a.receiver = s.receiver
GROUP BY date
ORDER BY date ASC;
