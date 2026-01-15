Title 'Heart Metadata';
proc contents data=sashelp.heart;
run;

Title 'Default Statistics on Systolic and Diastolic BP';
Footnote 'Stratified by Cholesterol Status';
proc means data=sashelp.heart;
  class chol_status;
  var systolic diastolic;
run;

Title 'Five Number Summary on Systolic and Diastolic BP';
proc means data=sashelp.heart min q1 median q3 max;
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
  reg x=weight y=Horsepower / group=origin degree=1;
  where type ne 'Hybrid';
  keylegend / position=bottomright location=inside;
run;

proc sgplot data=sashelp.cars;
  scatter x=weight y=Horsepower / colorresponse=mpg_highway
        colormodel=(red yellow green) markerattrs=(symbol=circlefilled);
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
run;

proc report data=sashelp.cars(obs=25);
run;

proc report data=sashelp.cars(obs=25);
  label mpg_city='City MPG' mpg_highway='Highway MPG'
        MSRP='Suggested Retail Price';
run;


