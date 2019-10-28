WITH senSponsors AS(
    SELECT DISTINCT sname, 't' AS u
    FROM senators
    JOIN sponsors USING (sname)
),
senOpposed AS(
    SELECT DISTINCT sname, 't' AS v
    FROM senators
    JOIN opposes USING (sname)
),
senRecevieCon AS(
    SELECT DISTINCT sname, 't' AS w
    FROM senators
    JOIN contributes USING (sname)
),
senVoted AS(
    SELECT DISTINCT sname, 't' AS x
    FROM senators
    JOIN votes USING (sname)
    where howvoted != 'abstain'
)
SELECT 
       sname, 
       COALESCE(u, 'f') AS u,
       COALESCE(v, 'f') AS v,
       COALESCE(w, 'f') AS w,
       COALESCE(x, 'f') AS x   
FROM senators 
FULL OUTER JOIN senSponsors USING (sname)
FULL OUTER JOIN senOpposed USING (sname)
FULL OUTER JOIN senRecevieCon USING (sname)
FULL OUTER JOIN senVoted USING (sname)
ORDER BY sname ASC;