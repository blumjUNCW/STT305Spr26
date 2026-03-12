libname SASData '~/SASData';

proc sort data=sashelp.cars out=carsOriginal nodupkey dupout=duplicates;
  /*nodupkey -> remove duplicates on the "key"
      key: set of variables specified in the BY statement
      dupout= lets you specify a data set to store the duplicates*/
  by make model drivetrain;
run;

proc sort data=SASData.cars out=carsOther nodupkey dupout=duplicates;
  by make model drivetrain;
run;

proc compare base=carsOriginal compare=carsOther
        outall outnoequal out=comparison;
  /**compares common variables row-by-row*/
run;

proc freq data=SASDATA.cars;
  table make;
run;
proc freq data=SASHelp.cars;
  table make;
run;

data CarsUpdate1;
  set SASDATA.cars;
  /**Fix Casing on Make*/
  make = propcase(make);
  /**convert all make values to proper case*/
run;

proc sort data=CarsUpdate1;
  by make model drivetrain;
run;

data CarsOriginal;
  set CarsOriginal;
  model = left(model);
    /**left-justify the model in the original data */
run;

proc compare base=carsOriginal compare=CarsUpdate1
        outall outnoequal out=comparison;
  /**Is Make OK now?*/
run;
proc compare base=carsOriginal compare=CarsUpdate1
        outall outnoequal out=comparison;
  var make;
run;

proc freq data=sashelp.cars;
  table make;
  where anylower(make) eq 0;
run;/**These are the ones that are all uppercase
      fix that...*/

data CarsUpdate2;
  set SASDATA.cars;
  /**casing needs to be done conditionally...*/
  if upcase(make) in ('BMW' 'GMC' 'MINI') then make = upcase(make);
    /*^^check uppercase version....if true, force the casing ^^^*/
    else make = propcase(make);
run;

proc freq data=CarsUpdate2;
  table make;
run;/**inconsistent representation of Mercedes... */

data CarsUpdate3;
  set SASDATA.cars;

  if upcase(make) in ('BMW' 'GMC' 'MINI') then make = upcase(make);
    else make = propcase(make);

  if find(make,'Mercedes') ne 0
      /*find(variable,'What to Find') -> returns position,
            0 if string is not found*/
      then make='Mercedes-Benz';
run;

proc freq data=CarsUpdate3;
  table make;
run;


proc sort data=CarsUpdate3;
  by make model drivetrain;
run;
proc compare base=carsOriginal compare=CarsUpdate3
        outall outnoequal out=comparison;
  var make model;
run;/*door DR vs dr is a problem, supposed to be dr...*/

data CarsUpdate4;
  set SASDATA.cars;

  if upcase(make) in ('BMW' 'GMC' 'MINI') then make = upcase(make);
    else make = propcase(make);

  if find(make,'Mercedes') ne 0
      then make='Mercedes-Benz';
  
  model = tranwrd(model,'4DR','4dr');
          /**replace this^^^   ^^^with that*/
run;

proc sort data=CarsUpdate4;
  by make model drivetrain;
run;
proc compare base=carsOriginal compare=CarsUpdate4
        outall outnoequal out=comparison;
  var make model drivetrain;
run;/*These are now good...**/

/**...what else is wrong?*/
proc compare base=carsOriginal compare=CarsUpdate4
        outall outnoequal out=comparison;
run;

data CarsUpdate5;
  set SASDATA.cars;

  if upcase(make) in ('BMW' 'GMC' 'MINI') then make = upcase(make);
    else make = propcase(make);

  if find(make,'Mercedes') ne 0
      then make='Mercedes-Benz';
  
  model = tranwrd(model,'4DR','4dr');

  if type eq 'Sport Ut' then type = 'SUV';
run;

proc sort data=CarsUpdate5;
  by make model drivetrain;
run;
proc compare base=carsOriginal compare=CarsUpdate5
        outall outnoequal out=comparison;
run;/**non-US cars have metric units for weight, wheelbase, and
      length...fix that*/

data CarsUpdate6;
  set SASDATA.cars;

  if upcase(make) in ('BMW' 'GMC' 'MINI') then make = upcase(make);
    else make = propcase(make);

  if find(make,'Mercedes') ne 0
      then make='Mercedes-Benz';
  
  model = tranwrd(model,'4DR','4dr');

  if type eq 'Sport Ut' then type = 'SUV';

  if origin ne 'USA' then do;/**any then can be followed by a DO-END block
                              all statements between are evaluated when true*/
    weight = weight*2.2;
    wheelbase = wheelbase/2.54;
    length = length/2.54;
  end;
run;    
proc sort data=CarsUpdate6;
  by make model drivetrain;
run;
proc compare base=carsOriginal compare=CarsUpdate6
        outall outnoequal out=comparison;
run;/**exact comparisons by default... */

proc compare base=carsOriginal compare=CarsUpdate6
        outall outnoequal out=comparison
        method=percent criterion=0.1;
run;