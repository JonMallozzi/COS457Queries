SELECT DISTINCT
        vdate,
        legnum,
        (SUM(
            CASE
                WHEN howvoted = 'Yea' AND party = 'Republican'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS ryeas,
         (SUM(
            CASE
                WHEN howvoted = 'Nay' AND party = 'Republican'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS rnays,
         (SUM(
            CASE
                WHEN howvoted = 'Abstain' AND party = 'Republican'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS rabs,
         (SUM(
            CASE
                WHEN howvoted = 'Yea' AND party = 'Democrat'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS dyeas,
         (SUM(
            CASE
                WHEN howvoted = 'Nay' AND party = 'Democrat'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS dnays,
         (SUM(
            CASE
                WHEN howvoted = 'Abstain' AND party = 'Democrat'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS dabs,
         (SUM(
            CASE
                WHEN howvoted = 'Yea' 
                AND party != 'Republican' AND party != 'Democrat'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS oyeas,
         (SUM(
            CASE
                WHEN howvoted = 'Nay' 
                AND party != 'Republican' AND party != 'Democrat'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS onays,
         (SUM(
            CASE
                WHEN howvoted = 'Abstain' 
                AND party != 'Republican' AND party != 'Democrat'
                THEN 1
                ELSE 0
            END
         ) 
         ) AS oabs
FROM votes
INNER JOIN senators USING (sname)
GROUP BY vdate, legnum
ORDER BY vdate, legnum;