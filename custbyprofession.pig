cust = load  '/home/hduser/custs'  using  PigStorage(',')  AS ( custid, firstname, lastname, age:long, profession);
--dump cust;
gbp = group cust by profession;
--dump  gbp;
countbyprofession = FOREACH gbp GENERATE group as profession, COUNT (cust) as headcount;
--dump countbyprofession;
obp = order countbyprofession by $0;
dump obp;
store obp into 'home/hduser/pig/output_custbyprofesssion';

--orderbycount = order countbyprofession by $1 desc;
--dump orderbycount;
--topprof = limit orderbycount 10;
--dump topprof;

