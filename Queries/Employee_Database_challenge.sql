-- Joining employee and titles tables to create retirement_titles

SELECT e.emp_no,
       e.first_name, 
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (rt.emp_no) 
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles 
FROM retirement_titles as rt
WHERE to_date >= '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Number of employees retiring by job title

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY COUNT DESC;

-- -- Number of employees eligible for mentorship program

SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name, 
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;