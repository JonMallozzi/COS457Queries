SELECT 
      corporations.stname, 
      cname, 
      sname, 
      age, 
      totrev, 
      population 
FROM senators
JOIN corporations USING(stname)
JOIN states USING(stname)
WHERE 
    gender = 'Female' 
    AND party ='Democrat' 
    AND totrev > (population * 3/2)
ORDER BY corporations.stname, cname, sname;
