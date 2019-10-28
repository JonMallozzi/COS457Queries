SELECT 
        sname,
        COUNT(vdate) AS u,
        SUM( CASE
                  WHEN howvoted = 'Yea'
                  THEN 1
                  ELSE 0
            END )  
            AS v,
        SUM( CASE
                  WHEN howvoted = 'Nay' 
                  THEN 1
                  ELSE 0
            END )  
            AS w,
        COALESCE(to_char(MAX(
             CASE 
                 WHEN howvoted = 'Yea'
                 THEN vdate
                 ELSE null
             END),'YYYY-MM-DD'), 'n/a') 
             AS x,
        COALESCE(to_char(MAX(
            CASE 
                 WHEN howvoted = 'Nay'
                 THEN vdate
                 ELSE null
             END
        ),'YYYY-MM-DD'), 'n/a') AS y,
        COALESCE(to_char(MIN(
            CASE 
                 WHEN howvoted = 'Abstain'
                 THEN vdate
                 ELSE null
             END
        ),'YYYY-MM-DD'), 'n/a') AS z
FROM votes 
FULL OUTER JOIN senators USING (sname)
GROUP BY sname
ORDER BY sname;