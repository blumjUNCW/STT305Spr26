/**Indentation and line breaks do not matter...**/
proc sgplot data=sashelp.cars;
  scatter x=weight y=Horsepower / colorresponse=mpg_highway
        colormodel=(cxFF0000 yellow lightreddishgreen) markerattrs=(symbol=circlefilled);
  where type ne 'Hybrid';
run;

proc sgplot data=sashelp.cars;
scatter x=weight y=Horsepower / colorresponse=mpg_highway colormodel=(cxFF0000 yellow lightreddishgreen) markerattrs=(symbol=circlefilled);
where type ne 'Hybrid';
run;


proc sgplot data=sashelp.cars;scatter x=weight y=Horsepower / colorresponse=mpg_highway colormodel=(cxFF0000 yellow lightreddishgreen) markerattrs=(symbol=circlefilled);where type ne 'Hybrid';run;

proc sgplot data=sashelp.cars;
  scatter x=weight y=Horsepower
           / 
           colorresponse=mpg_highway
           colormodel=(cxFF0000 yellow lightreddishgreen) 
           markerattrs=(symbol=circlefilled);
  where type ne 'Hybrid';
run;

/**Casing of language elements does not matter...**/
proc SGPlot data=sashelp.cars;
  scatter X=weight Y=Horsepower / colorresponse=mpg_highway
        colormodel=(cxFF0000 Yellow lightreddishgreen) markerattrs=(symbol=circlefilled);
  where type ne 'Hybrid';
run;

/**Casing of literal text values DOES MATTER**/
proc sgplot data=sashelp.cars;
  scatter x=weight y=Horsepower / colorresponse=mpg_highway
        colormodel=(cxFF0000 yellow lightreddishgreen) markerattrs=(symbol=circlefilled);
  where type eq 'sedan';
run;

proc print data=sashelp.cars;
  where type eq 'sedan';
  /* Sedan and sedan are DIFFERENT text values */
run;

/**We are in a Linux/Unix operating system, so paths are also case sensitive...**/
libname SASData '~/SASData';
libname SASData clear;  
libname SASData '~/sasdata';
      /**the file path needs to have matching casing**/
libname SASData clear;  
libname sasdata '~/SASData';

/**Spacing matters between keywords and some other elements of the language, but
  not all..**/
procsgplot data=sashelp.cars;
  scatter x=weight y=Horsepower / colorresponse=mpg_highway
        colormodel=(cxFF0000 yellow lightreddishgreen) markerattrs=(symbol=circlefilled);
  where type ne 'Hybrid';
run;

proc sgplot data = sashelp.cars;
  scatter x=weight y =Horsepower /colorresponse=mpg_highway
        colormodel= ( cxFF0000 yellow lightreddishgreen ) markerattrs=(symbol=circlefilled);
  where type ne 'Hybrid';
run;/**spaces around operators like = and / do not matter**/
