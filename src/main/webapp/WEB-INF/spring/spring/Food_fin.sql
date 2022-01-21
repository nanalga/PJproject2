USE pjproject;
DESC Food;
DESC FoodReply;

Use test;
DESC Food;
DESC User;
DESC FoodReply;
SELECT *FROM User;
DESC Resell;

SELECT * FROM Resell ORDER BY inserted DESC;
SELECT * FROM Food ORDER BY inserted DESC;
SELECT * FROM User ORDER BY id DESC;
ALTER TABLE Food ADD address VARCHAR(100);
alter TABLE Food MODIFY COLUMN contents text(20000);
alter TABLE Resell MODIFY COLUMN content text(20000);

SELECT * FROM Food ORDER BY id DESC;

alter table Food modify contents varchar(20000);


