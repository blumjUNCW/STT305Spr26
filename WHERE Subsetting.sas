/*All procedures that process data permit WHERE statements
  (and so does the data step)*/

proc means data=sashelp.heart;
 where bp_status = 'Normal';
  /**where only reads records that are true
      for the condition given*/
 var systolic diastolic;
run;

proc means data=sashelp.heart;
 where bp_status eq 'Normal';
  /**symbols or mnuemonic character expressions
      are allowed*/
 var systolic diastolic;
run;

proc means data=sashelp.heart;
 where bp_status eq 'normal';
  /**For character data values, casing matters*/
 var systolic diastolic;
run;

proc print data=sashelp.stocks;
  where high gt 100;
run;

proc print data=sashelp.stocks;
  where high-low gt 10;
    /**mathematical expressions are permitted*/
run;

proc freq data=sashelp.heart;
  table bp_status*weight_status;
  where weight_status ne "Normal" and bp_status ne "Normal";
run;

proc means data=sashelp.cars;
  where type in ('Truck' 'SUV');
    /** Where variable in (list of values)
        list can be separated by spaces or commas*/
  class type;
  var mpg_city mpg_highway;
run;

proc means data=sashelp.cars;
  where type not in ('Truck' 'SUV');
    /**Not is negation*/
  class type;
  var mpg_city mpg_highway;
run;

proc print data=sashelp.stocks;
  where high between 90 and 110;
    /**same as where high ge 90 and high le 110 */
    /** WHERE variable BETWEEN low AND high;
        establishes a range (includes the endpoints)
        */
run;

proc print data=sashelp.stocks;
  where high ge 90 and le 110;
  /**If I use AND/OR, each comparison must
    include a variable or expression*/
run;

proc print data=sashelp.stocks;
  where high eq 90 or 91;
  /**When SAS processes logical statements, it returns a 0 for false, 1 for true
    If you give SAS a number, it interprets 0 and missing as false,
        and EVERYTHING ELSE as TRUE
  For character, blank/missing is false, any other character set is true*/
run;

proc print data=sashelp.cars;
  where origin eq 'asia' or 'europe';
  /*For character, blank/missing is false, any other character set is true*/
run;

proc print data=sashelp.cars;
  where model contains '4';
    /** WHERE variable CONTAINS 'string';
        looks for the string anywhere in the variable value*/
run;

proc print data=sashelp.cars;
  where model contains '4dr';
    /** WHERE variable CONTAINS 'string';
        looks for the string anywhere in the variable value*/
run;

proc print data=sashelp.cars;
  where model not contains '4dr';
    /** WHERE variable CONTAINS 'string';
        looks for the string anywhere in the variable value*/
run;


proc freq data=sashelp.stocks;
  where stock contains 'M';
  table stock;
run;

proc freq data=sashelp.stocks;
  where stock like '%M%';
    /**For LIKE, % is a wildcard for any number of characters of
        any value (including no characters)*/
  table stock;
run;

proc freq data=sashelp.stocks;
  where stock like 'M%';
    /**For LIKE, % is a wildcard for any number of characters of
        any value (including no characters)*/
  table stock;
run;
proc freq data=sashelp.stocks;
  where stock like '%M';
    /**For LIKE, % is a wildcard for any number of characters of
        any value (including no characters)*/
  table stock;
run;
proc freq data=sashelp.stocks;
  where stock like '_M%';
    /**For LIKE, _ is a wildcard for
      one place with any character value
        (but NOT none)*/
  table stock;
run;

proc freq data=sashelp.stocks;
  where stock like '__M%';
    /**For LIKE, _ is a wildcard for
      one place with any character value
        (but NOT none)*/
  table stock;
run;

