-- Number of Retiring Employees by Title
SELECT e.emp_no, 
	e.first_name, e.last_name,
    t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
	INNER JOIN titles as t
		ON t.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '01-01-1952' AND '12-31-1955'
ORDER BY e.emp_no;

-- Unique retiring employees 
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, e.last_name,
    t.title, t.from_date, t.to_date
INTO unique_titles
FROM employees as e
	INNER JOIN titles as t
		ON t.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '01-01-1952' AND '12-31-1955'
	AND t.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, t.to_date DESC;

-- Number of employees by their most recent job title
SELECT count(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count desc;

-- Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name,
	e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_emp as de
		ON de.emp_no = e.emp_no
	INNER JOIN titles as t
		ON t.emp_no = e.emp_no
WHERE t.to_date = '9999-01-01'
	AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;