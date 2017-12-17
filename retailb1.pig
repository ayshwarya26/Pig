--RETAIL B1
retail  =  LOAD  '/home/hduser/D/D01'  USING PigStorage(';')  AS  ( date:chararray, custid:long, age, area, category, prodid, qty, cost:int, sales:int );
 --dump retail;
retail1 = foreach retail generate  $5 as prodid, $8 as sales ;
--dump retail1;
a = group retail1 by $0;
--dump a;
--describe a;
b = foreach a generate group as prodid, SUM((retail1.sales)) as totsales ;
--dump b;
c = limit(order b by totsales desc) 4;
dump c;
