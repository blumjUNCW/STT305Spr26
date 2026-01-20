/*we can assign a library in a program with the LIBNAME statement...*/
/* Form:
    libname libref 'path';
    libname is the keyword (exact)
    libref--library reference name (your choice)
      rules: max 8 characters, letters, underscores, digits are permitted
      suggestions: if it's a repo, make it the same name if legal
                    if you're doing a SAS course, get their name and use it
    path is the path to the folder..
*/
/**For my SASData repo, I'll use (and you can too)...*/

libname SASData '~/SASData';
/* in Linux, ~ is a shortcut reference to your home directory*/
proc contents data=sasdata.cdi;
run;    

libname pg1 '~/Courses/PG1V2/data';/**assign library for data
                    in PG1V2 data folder**/  