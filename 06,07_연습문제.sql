-- 서브쿼리 예시1.

-- 부서코드가 노옹철 사원과 같은 부서 소속의 직원의
-- 이름과 부서코드 조회
SELECT EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE 
										FROM EMPLOYEE 
										WHERE EMP_NAME = '노옹철');
-- AND EMP_NAME != '노옹철';


-- 서브쿼리 예시2.
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT CEIL(AVG(SALARY)) FROM EMPLOYEE);



-- 전 직원의 급여 평균보다 많은(초과) 급여를 받는 직원의 
-- 이름, 직급명, 부서명, 급여를 직급 순으로 정렬하여 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY  > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE ;



-- 가장 적은 급여를 받는 직원의 
-- 사번, 이름, 직급명, 부서코드, 급여, 입사일 조회

-- 서브 쿼리 (가장 적은 급여를 받는 직원)
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 메인 쿼리 (사번...)
SELECT EMP_NO, EMP_NAME, JOB_NAME, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MIN(SALARY)
								FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 많은(초과) 급여를 받는 직원의 
-- 이름, 직급명, 부서명, 급여를 직급 순으로 정렬하여 조회

-- 서브 쿼리 (전 직원의 급여 평균)
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 메인 쿼리 (이름... 직급 순)
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT AVG(SALARY)
								FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- SELECT 절에 명시되지 않은 컬럼이라도
-- FROM, JOIN으로 인해 테이블상 존재하는 컬럼이라면
-- ORDER BY 절 사용 가능!


-- 가장 적은 급여를 받는 직원의 
-- 사번, 이름, 직급명, 부서코드, 급여, 입사일 조회

-- 서브쿼리 (가장 적은 급여)
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 메인쿼리 + 서브쿼리
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MIN(SALARY)
								FROM EMPLOYEE);

-- 노옹철 사원의 급여보다 많이 (초과) 받는 직원의
-- 사번, 이름, 부서명, 직급명, 급여조회

-- 서브 쿼리 (노옹철 사원의 급여)
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 메인 쿼리 (사번...)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
								FROM EMPLOYEE
								WHERE EMP_NAME = '노옹철');

-- (EMPLOYEE + JOB) + DEPARTMENT -> LEFT JOIN
-- 사원의 행 하나에 있는 DEPT_CODE 안에 있는 내용이 NULL이어도 가져오겠다.

-- (EMPLOYEE + DEPARTMENT) + JOB -> LEFT JOIN
-- 사원의 행 하나에 있는 DEPT_CODE 안에 있는 내용이 NULL이면 이미 날라감.

-- 부서별(부서가 없는 사람 포함) 급여의 합계 중
-- 가장 큰 부서의 부서명, 급여 합계를 조회

-- 1) 부서별 급여 합 중 가장 큰 값 조회 (서브쿼리)


-- 2) 부서별 급여합이 17,700,000인 부서의 부서명과 급여합 조회


-- 3) 위의 두쿼리를 합쳐 부서별 급여 합이 가장 큰 부서의
-- 부서명, 급여합 조회


-------------------------------------------------------------------------

-- 2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
-- 서브쿼리의 조회 결과 값의 개수가 여러행일 때

/*
 * >> 다중행 서브쿼리 앞에는 일반 비교연산자 사용불가
 * 
 * - IN / NOT IN : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면
 * 								혹은 없다면 이라는 의미(가장 많이 사용)
 * 
 * - > ANY , < ANY : 여러개의 결과값 중에서 한 개라도 큰 / 작은 경우
 * 								--> 가장 작은 값보다 큰가? / 가장 큰 값보다 작은가?
 * 
 * - > ALL , < ALL : 여러개의 결과값의 모든 값보다 큰 / 작은 경우
 * 								--> 가장 큰 값보다 큰가? / 가장 작은 값보다 작은가?
 * 
 * - EXISTS . NET EXISTS : 값이 존재하는가? / 존재하지 않는가?
 * 
 * */

-- 부서별 최고 급여를 받는 직원의
-- 이름, 직급, 부서, 급여를
-- 부서 오름차순으로 정렬하여 조회

-- 부서별 최고 급여 조회 (서브쿼리)


-- 메인쿼리 + 서브쿼리
						


-- 사수에 해당하는 직원에 대해 조회
-- 사번, 이름, 부서명, 직급명, 구분(사수/사원) 조회

