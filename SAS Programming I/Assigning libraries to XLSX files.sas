libname storm xlsx '~/Courses/PG1V2/data/storm.xlsx';
          /** ^^^^ -- data is in an Excel spreadsheet, use that engine for access to it
                      no conversion or import is done, the engine communicates
                      directly with the file**/
        
proc contents data=storm._all_;
run;
    
/**Create a library called NP that connects to np_info.xlsx...**/
libname NP xlsx '~/Courses/PG1V2/data/np_info.xlsx';

options validvarname=any;
proc print data=np.parks(obs=10);
  var park name;/**this is two separate variable names in standard coding...**/
run;

proc print data=np.parks(obs=10);
  var 'park name'n;/**can always use 
                    'Name'n no matter what is contained in the name**/
run;

options validvarname=v7;
proc contents data=np.parks;
run;

libname np clear;