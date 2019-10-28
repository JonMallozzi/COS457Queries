WITH sumTable AS(
    SELECT 
          cname,
          sname,
          COALESCE(SUM(amt),0) 
          AS sum
    FROM contributes
    FULL OUTER JOIN senators USING(sname)
    GROUP BY cname, sname
),
    corpAffecting AS(
        SELECT
              cname,
              (SELECT COUNT(cname)
                FROM affected_by
                WHERE affected_by.cname = corporations.cname
                 AND howafctd = 'Favorably')
                AS y,
                (SELECT COUNT(cname)
                 FROM affected_by
                 WHERE affected_by.cname = corporations.cname
                 AND howafctd = 'Unfavorably')
                 AS z
        FROM corporations        
    )
SELECT
      cname,
      COALESCE(COUNT(sname),0) AS u,
      COALESCE(MAX(sum),0) AS v,
      COALESCE(MIN(sum),0) AS w,
     (SELECT COALESCE(avg(amt),0) 
     FROM contributes
     WHERE contributes.cname = sumTable.cname)
     AS x,
      --psql wants these in a aggregate function or
      --in GROUP BY but that would ruin the results
      --so putting them in ROUND(AVG() is a hack to 
      --get their actual resalut returned
      ROUND(AVG(corpAffecting.y)) AS y,
      ROUND(AVG(corpAffecting.z)) AS z

FROM sumTable
INNER JOIN corpAffecting USING(cname)
WHERE cname IS NOT NULL
GROUP BY cname
ORDER BY cname;
