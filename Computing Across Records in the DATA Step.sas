libname SASData '~/SASData';

/*make a table where for each fund I have the
  3 & 6 month returns and 1, 2, & 3 year returns
  for an end date of end of year 2006*/

proc sort data=SASData.index out=indexSort;
  by descending date;
run;/*reverse chronological ordering is best here*/

data step1;
  set indexSort;

  /*to get the 3 month return, mulitply 1+return together
    for the last three months of the year (first 3 records)*/

  Ret3MoR100V = (1+r1000value)*(1+lag(r1000value))*(1+lag2(r1000value))-1;

  if _n_ eq 3 then output;

run;/**this is the computation I want, but I need to hold the result
      until I've finished the 6 month, 1, 2, and 3 year
      and output them all together...*/

/**So, it's better to accumulate as you go through the data, 
  create the intermediate calculations at the right point and
    output them all at the end*/


proc transpose data=indexSort out=forComputing(rename=(col1=return));
  by descending dt;
  var cg3mtb--sp500;
run;

proc sort data=forComputing;
  by _name_ descending dt;
  where dt ge '01JAN2004'd;
run;

data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet; /**hold the value when reading the next record*/
  if first._name_ then totalRet = 1;

  TotalRet = TotalRet*(1+return);
    /**try to make an accumulating return value
      but it needs to be 
        initialized
        and
        retained
        */
run;
