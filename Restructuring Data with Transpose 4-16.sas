libname IPEDS305 '~/IPEDS305';/*Use data from here...*/
options fmtsearch=(IPEDS305);/*...and associated formats*/

/**I can restructure rows into columns or vice-versa with
PROC TRANSPOSE*/

proc transpose data=ipeds305.gr2023;
run;

proc transpose data=ipeds305.hd2023;
run;/*by default, only numeric columns are transposed...*/

proc transpose data=ipeds305.hd2023;
    var unitID--c21basic;/*..you can transpose anything,
                          but mixing of types causes conversion to character*/
run;
/*transpose always sends output to new data-- DataN if you do not specify
  where N is a counter*/

/**We will use an out= option typically, and BY grouping */

proc transpose data=ipeds305.gr2023 out=gr23T;
  by unitid; /*for each unitID...*/
  var grtotlt;/*..transpose this variable*/
run;/*each unitID has up to two rows for the column grtotlt,
    so the result is a row for each unitid with values corr to grtotlt
    as columns*/

proc transpose data=ipeds305.gr2023 
                out=gr23T(drop=_: rename=(col1=incoming col2=Graduates));
              /*use your data set options to help you*/
  by unitid; 
  var grtotlt;
run;

proc transpose data=ipeds305.gr2023 
                out=gr23T2(rename=(col1=Incoming col2=Graduates));
  by unitid; 
  var grtotl:;
run;

data grads23;
  set gr23T2;

  GradRate = Graduates/Incoming;
  Group = propcase(scan(_label_,2));

  drop _:;

run;

proc transpose data=grads23 out=grads23B;
  by unitid;
  var incoming graduates gradrate;
  id group;
  /*group is suitable for variable naming,
    so it can be passed as an ID variable*/
run;

