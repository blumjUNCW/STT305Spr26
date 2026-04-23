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
  if first._name_ then totalRet = 1;/*each time we get to a new
                                    fund, reset my total return -- 1 is 
                                    my identity value for multiplication*/

  TotalRet = TotalRet*(1+return);
    /**try to make an accumulating return value
      but it needs to be 
        initialized
        and
        retained
        */
run;/**All that I want is in here, but it's not the right form
      and it has extra stuff*/

data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet; 
  if first._name_ then totalRet = 1;

  TotalRet = TotalRet*(1+return);

  /*When would I create the 3 month return?
    try not to use any specific dates so this works for an
      arbitrary ending point*/
  if _n_ eq 3 then output;
    /*This would work only for the first fund...I
        need my own counter that I can reset for each fund*/

run;

data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet months;/*retain both accumulators...*/ 

  if first._name_ then do;
    totalRet = 1;
    months = 0;
  end;/*...reset both accumulators when starting a new fund*/

  TotalRet = TotalRet*(1+return);
  months = months+1; /*count how many months have been included..*/

  /*When would I create the 3 month return?
    try not to use any specific dates so this works for an
      arbitrary ending point*/

  if months eq 3 then output;

run;


data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet months; 
  if first._name_ then do;
    totalRet = 1;
    months = 0;
  end;

  TotalRet = TotalRet*(1+return);
  months = months+1;

  /**Let's clean up what we are outputting... */

  if months eq 3 then do;
    Ret3Month = TotalRet - 1;
    output;
  end;

  keep _name_ Ret3Month;
  rename _name_ = Fund;
  format Ret3Month percentn8.3;
run;



data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet months Ret3Month; 
  if first._name_ then do;
    totalRet = 1;
    months = 0;
  end;

  TotalRet = TotalRet*(1+return);
  months = months+1;

  /**Add in 6 month return */

  if months eq 3 then do;
    Ret3Month = TotalRet - 1;
  end;

  if months eq 6 then do;
    Ret6Month = TotalRet - 1;
    *output;
  end;

  *keep _name_ Ret3Month Ret6Month;
  rename _name_ = Fund;
  format Ret3Month Ret6Month percent12.3;
run;

data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet months Ret3Month Ret6Month Ret1Year Ret2Year; 
  if first._name_ then do;
    totalRet = 1;
    months = 0;
  end;

  TotalRet = TotalRet*(1+return);
  months = months+1;

  /**Add in 6 month return */

  if months eq 3 then Ret3Month = TotalRet - 1;
  if months eq 6 then Ret6Month = TotalRet - 1;
  if months eq 12 then Ret1Year = TotalRet - 1;
  if months eq 24 then Ret2Year = TotalRet - 1;
  if months eq 36 then do;/*this is the last value computed...*/
    Ret3Year = TotalRet - 1;
    output;/*so, it's when I want to output*/
  end;

  keep _name_ Ret3Month Ret6Month Ret1Year Ret2Year Ret3Year;
  rename _name_ = Fund;
  format Ret3Month Ret6Month Ret1Year Ret2Year Ret3Year percent12.3;
run;


data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet months Ret3Month Ret6Month Ret1Year Ret2Year; 
  if first._name_ then do;
    totalRet = 1;
    months = 0;
  end;

  TotalRet = TotalRet*(1+return);
  months = months+1;


  if months eq 3 then Ret3Month = TotalRet - 1;
  if months eq 6 then Ret6Month = TotalRet - 1;
  if months eq 12 then Ret1Year = TotalRet - 1;
  if months eq 24 then Ret2Year = TotalRet - 1;
  if last._name_ then do;
    /*since I limited to 36 months when I sorted,
      I can use last. for the fund name to decide
        the final output time*/
    Ret3Year = TotalRet - 1;
    output;
  end;

  keep _name_ Ret3Month Ret6Month Ret1Year Ret2Year Ret3Year;
  rename _name_ = Fund;
  format Ret3Month Ret6Month Ret1Year Ret2Year Ret3Year percent12.3;
run;

data returns;
  set forComputing;
  by _name_ descending dt;

  retain totalRet Ret3Month Ret6Month Ret1Year Ret2Year; 
  if first._name_ then do;
    totalRet = 1;
    months = 0;
  end;

  TotalRet = TotalRet*(1+return);
  months+1;
    /* variable + expression;
      is called a sum statement
        computes the sum and stores it back into the variable
        it's automatically retained
        automatically set to 0 when _N_ eq 1*/


  if months eq 3 then Ret3Month = TotalRet - 1;
  if months eq 6 then Ret6Month = TotalRet - 1;
  if months eq 12 then Ret1Year = TotalRet - 1;
  if months eq 24 then Ret2Year = TotalRet - 1;
  if last._name_ then do;
    Ret3Year = TotalRet - 1;
    output;
  end;

  keep _name_ Ret3Month Ret6Month Ret1Year Ret2Year Ret3Year;
  rename _name_ = Fund;
  format Ret3Month Ret6Month Ret1Year Ret2Year Ret3Year percent12.3;
run;