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


