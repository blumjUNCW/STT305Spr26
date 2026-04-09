libname SASData '~/SASData';

proc corr data=sasdata.np_2017camping;
    var _numeric_;
run;

proc corr data=sasdata.np_2016camping;
    var _numeric_;
run;/*not great..*/

proc sgplot data=sasdata.np_2016camping;
  hbar campType / response=campcount;
run;

/*2017?*/

proc transpose data=sasdata.np_2017camping out=camp2017;
  by parkName;
  var _numeric_;
run;

proc transpose data=sasdata.np_2016camping out=camp2016;
  by parkName;
  var campcount;
  id camptype;
run;