SELECT 
sname,
age,
stname 
FROM senators
WHERE
    (
        gender = 'Female' 
        AND party='Republican' 
        AND age > 50
    )
OR 
    (
        gender='Male' 
        AND party='Democrat' 
        AND age < 50
    )
order by sname;
