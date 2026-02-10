proc freq data=sashelp.cars;
run;/**Each variable gets a frequency and percentage summary,
  categories are each distinct value of the variable*/

/*You will want to pick things that are categorical,
    or make them categorical**/

proc freq data=sashelp.heart;
  table chol_status weight_status;
  /**we use TABLE to select variables,
      individual variables correspond to a one-way frequency table**/
run;

proc freq data=sashelp.cars;
  table origin / nocum;
    /*Options in TABLE come after the / character
        NOCUM turns off the cumulative columns**/
run;

proc freq data=sashelp.cars order=freq;
  /**Frequency order is most frequent first*/
  table origin / nocum;
run;

proc sort data=sashelp.cars out=carsSort;
  by descending origin;
run;

proc freq data=carsSort order=data;
  /**Data order is whatever order the first
      instances appear in the data= data set*/
  table origin / nocum;
run;

proc freq data=sashelp.heart;
  table chol_status*weight_status;
  /*Table A*B; makes a two-way table or
      a cross-classification table
      with levels of A on the rows, B on the columns*/
run;

proc freq data=sashelp.heart;
  table chol_status*weight_status / nocol nopercent;
  /*There are several "No" options to remove any
    of the four numbers in the cells*/
run;

proc freq data=sashelp.heart;
  table chol_status*weight_status*bp_status / nocol nopercent;
  /* A*B*C 
    makes the B*C table for each value of A*/
run;


proc freq data=sashelp.heart;
  table chol_status*(weight_status bp_status)
        / nocol nopercent;
  /* A*(B C) 
    makes A*B and A*C tables */
run;