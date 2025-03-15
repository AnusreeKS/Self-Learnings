# Recursive Queries in MySQL

### Introduction

Recursive queries in MySQL are used to handle hierarchical or tree-structured data, such as employee-manager relationships, category hierarchies, and bill-of-materials structures. MySQL 8.0 introduced Common Table Expressions (CTEs) with recursion, enabling queries to reference their own results.


To demonstrate recursive queries, we will create an employees table that represents an organizational hierarchy.

Create Table

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

Insert Sample Data

INSERT INTO employees (id, name, manager_id) VALUES
(1, 'Alice', NULL),  -- Alice is the CEO (no manager)
(2, 'Bob', 1),       -- Bob reports to Alice
(3, 'Charlie', 1),   -- Charlie reports to Alice
(4, 'David', 2),     -- David reports to Bob
(5, 'Eve', 2),       -- Eve reports to Bob
(6, 'Frank', 3);     -- Frank reports to Charlie

Recursive Query: Finding Employee Hierarchy

This query retrieves all employees under a specific manager, displaying hierarchical levels.

WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: Find the top-level manager (e.g., Alice)
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: Find employees reporting to previous level employees
    SELECT e.id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM EmployeeHierarchy;

Explanation

Anchor Query: Finds the highest-level employee (e.g., CEO).

Recursive Query: Iterates to find all subordinates of each employee.

Termination: Stops when no more employees are found.



### Use Cases

Organizational hierarchy (Employees & Managers)

Category hierarchy in e-commerce (Parent-Child Categories)

Bill of materials (BOM) in manufacturing

Navigating tree structures (e.g., file systems)

Conclusion

Recursive queries are powerful for handling hierarchical data in SQL. MySQL’s WITH RECURSIVE CTEs make it easier to traverse such structures efficiently.
