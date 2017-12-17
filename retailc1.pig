--RETAIL C1
retail  =  LOAD  '/home/hduser/D'  USING PigStorage(';')  AS  ( date:chararray, custid:long, age:chararray, area, category, prodid, qty, cost:int, sales:int );
 --dump retail;
retail = foreach retail generate $5 as prodid, $7 as cost, $8 as sales, $2 as age;
--dump retail;
x = filter retail by age== 'A ';
--dump x;
--describe x;
a = group x by $0;
--dump a;
--describe a;
b = foreach a generate $0, (SUM(x.sales)- SUM(x.cost)) as profit, flatten(x.age);
--dump b;
d = filter b by $1>0;
--dump d;
b1 = distinct b;
--dump b1;
c = limit (order b1 by profit desc) 5 ;
dump c;
