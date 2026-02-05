/**PROC SORT is used to sort rows in a data set...**/
proc sort data=sashelp.cars;
  by type msrp;
  /**In SORT, the BY statement controls the sorting
    if multiple variables are listed, it's a nested sort
      --the second variable is ordered within distinct
          values of the first...**/
run;
/**The default behavior is to replace the existing data
  set with the sorted one. We aren't allowed to change
  this one though...**/

proc sort data=sashelp.cars out=work.CarsSorted;
  by type msrp;
run;
/**In the sorting on Type, SUV comes before Sedan,
   even though u comes after e...
    in ordering, uppercase comes before lowercase**/

proc contents data=carsSorted;
run;

proc sort data=sashelp.cars out=work.CarsSorted2;
  by type descending msrp;
    /**descending can precede any variable in
        the BY to change the sort order from ascending**/
run;
proc contents data=carsSorted2;
run;

proc sort data=sashelp.cars out=work.CarsSorted2;
  by descending type msrp;
    /**This is descending only on type...**/
run;

proc sort data=sashelp.cars out=work.CarsSorted3;
  by descending type descending msrp;
    /**This is descending on both...**/
run;

proc sort data=sashelp.cars out=work.CarsSorted4;
  by type make descending msrp;
run;

/**PRINT is for displaying data records, or portions of them**/
proc print data=sashelp.cars;
run;/**default is to make a table of all columns and rows, with an observation 
      counter as the first column**/

/**PRINT does not use labels unless you tell it to**/
proc print data=sashelp.cars label noobs;
run;/**NOOBS suppresses the obs column**/

proc print data=sashelp.cars label noobs;
  var make model msrp mpg_city horsepower type;
  /**VAR lets you choose variables and their order for display**/
run;

proc print data=sashelp.cars label noobs;
  by type;
  /**PRINT, and really all procedures, support a BY statement...
    but BY assumes the data has the grouping you have selected**/
  var make model msrp mpg_city horsepower;
run;

proc sort data=sashelp.cars out=work.CarsSorted;
  by type msrp;
run;
proc print data=CarsSorted label noobs;
  by type;
  var make model msrp mpg_city horsepower;
run;/**The grouping is split across tables in
      the output**/

proc print data=CarsSorted label noobs;
  by type;
  id type; /**matching the variable set in BY
            in an ID statement changes output
            structure
            
            instead of a header for each table,
            by values are added as the leading column(s)**/
  var make model msrp mpg_city horsepower;
run;


proc sort data=sashelp.cars out=work.CarsSorted4;
  by type make descending msrp;
run;

proc print data=CarsSorted4 label noobs;
  by type;
    /**it's sorted by more than Type, but this is
        fine because the primary group/sort in the data
        is on Type**/
  id type; 
  var make model msrp mpg_city horsepower;
run;

proc print data=CarsSorted4 label noobs;
  by make;
    /**It is sorted on Type, then Make within
        Type, so the primary grouping is not on Make**/
  id make;
  var make model msrp mpg_city horsepower;
run;

proc print data=CarsSorted4 label noobs;
  by type make;
    /**This is good...**/
  id type make;
  var model msrp mpg_city horsepower;
run;

proc sort data=sashelp.cars out=work.CarsSorted5;
  by type descending make descending msrp;
run;

proc print data=CarsSorted5 label noobs;
  by type make;
    /**This is not good...**/
  id type make;
  var model msrp mpg_city horsepower;
run;

proc print data=CarsSorted5 label noobs;
  by type descending make;
    /**This is...**/
  id type make;
  var model msrp mpg_city horsepower;
run;
/**For a BY statement in a procedure, you have
  to match the hierarchy and order on the
  variables you choose**/

proc print data=CarsSorted4 label noobs;
  by type;
  id type;
  var make model msrp mpg_city horsepower;
  sum msrp;
run;
