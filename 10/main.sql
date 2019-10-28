WITH senVotes AS(
    SELECT DISTINCT 
                    age, 
                    sname, 
                    cname
        FROM senators
        INNER JOIN votes USING(sname)
        INNER JOIN affected_by USING(legnum)
        INNER JOIN contributes USING(sname, cname)
    WHERE 
        (howvoted = 'Yea' and howafctd = 'Favorably')
    OR 
        (howvoted = 'Nay' and howafctd = 'Unfavorably')
)
SELECT 
        cname,
       COALESCE(AVG(age),0) 
       AS ageave
FROM senVotes
FULL OUTER JOIN corporations USING(cname)
GROUP BY cname
ORDER BY cname; 