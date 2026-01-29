***********************************************************;
*  Importing a Comma-Delimited (CSV) File                 *;
***********************************************************;
*  Syntax and Example                                     *;
*                                                         *;
*    PROC IMPORT DATAFILE="path/filename.csv" DBMS=CSV    *;
*           OUT=output-table <REPLACE>;             *;
*        <GUESSINGROWS=n|MAX>;                            *;
*    RUN;                                                 *;
***********************************************************;

proc import datafile="~/Courses/PG1V2/data/class_birthdate.csv" 
              /**datafile is the file to import..**/
            dbms=csv 
              /**DBMS= choose a keyword corresponding to the file type**/
            out=work.class_birthdate_import
              /**out= sas table to create, library.dataset**/
            replace
              /**replace: overwrite the output table if present already**/;
run;

proc import datafile="~/Courses/PG1V2/data/class_birthdate.csv" 
            dbms=csv 
            out=class_birthdate_import
              /**if you reference a SAS table (input or output) and omit
                  the library (and the dot .), it assumes you mean
                    the Work library**/
            replace;
run;


*Complete the PROC IMPORT step to bring in storm_damage.csv;
proc import datafile='~/Courses/PG1V2/data/storm_damage.csv'
            dbms=csv
            out=StormDamage
            replace;
  guessingrows=ALL;
run;

*Complete the PROC CONTENTS step;
proc contents data=StormDamage;
run;

proc means data=StormDamage;
  var cost;
run;

proc import datafile='~/Courses/PG1V2/data/storm_damage.tab'
            dbms=tab
            out=StormDamageTab
            replace;
  guessingrows=ALL;
run;