/**MEANS does standard quantitative statistics**/
proc means data=sashelp.heart;
run;/**with no other statements or options, you get:
      sample size (N), mean, standard deviation, minimum, and maximum
      for all numeric variables in the data set 
  **/

proc means data=sashelp.heart;
  var systolic diastolic; /**var lets you choose analysis variables
                              must be numeric**/
run;

proc means data=sashelp.heart;
  class chol_status; /**CLASS groups the data on unique values of the chosen variable(s)
                       this does not require sorting, grouping is done during execution**/
  var systolic diastolic; 
run;

proc means data=sashelp.heart;
  class chol_status weight_status;
    /**for more than one variable, each unique combination
          is a category**/
  var systolic diastolic; 
run;

proc means data=sashelp.heart;
  class weight_status chol_status;
    /**for more than one variable, each unique combination
          is a category**/
  var systolic diastolic; 
run;

proc means data=sashelp.heart;
  class weight;
    /**what you use here should be categorical..**/
  var systolic diastolic; 
run;

/**You can choose your statistics in the PROC MEANS statement**/
proc means data=sashelp.heart mean min median max;
      /**stat keywords define the displayed set of statistics
          and their order**/
  class chol_status; 
  var systolic diastolic; 
run;

proc means data=sashelp.heart nonobs n min q1 median q3 max maxdec=1;
  class chol_status; 
  var systolic diastolic; 
run;

proc means data=sashelp.heart nonobs lclm mean uclm alpha=0.01;
  class chol_status; 
  var systolic diastolic; 
run;

proc means data=sashelp.heart nonobs n min q1 median q3 max maxdec=1;
  class chol_status; 
  var systolic diastolic; 
  ods output summary=fiveNumber;
run;

proc means data=sashelp.heart;
  class weight_status chol_status;
    /**If you have more than one class variable, you
      can control the stratifications you see with WAYS**/
  ways 1;
    /**if you have k variables in CLASS, WAYS can include
        any set of digits 0 1 2 ... k**/
  var systolic diastolic; 
run;/**ways 1; is each one individually**/

proc means data=sashelp.heart;
  class weight_status chol_status bp_status;
  ways 1 2;
  var AgeAtStart; 
run;

proc means data=sashelp.heart;
  class weight_status chol_status bp_status;
  ways 0 1;
  var AgeAtStart; 
run;

proc means data=sashelp.heart;
  class weight_status chol_status bp_status;
  ways 0 1 2 3;
  var AgeAtStart; 
run;
