-- 1. 


-- 2. 



-- extra for database consistency


CREATE trigger stud_trg
 BEFORE DELETE OR UPDATE
 ON students
 FOR EACH ROW
 EXECUTE function fn_stud_logs_trg();