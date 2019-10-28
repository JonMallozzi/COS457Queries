WITH senContrib AS(
    SELECT DISTINCT
          sname,
          amt,
          cname
    FROM sponsors 
    INNER JOIN affected_by USING(legnum)
    INNER JOIN contributes USING(sname,cname)
    WHERE howafctd = 'Favorably'
)

SELECT 
        sname,
        COALESCE(SUM(amt),0)
        AS sum
FROM senContrib
FULL OUTER JOIN senators USING(sname)
GROUP BY sname
ORDER BY sname;
