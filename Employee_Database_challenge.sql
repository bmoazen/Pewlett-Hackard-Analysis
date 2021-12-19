--Deliverable 1 
--Get EMployees eligible for retirement
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
RIGHT JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
		first_name,
		last_name,
		title
INTO unique_titles
FROM retirement_titles
WHERE to_date='9999-01-01'
ORDER BY emp_no, to_date DESC;

--Get number of retirees by title
SELECT COUNT(title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY Count(title) DESC


--Deliverable 2
-- Employees eligible for the Mentorship Program 
-- Use only the first employee number occurance
SELECT DISTINCT ON (n1.emp_no) n1.emp_no, n1.first_name, 
		n1.last_name, n1.birth_date,
        n1.from_date, n1.to_date,
        n1.title
INTO mentorship_eligibility
FROM
    (SELECT e.emp_no, e.first_name, e.last_name, e.birth_date,
            de.from_date, de.to_date,
            t.title
    FROM employees as e
    LEFT JOIN dept_emp as de
    ON (e.emp_no=de.emp_no)
    LEFT JOIN titles as t
    ON (e.emp_no=t.emp_no)) as n1
WHERE (n1.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY n1.emp_no


-- Mentorship Eligibility by Titles
SELECT COUNT(title),title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY Count(title) DESC
