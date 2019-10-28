SELECT 
        cname,
        (SELECT COUNT(DISTINCT sname)
        FROM contributes
        WHERE contributes.cname = corporations.cname)
        AS u,
        COALESCE((SELECT MAX(amt) 
        FROM
            (SELECT sum(amt) as amt
             FROM contributes
             where contributes.cname = corporations.cname
             GROUP BY sname)
             AS senAmt), 
            0)
        AS v,
        COALESCE((SELECT MIN(amt) 
        FROM
            (SELECT sum(amt) as amt
             FROM contributes
             where contributes.cname = corporations.cname
             GROUP BY sname)
             AS senAmt),
            0)
        AS w,
        COALESCE((SELECT AVG(amt)
        FROM contributes
        WHERE contributes.cname = corporations.cname),
        0)
       AS x,
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
GROUP BY cname
ORDER BY cname;