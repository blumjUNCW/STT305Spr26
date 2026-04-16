libname IPEDS305 '~/IPEDS305';/*Use data from here...*/
options fmtsearch=(IPEDS305);/*...and associated formats*/

data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);
  by unitID;

  if in18 then year=2018;
    else if in23 then year=2023;

  Graduates = grtotlt;
  Incoming = lag(grtotlt);
  GrRate = Graduates/Incoming;

  *if last.unitID and not first.unitID then output;
  /*almost everything carries over from the separate construction
    of graduation rates, but not this...
    use the group variable to condition instead...*/
  *keep unitID year Graduates Incoming GrRate;
  format GrRate percentn8.2;
  label GrRate = 'Graduation Rate, All Students'
        Graduates = 'Number of Graduates, 150% of Time'
        Incoming = 'Number in Incoming Cohort'
        ;

run;


data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);
  by unitID;

  if in18 then year=2018;
    else if in23 then year=2023;

  Graduates = grtotlt;
  Incoming = lag(grtotlt);
  GrRate = Graduates/Incoming;

  if find(group,'Completers') then output;
  /*No good, Completers is in the format definition,
    the actual value is internally a number*/
  
  keep unitID year Graduates Incoming GrRate;
  format GrRate percentn8.2;
  label GrRate = 'Graduation Rate, All Students'
        Graduates = 'Number of Graduates, 150% of Time'
        Incoming = 'Number in Incoming Cohort'
        ;

run;

data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);
  by unitID;

  if in18 then year=2018;
    else if in23 then year=2023;

  Graduates = grtotlt;
  Incoming = lag(grtotlt);
  GrRate = Graduates/Incoming;

  if group eq 13 then output;/*find the internal value and use it...*/
  
  keep unitID year Graduates Incoming GrRate;
  format GrRate percentn8.2;
  label GrRate = 'Graduation Rate, All Students'
        Graduates = 'Number of Graduates, 150% of Time'
        Incoming = 'Number in Incoming Cohort'
        ;

run;

data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);
  by unitID;

  if in18 then year=2018;
    else if in23 then year=2023;

  Graduates = grtotlt;
  Incoming = lag(grtotlt);
  GrRate = Graduates/Incoming;

  if find(put(group,chrtstat.),'Completers') then output;
  /*Apply the format and then look at its value*/
  
  keep unitID year Graduates Incoming GrRate;
  format GrRate percentn8.2;
  label GrRate = 'Graduation Rate, All Students'
        Graduates = 'Number of Graduates, 150% of Time'
        Incoming = 'Number in Incoming Cohort'
        ;

run;