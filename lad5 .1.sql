USE AdventureWorks2019
Go

--Lấy ra dữ liệu của bảng Contact có ContactTypeID >= 3 và ContactTypeID <=9
SELECT * 
FROM Person.ContactType
WhERE ContactTypeID >= 3 AND ContactTypeID <= 9

--Lấy ra dữ liệu của bảng Contact có ContactTypeID trong đoạn [3, 9]
SELECT * FROM Person.ContactType
WHERE ContactTypeID BETWEEN 3 AND 9

--Lấy ra dữ liệu của bảng Contact có ContactTypeID trong tập hợp (3, 5, 9)
SELECT * FROM person.ContactType
WHERE ContactTypeID IN ( 1,3,5,9)

--Lấy ra những Contact có LastName kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName Like '%e'
--Lấy ra những Contact có LastName bắt đầu bởi ký tự R hoặc A kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '[RA]%e'
--Lấy ra những Contact có LastName có 4 ký tự bắt đầu bởi ký tự R hoặc A kết thúc bởi những ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '[RA]__e'

SELECT * FROM person.Person
WHERE LastName LIKE '%A%'

--Sử dụng DISTINCT các dư liệu trùng lặp bị loại bỏ
SELECT DISTINCT Title FROM Person.Person

--Sử dụng GROUP BY các dữ liệu trùng lặp được gộp thành nhóm
SELECT Title FROM Person.Person GROUP BY Title
--do đó ta có thể sử dụng được với các hàm tập hợp
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
GROUP BY Title

--Ta có thể sử dụng mệnh đề thỏa mãn điều kiện tìm kiếm
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person 
WHERE Title LIKE 'Mr%'
GROUP BY Title

--GROUP BY với HAVING mệnh đề HAVING sẽ lọc kết quả trong lúc được gộp nhóm
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
GROUP BY ALL Title
HAVING Title LIKE 'Mr%'

--GROUP BY với CUBE: SẼ có thêm một hàng siêu kết hợp gộp tất cả hàng trong tập trả về

--ORDER BY dùng để sắp xếp kết quả trả về
SELECT * FROM Person.Person
ORDER BY FirstName , LastName DESC

--Truy vấn từ nhiều bảng. Lấy toàn bộ Contact của nhân viên
SELECT * FROM Person.Person
SELECT * FROM HumanResources.Employee