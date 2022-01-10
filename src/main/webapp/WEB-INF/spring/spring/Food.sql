USE test;

-- FoodReply 테이블 생성
CREATE TABLE FoodReply (
	id INT PRIMARY KEY AUTO_INCREMENT,
    foodBoardId INT DEFAULT NULL,
    replyText VARCHAR(1000) NOT NULL,
    replyWriter VARCHAR(50) NOT NULL,
    inserted DATETIME NOT NULL DEFAULT NOW(),
    updateed DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE FoodFile (
	id INT PRIMARY KEY AUTO_INCREMENT,
    foodBoardId INT NOT NULL,
    foodFileUrl VARCHAR(500) NOT NULL,
    FOREIGN KEY (foodBoardId) REFERENCES Food(id)
);
CREATE TABLE FoodFile2 (
	id INT PRIMARY KEY AUTO_INCREMENT,
    foodBoardId INT NOT NULL,
    foodFileUrl VARCHAR(500) NOT NULL
);
CREATE TABLE FoodFile3 (
	id INT PRIMARY KEY AUTO_INCREMENT,
    foodFileUrl VARCHAR(500) NOT NULL
);

-- 좋아요 테이블 생성
CREATE TABLE LikeBoard (
	id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    foodBoardId INT DEFAULT 0,
    FOREIGN KEY(userId) REFERENCES User(id),
    FOREIGN KEY(foodBoardId) REFERENCES Food(id)
);


SELECT * FROM FoodFile3;
DROP TABLE FoodFile;
DESC FoodFile;
DESC File;
DESC Food;


-- id, foodFileUrl
INSERT INTO FoodFile (foodFileUrl) VALUES ('testUrl');

DESC FoodReply;
DESC FoodReply;
DESC ResellReply;
DESC Reply;
DESC User;
SELECT * FROM User;
SELECT * FROM Food ORDER BY inserted DESC;
DESC Food;
SELECT * FROM FoodReply ORDER BY id DESC;

-- 컬럼명 변경
ALTER TABLE FoodReply CHANGE replyWriter userName VARCHAR(50) NOT NULL;
ALTER TABLE FoodReply CHANGE updateed updated DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE FoodReply CHANGE userName userId VARCHAR(50) NOT NULL;
-- 컬럼 데이터 타입 변경
ALTER TABLE FoodReply MODIFY userId INT;
-- 컬럼 삭제
ALTER TABLE FoodReply DROP userId;
-- 컬럼 추가
ALTER TABLE FoodReply ADD userId INT NOT NULL;
ALTER TABLE Food ADD memberId INT NOT NULL;
ALTER TABLE Food ADD imageKey VARCHAR(500);

-- 테이블 조회
SELECT * FROM Food ORDER BY id DESC;
SELECT id,imageKey FROM Food ORDER BY inserted DESC;
SELECT * FROM User ORDER BY id DESC;

INSERT INTO FoodReply (foodBoardId, userId, replyText)
VALUES (149, 36, 123);

INSERT INTO Food (foodBoardId, userId, replyText)
VALUES (149, 36, 123);

DELETE FROM FoodReply WHERE id = 1;

-- 게시글 댓글 전체 보가
SELECT
	fr.id,
	fr.foodBoardId,
	fr.replyText,
	fr.userName,
	fr.inserted,
	fr.updated
FROM
	FoodReply fr JOIN Food f
ON
	fr.foodBoardId = f.id
WHERE
	fr.foodBoardId = 149
ORDER BY
	id DESC;
    
UPDATE FoodReply
  	SET
  		replyText = 'ReplyTest2',
  		updated = NOW()
  	WHERE
  		id = 3;

DESC Reply;
DESC User;
DESC Member;

SELECT * FROM User;

-- User의 name같이 조회 (JOIN User)
SELECT fr.*, u.name FROM FoodReply fr JOIN User u ON fr.userId = u.id; 
	SELECT
		fr.id,
		fr.foodBoardId,
		fr.replyText,
		fr.inserted,
		fr.updated,
        fr.userId,
		u.name
	FROM
		FoodReply fr JOIN User u
	ON
		fr.userId = u.id
	WHERE
		fr.foodBoardId = 161
	ORDER BY
		id DESC;
        
DELETE FROM FoodReply WHERE foodBoardId = 162;

-- 페이지 리스트 조회
SELECT
	f.id,
	f.title,
	f.writer,
	f.boardCnt,
	f.inserted,
	f.updated,
    COUNT(fr.id) FoodReplyCount
FROM
	Food f
		LEFT JOIN 
	FoodReply fr ON f.id = fr.foodBoardId
WHERE
	f.id > 0
GROUP BY f.id
ORDER BY f.id DESC, inserted DESC 
LIMIT 0, 10
;

-- 검색 결과 조회
SELECT
	COUNT(*)
FROM
	Food
where
	title
like concat('%','123','%')
;

