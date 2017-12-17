--RETAIL A1
retail  =  LOAD  '/home/hduser/D'  USING PigStorage(';')  AS  ( date:chararray, custid:long, age, area, category, prodid, qty, cost:int, sales:int );
 --dump retail;
retail1 = foreach retail generate $0 as date, $1 as custid, $8 as sales ;
--dump retail1;
d = limit (order retail1 by sales desc) 1;
dump d;
