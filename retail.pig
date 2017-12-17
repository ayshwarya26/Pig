one  =  LOAD  '/home/hduser/2000.txt'  USING PigStorage(',')  AS  ( id, name, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double ,nov:double, dec:double);
--dump one;
two  =  LOAD  '/home/hduser/2001.txt'  USING PigStorage(',')  AS  ( id, name, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double ,nov:double, dec:double);
three  =  LOAD  '/home/hduser/2002.txt'  USING PigStorage(',')  AS  ( id, name, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double ,nov:double, dec:double);
--dump three;

column = foreach one generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as total2000;
--dump column;
column2 = foreach two generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as total2001;
--dump column2;
column3 = foreach three generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as total2002;
--dump column3;

retail = join column by $0, column2 by $0, column3 by $0;
--dump retail;
retail1 = foreach retail generate $0, $1, $2, $5, $8;
--dump retail1;
retail2 =  foreach retail1 generate $0, $1, $2, $3, $4, (($3-$2)/$2*100), (($4-$3)/$3*100);
--dump retail2;
retail3 = foreach retail2 generate $0, $1, $2, $3, $4, $5, $6, ROUND_TO((($5+$6)/2),2) as percent;
--dump retail3;
retail4 = filter retail3 by percent<-5;
--dump retail4;
retail5 = filter retail3 by percent>10;
--dump retail5;
retail6= foreach retail3 generate $0, $1, $2, ($2+$3+$4) as sales;
--dump retail6;
top = limit (order retail6 by sales desc) 5;
--dump top;
bot = limit (order retail6 by sales) 5;
dump bot;