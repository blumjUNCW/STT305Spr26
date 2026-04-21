libname IPEDS305 '~/IPEDS305';/*Use data from here...*/
options fmtsearch=(IPEDS305);/*...and associated formats*/

data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);

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

/**Let's add in the numbers and rates for men and women with
  the DATA step...*/

data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);

  if in18 then year=2018;
    else if in23 then year=2023;

  Graduates = grtotlt;
  GraduatesMen = grtotlm;
  GraduatesWomen = grtotlw;

  Incoming = lag(grtotlt);
  IncomingMen = lag(grtotlm);
  IncomingWomen = lag(grtotlw);

  GrRate = Graduates/Incoming;
  GrRateMen = GraduatesMen/IncomingMen;
  GrRateWomen = GraduatesWomen/IncomingWomen;

  /**this works, but it's lots of repitition that
    I'd like to avoid (or compact)*/
  if find(put(group,chrtstat.),'Completers') then output;
  /*Apply the format and then look at its value*/
  
  keep unitID year Graduates Incoming GrRate
                   GraduatesMen IncomingMen GrRateMen
                   GraduatesWomen IncomingWomen GrRateWomen;
  format GrRate: percentn8.2;
run;


data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);

  if in18 then year=2018;
    else if in23 then year=2023;

  array counts(3) grtotlm grtotlw  grtotlt;
  /**array is a temporary referencing of existing columns
    or columns to be created that allows for a single
    name with a numeric indexing
    
    index corresponds to the position in the list*/

  WhatisCounts1 = counts(1);
  WhatisCounts2 = counts(2);
  WhatisCounts3 = counts(3);

run;


data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);

  if in18 then year=2018;
    else if in23 then year=2023;

  array counts(3) grtotlt grtotlm grtotlw;
  array incoming(3) incomingTot incomingMen incomingWomen;
  array grads(3);
  array gradRate(3);
  /*these are array definitions that don't point to a
    set of columns
    
    if just the statement array var(k); is given,
    it makes (or looks for) var1 var2 ... vark
    but you can also specify variable names that don't currently exist
      and they will be created*/
run;


data GrRateAll;
  set ipeds305.gr2018(in=in18) ipeds305.gr2023(in=in23);

  if in18 then year=2018;
    else if in23 then year=2023;

  array counts(3) grtotlt grtotlm grtotlw;
  array incoming(3) incomingTot incomingMen incomingWomen;
  array grads(3) gradsTot gradsMen gradsWomen;
  array gradRate(3) gradRateTot gradRateMen gradRateWomen;

  do j = 1 to 3; /**indexed do loops are available -- do var = a to b by c; */
    grads(j) = counts(j);
    incoming(j) = lag(counts(j));
    gradRate(j) = grads(j)/incoming(j);
  end;
  
  if find(put(group,chrtstat.),'Completers') then output;
  
  keep unitID year incoming: grad:;
  format GradRate: percentn8.2;
  
run;

