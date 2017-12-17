--RETAIL A2
retail  =  LOAD  '/home/hduser/D'  USING PigStorage(';')  AS  ( date:chararray, custid:long, age, area, category, prodid, qty, cost:int, sales:int );
 --dump retail;
retail1 = foreach retail generate $5, ($8-$7) as profit;
--dump retail1;
a = group retail1 by $0;
--dump a;
--describe a;
b = foreach a generate group as prodid, SUM((retail1.profit)) as profit ;
--dump b;
c = limit (order b by profit desc) 5;
dump c;
