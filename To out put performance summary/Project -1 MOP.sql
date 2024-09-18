WITH days_worked AS 
(
SELECT
	MACHINE, 
    Name, 
    COUNT(*) AS combination_count
FROM 
	mop
GROUP BY 
    MACHINE, Name
),

ranked_procution AS
(
SELECT
	m.machine,
    m.name,
    m.Production,
    d.combination_count,
    DENSE_RANK() OVER (PARTITION BY MACHINE ORDER BY Production DESC) AS production_rank
FROM 
	mop m
JOIN 
	days_worked d
ON 
	m.MACHINE = d.machine and 
    m.name = d.name
WHERE
	d.combination_count >= 10 )

SELECT 
	machine,
    name,
    production
FROM ranked_procution

WHERE 
	production_rank = 1
	
    
