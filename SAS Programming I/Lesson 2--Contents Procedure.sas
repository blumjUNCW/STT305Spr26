libname pg1 '~/Courses/PG1V2/data';

ods trace on; /**ODS is Output Delivery System
              trace tracks (in the log) the creation of all output objects--
                it's off by default, but we can set it to on**/
proc contents data=pg1.storm_summary varnum;
run;

proc contents data=pg1.storm_summary varnum;
  ods exclude EngineHost;
    /**I can use ODS SELECT or ODS EXCLUDE to choose specific tables**/
run;

proc contents data=pg1.storm_summary varnum;
  ods select position sortedBy;
    /**I can use ODS SELECT or ODS EXCLUDE to choose specific tables**/
run;

proc contents data=pg1.storm_summary varnum;
  ods exclude 'Engine/Host Information';
    /**You can use a label if it is quoted**/
run;
