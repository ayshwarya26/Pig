book  =  LOAD  '/home/hduser/book-data'  USING PigStorage(',')  AS( bid:int, price:int, aid:int);
--dump book;
book1 = filter book by price>=200;
--dump book1;
author  =  LOAD  '/home/hduser/author-data'  USING PigStorage(',')  AS(aid:int, name:chararray);
author2 = filter author by INDEXOF(name,'J',0) == 0;

--dump author2;
final1 = join book1 by $2, author2 by $0;
--dump final1;
final = foreach final1 generate $0, $1, $2, $4;
dump final;
store final into '/home/hduser/output_author1';
