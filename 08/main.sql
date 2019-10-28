WITH senPair AS (
    SELECT 
            s1.sname AS sen1,
            s2.sname AS sen2
    FROM senators s1 
    CROSS JOIN senators s2 
    WHERE
          s1.sname != s2.sname
          AND s1 < s2
)
SELECT 
      sen1 AS sname,
      sen2 AS sname
FROM senPair
WHERE NOT EXISTS (
    SELECT
           1
    FROM votes
    WHERE (
        sname = sen1
        AND (votes.legnum, votes.vdate) NOT IN(
            SELECT
                  legnum,
                  vdate
            FROM votes
            where sname = sen2
        )
    )
    OR (
       sname = sen2
        AND (votes.legnum, votes.vdate) NOT IN(
            SELECT
                  legnum,
                  vdate
            FROM votes
            where sname = sen1
        ) 
    )
)
ORDER BY sen1,sen2;