SELECT cname, 
      MIN(cdate) AS u, 
      MAX(cdate) AS v, 
      COUNT(cname) AS w, 
      SUM(amt) AS x, AVG(amt) AS y, 
      COUNT(DISTINCT sname) AS z
FROM Contributes
GROUP BY cname
HAVING AVG(amt) >= (SELECT AVG(amt) FROM Contributes)
ORDER BY cname;
