weblog  =  LOAD  '/home/hduser/weblog'  USING PigStorage('\t')  AS  ( user:chararray, pg:chararray,time);

--dump weblog1;
gateway =  LOAD  '/home/hduser/gateway'  USING PigStorage('\t')  AS  ( pg:chararray,rate:double);
--dump gateway;
a = join weblog by $1, gateway by $0;
--dump a;
b = foreach a generate $0 as name, $1, $4 as rate;
--dump b;
c = group b by name;
--dump c;
d = foreach c generate $0, AVG(b.rate) as avg;
--dump d;
e = filter d by avg >90;
dump e;
--store e into '/home/hduser/output_payment';
