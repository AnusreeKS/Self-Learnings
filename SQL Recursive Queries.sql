use anu;
select * from employees;


-- _______________________________________Query to find the hierarchy of employees________________________________________________________________

WITH RECURSIVE Emp_Hierarchy as (
	SELECT EmployeeId, EmployeeName,ManagerId,1 As HierarchyLevel FROM Employees  WHERE ManagerID is Null
    UNION
    SELECT E.EmployeeId, E.EmployeeName,E.ManagerId, H.HierarchyLevel+1 As HierarchyLevel   
	FROM Emp_Hierarchy H	
    JOIN Employees E ON E.ManagerId = H.EmployeeId
   )
   SELECT EmployeeId, EmployeeName, NULL AS ManagerName, 1 As HierarchyLevel FROM Employees  WHERE ManagerID is Null
   UNION
   SELECT H2.EmployeeId, H2.Employeename AS EmployeeName, E2.EmployeeName AS ManagerName,H2.HierarchyLevel AS HierarchyLevel  FROM Emp_Hierarchy H2
   JOIN Employees E2 ON E2.EmployeeID=H2.ManagerID;
   
   -- _______________________ Query to find the manager hierarchy of a particular employee, lets say Grace)_______________________________________
   
   WITH RECURSIVE ManagerHierarachy AS (
	SELECT EmployeeId, EmployeeName,ManagerId, 1 As Level FROM Employees  WHERE EmployeeName="Grace"
    UNION
    SELECT E.EmployeeId, E.EmployeeName,E.ManagerId, H.Level+1 As HierarchyLevel
	FROM ManagerHierarachy H	
    JOIN Employees E ON H.ManagerId = E.EmployeeId
   )
   SELECT H2.EmployeeId, H2.Employeename AS EmployeeName, E2.EmployeeName AS ManagerName,H2.Level AS Level  FROM ManagerHierarachy H2
   JOIN Employees E2 ON E2.EmployeeID=H2.ManagerID;
   
    
WITH RECURSIVE Factorial(num,result) as (
	SELECT 1,1 
    UNION
    SELECT num+1,(Num+1)*result 
    FROM Factorial WHERE num < 10
)
SELECT * FROM Factorial;


WITH RECURSIVE Fibanocci(num,a,b) AS (
	SELECT 1,0,1 
    UNION
    SELECT num+1, b, a+b FROM Fibanocci
    WHERE num<10
) SELECT * FROM Fibanocci;    
