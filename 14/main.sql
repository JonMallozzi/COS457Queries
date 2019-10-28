WITH voteStats AS (
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
ORDER BY vdate, legnum
), moreVoteStats AS(
    SELECT
          legnum,
          vdate,
          (CASE
                  WHEN dyeas > dnays THEN 'Yea'
                  WHEN dnays > dyeas THEN 'Nay'
                  ELSE 'Even'
               END
              ) AS w,
              (CASE
                   WHEN dyeas > dnays 
                   THEN CAST(dyeas AS double precision )/(dyeas + dnays)
                   WHEN dnays > dyeas 
                   THEN CAST(dnays AS double precision )/(dyeas + dnays)
                   ELSE 0.500
               END
              ) AS x,
              (CASE
                  WHEN ryeas > rnays THEN 'Yea'
                  WHEN rnays > ryeas THEN 'Nay'
                  ELSE 'Even'
               END
              ) AS y,
              (CASE
                   WHEN ryeas > rnays 
                   THEN CAST(ryeas AS double precision )/(ryeas + rnays)
                   WHEN rnays > ryeas 
                   THEN CAST(rnays AS double precision )/(ryeas + rnays)
                   ELSE 0.500
               END
              ) AS z
    FROM voteStats
)
SELECT DISTINCT
               legnum,
               vdate,
               w,
               x,
               y,
               z,
               (
                   w != 'Even'
                   AND y != 'Even'
                   AND w != y 
                   AND x >= 0.6
                   AND z >= 0.6
               ) AS partisan
FROM moreVoteStats
ORDER BY legnum,vdate;