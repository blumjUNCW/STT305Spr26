***********************************************************;
*  LESSON 2, PRACTICE 1                                   *;
*    a) Complete the PROC IMPORT step to read             *;
*       EU_SPORT_TRADE.XLSX. Create a SAS table named     *;
*       EU_SPORT_TRADE and replace the table              *;
*       if it exists.                                     *;
*    b) Modify the PROC CONTENTS code to display the      *;
*       descriptor portion of the EU_SPORT_TRADE table.   *;
*       Submit the program, and then view the output data *;
*       and the results.                                  *;
***********************************************************;

proc import datafile='~/Courses/PG1V2/data/eu_sport_trade.xlsx'
            out=EUSport
            dbms=xlsx replace;
run;

proc contents data=EUSport;
run;

/** Read in np_traffic.csv **/
proc import datafile='~/Courses/PG1V2/data/np_traffic.csv'
            dbms=csv  out=traffic  replace;
  guessingrows=all; /*first 20 rows doesn't get the correct length
                      for some variables**/
run;

