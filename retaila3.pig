--RETAIL A3
retail  =  LOAD  '/home/hduser/D'  USING PigStorage(';')  AS  ( date:chararray, custid:long, age, area, category, prodid, qty, cost:float, sales:float );
 --dump retail;
retail = foreach retail generate $5 as custid, $7 as cost, $8 as sales;
--dump retail;
a = group retail by $0;
--dump a;
--describe a;
b = foreach a generate group as custid, SUM((retail.cost)) as cost, SUM((retail.sales)) as sales ;
--dump b;
d = foreach b generate $0, $1 as cost, (sales-cost)*100 as aa;
--dump d;
e = foreach d generate $0, ROUND_TO(aa/cost,2) as percent;
--dump e;
c = limit (order e by percent desc) 5;
dump c;
