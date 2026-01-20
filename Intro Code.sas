Title 'Heart Metadata';
proc contents data=sashelp.heart;
  /*comment--ignored during execution*/
  /* data set referece is of the form: library.datatable */
run;

Title 'Stocks Metadata';
proc contents data=sashelp.Stocks varnum;
run;

Title 'Default Statistics on Systolic and Diastolic BP';
Footnote 'Stratified by Cholesterol Status';
proc means data=sashelp.heart;
  class chol_status; /*stratifying variable(s)*/
  var systolic diastolic;
    /*analyis variables, must be numeric (quantitative)*/
run;

title;
footnote;
proc means data=sashelp.heart;
run;/*default behavior (no statements) is to summarize all numeric variables*/

Title 'Five Number Summary on Systolic and Diastolic BP';
proc means  min q1 Median q3 max DATA=sashelp.heart;
  class chol_status;
  var systolic diastolic;
run;

Title 'Vehicle Origin';
Title2 'Frequencies & Percents';
Footnote "Generated on &sysdate9";
proc freq data=sashelp.cars;
  table origin;
run;

Title "Cholesterol, Blood Pressure Status Cross-Tabulation";
Footnote;
proc freq data=sashelp.heart;
  table chol_status*bp_status / chisq;
run;

Title;
proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_city stat=mean;
  where type ne 'Hybrid';
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_city stat=mean
                group=type groupdisplay=cluster;
  where type ne 'Hybrid';
run;

proc sgplot data=sashelp.cars;
  reg x=weight y=Horsepower / group=origin degree=2;
  keylegend / position=bottomright location=inside;
  where type ne 'Hybrid';
run;

proc sgplot data=sashelp.cars;
  scatter x=weight y=Horsepower / colorresponse=mpg_highway
        colormodel=(cxFF0000 yellow lightreddishgreen) markerattrs=(symbol=circlefilled);
  where type ne 'Hybrid';
run;

proc contents data=sashelp.stocks;
run;

proc print data=sashelp.stocks(obs=25);
  var Stock Date Volume Low High;
run;

proc print data=sashelp.stocks(obs=25);
  var Stock Date Volume Low High;
  format date weekdate.;
  /*formats are choose-able, SAS provides many
      formats, and we can make our own*/
run;

proc print data=sashelp.stocks(obs=25);
  var Stock Date Volume Low High;
  format date best12.;
  /*Dates are actually stored as the number of
   days from January 1, 1960*/
run;

proc contents data=sashelp.cars varnum;
run;

proc report data=sashelp.cars(obs=25);
run;

proc report data=sashelp.cars(obs=25);
  label mpg_city='City MPG' mpg_highway='Highway MPG'
        MSRP='Suggested Retail Price';
  /* variable labels are also change-able */
run;


