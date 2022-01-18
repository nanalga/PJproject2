USE pjproject;
DESC Food;
DESC FoodReply;

Use test;
DESC Food;
DESC FoodReply;

ALTER TABLE Food ADD address VARCHAR(100);

SELECT * FROM Food ORDER BY id DESC;