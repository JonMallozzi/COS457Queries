SELECT 
      sname
FROM senators 
WHERE  NOT EXISTS(
                  SELECT 
                        1
                  FROM legislation 
                  WHERE legislation.legnum IN
                        (SELECT DISTINCT legnum FROM votes)
                  AND senators.sname NOT IN
                        (SELECT DISTINCT sname FROM votes 
                        WHERE legnum = legislation.legnum)
                 )
ORDER BY sname;