PROC IMPORT DATAFILE='~/Courses/PG1V2/data/class.xlsx'
            DBMS=XLSX OUT=WORK.BDates;
  GETNAMES=YES;
  SHEET="class_birthdate";
RUN;
/**the only real difference between importing text files
  and Excel stuff is the option to choose the worksheet

  First sheet is the default, but you can choose any
    other with SHEET = 'Sheet Name';

To get the whole workbook in this case, I'd have to write 
    4 import procs...**/

libname class xlsx '~/Courses/PG1V2/data/class.xlsx';
/**This is easier for structured stuff...**/

