libname IPEDS305 '~/IPEDS305';

proc print data=ipeds305.gr2018(obs=20);
run;

proc contents data=ipeds305.gr2018;
run;

proc contents data=ipeds305.hd2018;
run;
/*several of these variables have custom formats,
  provided by IPEDS, and they're stored in
  formats.sas7bcat. To use them, do this...**/

options fmtsearch=(IPEDS305);
/*This tells which libraries to search for catalogs name "formats"*/
proc print data=ipeds305.hd2018(obs=20);
  format control 1.;
run;

/*Typically I would start with:*/
libname IPEDS305 '~/IPEDS305';/*Use data from here...*/
options fmtsearch=(IPEDS305);/*...and associated formats*/

/*Want to chart:
  graduation rate (info needed to compute is in GR2018 and GR2023)
    across
      control (in HD2018 and HD2023)
      year (consequence of assembling the data)*/

/*Compute the graduation rates..
  ratio of grtotl -> completers/cohort 
  
  need to consider two rows of data per institution*/

data grRate23;
    set ipeds305.gr2023;

    GrRate23 = grtotlt/lag(grtotlt);
    /*lag (or lag1) is value from previous record
      but I only want some of these*/
run;

data grRate23;
    set ipeds305.gr2023;
    by unitID;/*it is sorted by UnitID
                  which means we can get 
                  first. and last. for it*/

    GrRate23 = grtotlt/lag(grtotlt);
    if last.unitID then output;
    /*the correct computation is on the last 
      (second) record for any college (UnitID)*/
run;

ods select none;
/*let's use FREQ as a diagnostic tool..*/
ods trace on;
proc freq data=ipeds305.gr2023;
  table unitID;
  ods output oneWayFreqs=Counts;
  /*ods output tableName=DataSet;
    converts an output table into data
    you can get table names from documentation or
      running ODS TRACE ON;
  */
run;

/*the data step above assumes, beyond the sorting,
that each institution has both rows, and that isn't %inc
true*/

/*One way around this...*/
data grRate23;
    set ipeds305.gr2023;
    by unitID;/*it is sorted by UnitID
                  which means we can get 
                  first. and last. for it*/

    GrRate23 = grtotlt/lag(grtotlt);
    if last.unitID and not first.unitID then output;
    /* ^^last row, ensuring ^^^ there are two */
run;

/*Let's make a little better version of this,
  bringing along some information we may want
  and removing some we don't*/
data grRate23;
    set ipeds305.gr2023;
    by unitID;

    Graduates = grtotlt;
    Incoming = lag(grtotlt);

    GrRate = Graduates/Incoming;
    if last.unitID and not first.unitID then output;
    keep unitID Graduates Incoming GrRate;
    format GrRate percentn8.2;
    label GrRate = 'Graduation Rate, All Students'
          Graduates = 'Number of Graduates, 150% of Time'
          Incoming = 'Number in Incoming Cohort'
          ;
run;

/*I'd do basically the same thing for 2018...*/
data grRate18;
    set ipeds305.gr2018;
    by unitID;

    Graduates = grtotlt;
    Incoming = lag(grtotlt);

    GrRate = Graduates/Incoming;
    if last.unitID and not first.unitID then output;
    keep unitID Graduates Incoming GrRate;
    format GrRate percentn8.2;
    label GrRate = 'Graduation Rate, All Students'
          Graduates = 'Number of Graduates, 150% of Time'
          Incoming = 'Number in Incoming Cohort'
          ;
run;

data GrRateAll;
  set grRate18(in=in18) grRate23(in=in23);

  if in18 then year=2018;
    else if in23 then year=2023;
run;/*put them together with a year variable*/

/**Could I have done the calculations and assembly in one DATA step?
    Yes, try it...*/

ods select all;
proc sgplot data=GrRateAll;
  hbar year / response=GrRate stat=mean;
run;

/*get the information on control in from HD data sets...*/
data HDAll;
  set ipeds305.HD2018(in=in18 rename=(c18basic=carnegieBasic))
      ipeds305.HD2023(rename=(c21basic=carnegieBasic));
  
  if in18 then year = 2018;
    else year = 2023;

run;

proc contents data=ipeds305.HD2018;
  ods select variables;
run;

proc contents data=ipeds305.HD2023;
  ods select variables;
run;

/*put the data together (merge)*/

proc sort data=GrRateAll;
  by unitID year;
run;/**doesn't really matter how I sort these two
      variables for matching...*/

proc sort data=HDAll;
  by unitID year;
run;/**...just do it the same way for both*/

data use;
  merge GrRateAll(in=inGrads) HDAll;
  by unitID year;

  if inGrads; /*subsetting IF--if true, process the rest of the data step 
                iteration; false, delete the PDV and return to the top
                  to read the next record*/
run;

/*Should be able to make the charts...*/
proc sgplot data=use;
  hbar control / response=GrRate stat=mean 
                group=year groupdisplay=cluster;
run;

/**style this one up, and try the second one...*/
