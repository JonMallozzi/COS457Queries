WITH legDates AS(
    SELECT DISTINCT
                    vdate,
                    legnum
    FROM votes
), 
conMoney AS (
    SELECT DISTINCT
                vdate,
                legnum,
                SUM(
                    CASE
                        WHEN howafctd = 'Favorably' 
                        AND cdate < vdate
                        THEN amt
                        ELSE 0
                    END
                ) AS moneyfor,
                SUM(
                    CASE
                        WHEN howafctd = 'Unfavorably' 
                        AND cdate < vdate
                        THEN amt
                        ELSE 0
                    END
                ) AS moneyagainst                
FROM legDates
INNER JOIN affected_by USING(legnum)
INNER JOIN contributes USING(cname)
GROUP BY vdate, legnum
),
passed AS (
    SELECT 
          vdate,
          legnum,
          (SUM
          ( CASE
          WHEN howvoted = 'Yea' 
          THEN 1
          ELSE -1
          END ) >=0
        ) AS passed
    FROM votes
    GROUP BY vdate,legnum
)
SELECT 
                vdate,
                legnum,
                COALESCE(moneyfor,0) AS moneyfor,
                COALESCE(moneyagainst,0) AS moneyagainst,
                passed,
                (
                    (COALESCE(moneyfor,0)  > COALESCE(moneyagainst,0)
                    AND passed)
                    OR
                    (COALESCE(moneyfor,0)  < COALESCE(moneyagainst,0)
                    AND NOT passed)
                ) AS moneytalks
FROM conMoney
FULL OUTER JOIN legDates USING(vdate,legnum)
FULL OUTER JOIN passed USING(vdate, legnum)
ORDER BY vdate, legnum;