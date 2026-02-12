proc means data=sashelp.heart;
  class smoking_status;
  var systolic diastolic;
run;  

/**One of the many ODS commands we will use is:*/
ods noproctitle;
proc means data=sashelp.heart;
  class smoking_status;
  var systolic diastolic;
run;  

/**You can add your own titles and footnotes...you get up to 10 lines
  for each*/
title 'Default Statistics for Systolic and Diastolic BP';
title2 'Stratified on Smoking Status';
footnote 'Generated on 2/12/2026';
/**All should be active before your PROC runs*/
proc means data=sashelp.heart;
  class smoking_status;
  var systolic diastolic;
run;

title2 'Stratified on Cholesterol Status';
  /**This replaces title2 (and technically cancels
    titles3-10) but does nothing to title1 */
proc means data=sashelp.heart;
  class chol_status;
  var systolic diastolic;
run;

title;
footnote;/**A null TITLE or FOOTNOTE cancels
          all active titles/footnotes*/
proc freq data=sashelp.heart;
  table chol_status;
run;