SELECT DISTINCT 
                cname, 
                legnum, 
                sname 
FROM sponsors 
JOIN affected_by USING(legnum)
JOIN contributes USING(sname, cname)
JOIN senators USING(sname)
JOIN corporations USING(cname)
WHERE 
    howafctd='Favorably' 
    AND corporations.stname != senators.stname
    AND party='Republican' 
    AND totrev >= 10000000
ORDER BY cname, legnum, sname;