-- * 사수 == MANAGER_ID 컬럼에 작성된 사번인 사람


-- 1) 사수에 해당하는 사원 번호 조회하기


-- 2) 직원의 사번, 이름, 부서명, 직급명 조회(메인 쿼리)


-- 3) 사수에 해당하는 직원에 대한 정보 추출 조회(구분 : 사수)

-- 4) 일반 직원에 해당하는 사원들 정보 조회 (구분은 '사원')

-- 5) 3, 4 의 조회 결과를 하나로 조회

-- 1. 집합 연산자(UNION 합집합) 사용하기


-- 2. 선택함수 사용
--> DECODE();
--> CASE WHEN 조건1 THEN 값1 .. ELSE END


-- 대리 직급의 직원들 중에서
-- 과장 직급의 최소 급여보다
-- 많이 받는 직원의
-- 사번, 이름, 직급명, 급여 조회

-- > ANY : 가장 작은 값보다 크냐? 

-- 1) 직급이 대리인 직원들의 사번, 이름, 직급, 급여 조회(메인쿼리)


-- 2) 직급이 과장인 직원들의 급여조회 (서브쿼리)


-- 3) 대리 직급의 직원들 중에서
-- 과장 직급의 최소 급여보다
-- 많이 받는 직원의
-- 사번, 이름, 직급명, 급여 조회

-- 방법1) ANY를 이용하기


-- > ANY : 가장 작은 값 보다 큰가?
--> 과장 직급 최소 급여보다 큰 급여를 받는 대리인가?

-- < ANY : 가장 큰 값 보다 작은가?
--> 과장 직급 최대 급여보다 적은 급여를 받는 대리인가?

-- 대리 직급의 직원들 중에서
-- 과장 직급의 최소 급여보다
-- 많이 받는 직원의
-- 사번, 이름, 직급명, 급여 조회

-- 방법2) MIN을 이용해서 단일행 서브쿼리로 만듦



-- 차장 직급의 급여 중 가장 큰값보다 많이 받는 과장 직급의 직원
-- 사번, 이름, 직급, 급여 조회

-- > ALL, < ALL : 가장 큰 값보다 크냐? / 가장 작은 값보다 작냐?

-- 서브쿼리


-- 메인 쿼리 + 서브 쿼리


--  > ALL : 가장 큰값 보다 큰가?
-- > 차장 직급의 최대 급여보다 많이 받는 과장인가?

--  > ALL : 가장 작은 값보다 작은가?
-- > 차작 직급의 최소 급여보다 적게 받는 과장인가?

-- 서브쿼리 충첩 사용 (응용편!)

-- LOCATION 테이블에서 NATIONAL_CODE가 KO인 경우의 LOCAL_CODE와 (첫번째 서브쿼리)

-- DEPARTMENT 테이블의 LOCATION_ID와 동일한 DEPT_ID가 (두번째 서브쿼리)
 
-- EMPLOYEE 테이블의 DEPT_CODE와 동일한 사원 조회해라. (메인 쿼리)

-- 1) LOCATION 테이블에서 NATIONAL_CODE가 KO인 경우의 LOCAL_CODE 조회


-- 2) DEPARTMENT 테이블에서 위의 결과 (L1)와 
-- 동일한 LOCATION_ID를 가진 DEPT_ID 조회


-- 3) 최종적으로 EMPLOYEE 테이블에서 취의 결과들과 동일한 DEPT_CODE를 가진 사원 조회


----------------------------------------------------------------------------

-- 3. (단일) 다중열 서브쿼리
-- 서브쿼리 SELECT 절에 나열된 컬럼수가 여러개 일 때

-- 퇴사한 여직원과 같은 부서, 같은 직급에 대항하는 
-- 사원의 이름, 직급코드, 부서코드, 입사일 조회

-- 1) 퇴사한 여직원 조회


-- 2) 퇴사한 여직원과 같은 부서, 같은 직급 조회

-- 방법 1) 단일행 단일열 서브쿼리 2개를 사용해서 조회


-- 방법 2) 다중열 서브쿼리 사용
--> WHERE 절에 작성된 컬럼 순서에 맞게
-- 서브쿼리의 조회된 컬럼과 비교하여 일치하는 행만 조회
-- 컬럼 순서가 중요!!



-----------------------연습 문제--------------------------------

-- 1. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회(단, 노용철 제외)
-- 사번, 이름, 부서코드, 직급코드 , 부서명, 직급명

