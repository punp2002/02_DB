SELECT * FROM TB_DEPARTMENT;
SELECT DEPARTMENT_NAME, CATEGORY FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME ||'의 정원은 ' || CAPACITY ||' 명입니다.' AS "학과별 정원" FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NO, DEPARTMENT_NAME  FROM TB_DEPARTMENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001'
AND SUBSTR(STUDENT_SSN, 8, 1 ) = 2
AND ABSENCE_YN = 'Y';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

SELECT DISTINCT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;








