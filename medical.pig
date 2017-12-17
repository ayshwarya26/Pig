medical  =  LOAD  '/home/hduser/medical'  USING PigStorage('\t')  AS  ( name:chararray, dept, salary:int);
medical = foreach medical generate $0, $2;
--dump medical;
a = group medical by name;
--dump a;
b = foreach a generate $0, ROUND_TO(AVG(medical.salary),2);
dump b;