-- 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회



-- 2. 2000년도에 입사한 사원의 부서와 직급이 같은 사원을 조회
-- 사번, 이름, 부서코드, 직급 코드, 입사일



-- 3. 77년생 여자 사원과 동일한 부서이면서
-- 동일한 사수를 가지고 있는 사원 조회
-- 사번, 이름, 부서코드, 사수번호, 주민번호, 입사일




---------------------------------------------------------------------

-- 4. 다중행 다중열 서브쿼리
-- 서브쿼리 조회 결과 행 수와 열 수가 여러개 일 때

-- 본인이 소속된 직급의 평균 급여를 받고있는 직원의 
-- 사번, 이름, 직급코드, 급여 조회
-- 단, 급여와 급여 평균은 만원단위로 조회 TRUNC(컬럼명, -4)


-- 1) 직급별 평균 급여 (서브쿼리)


-- 2) 사번, 이름, 직급코드, 급여 조회 (메인쿼리 + 서브쿼리)



-- 1. 전지연 사원이 속해있는 부서원들을 조회하시오 (단, 전지연은 제외)
-- 사번, 사원명, 전화번호, 고용일, 부서명

SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME = '전지연';

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE
									WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';


-- 2. 고용일이 2000년도 이후인 사원들 중 급여가 가장 높은 사원의
-- 사번, 사원명, 전화번호, 급여, 직급명을 조회하시오.
SELECT MAX(SALARY) FROM EMPLOYEE
WHERE EXTRACT (YEAR FROM HIRE_DATE) = 2000;

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY = (SELECT MAX(SALARY) 
FROM EMPLOYEE
WHERE HIRE_DATE > '2000-01-01');

-- 3. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회하시오. (단, 노옹철 사원은 제외)
-- 사번, 이름, 부서코드, 직급코드, 부서명, 직급명
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE
															WHERE EMP_NAME = '노옹철')
															AND EMP_NAME != '노옹철';


-- 4. 2000년도에 입사한 사원과 부서와 직급이 같은 사원을 조회하시오
-- 사번, 이름, 부서코드, 직급코드, 고용일
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE
WHERE EXTRACT (YEAR FROM HIRE_DATE) = 2000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE
WHERE EXTRACT (YEAR FROM HIRE_DATE) = 2000);


-- 5. 77년생 여자 사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원을 조회하시오
-- 사번, 이름, 부서코드, 사수번호, 주민번호, 고용일
SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NO LIKE '77%'	AND SUBSTR(EMP_NO, 8, 1) = '2';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID FROM EMPLOYEE
WHERE EMP_NO LIKE '77%'	AND SUBSTR(EMP_NO, 8, 1) = '2');


-- 6. 부서별 입사일이 가장 빠른 사원의
-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
-- 입사일이 빠른 순으로 조회하시오
-- 단, 퇴사한 직원은 제외하고 조회..

SELECT EMP_ID, EMP_NAME, DEPT_CODE, NVL(DEPT_TITLE, '소속없음'),
JOB_NAME, HIRE_DATE
FROM EMPLOYEE MAIN
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)
								FROM EMPLOYEE SUB
								WHERE MAIN.DEPT_CODE = SUB.DEPT_CODE
								AND ENT_YN = 'N' 
								OR (SUB.DEPT_CODE IS NULL AND 
								MAIN.DEPT_CODE IS NULL)) -- 소속없음까지 포함
ORDER BY HIRE_DATE;


-- 7. 직급별 나이가 가장 어린 직원의
-- 사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회하고
-- 나이순으로 내림차순 정렬하세요
-- 단 연봉은 \124,800,000 으로 출력되게 하세요. (\ : 원 단위 기호)


SELECT EMP_ID, EMP_NAME, JOB_NAME, 
FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) / 12 ) "나이", 
TO_CHAR(SALARY * (1 + NVL(BONUS, 0)) * 12, 'L999,999,999') "보너스 포함 연봉"
FROM EMPLOYEE MAIN
--JOIN JOB USING(JOB_CODE)
JOIN JOB J ON (MAIN.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 6) = (SELECT MAX(SUBSTR(EMP_NO, 1, 6))
							FROM EMPLOYEE SUB 
							WHERE MAIN.JOB_CODE = SUB.JOB_CODE)
ORDER BY "나이" DESC;




