proc freq data=sashelp.stocks;
  where high gt 110;
  table date;
  /*not a great table, each date is its own category*/
run;

/*SAS provides formats to change the display of values 
 (and we can make our own), but categorization is also
 done with respect to the active format*/

proc freq data=sashelp.stocks;
  where high gt 110;
  table date;
  format date monname.;
  /*monname displays dates as month name only,
    so each category is a month name...**/
run;

proc freq data=sashelp.stocks;
  where high gt 110;
  table date;
  format date year.;
  /*This time, it's years**/
run;

proc freq data=sashelp.stocks order=formatted;
  where high gt 110;
  table date;
  format date qtr.;
  /*This time, it's quarters**/
run;