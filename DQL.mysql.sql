-- DQL - select

-- 1) seelct

-- select * from tablename;

-- select
-- from
-- where
-- groupby
-- having
-- orderby
-- limit



-- 10)
SELECT payment_method, COUNT(*) AS usage_count
FROM payments
GROUP BY payment_method
ORDER BY usage_count DESC
LIMIT 1;
