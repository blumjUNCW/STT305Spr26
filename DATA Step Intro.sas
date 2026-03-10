/**the DATA STEP is one of the primary data construction/manipulation
tools we have available in SAS*/

data work.cars;/*DATA statement names data set(s) to be created--library.dataset*/
  set sashelp.cars; /*SET statement names the data table(s) to read*/
  /**reads this data set one record at a time and loops through
      until the end of the file
    outputs each record to the target data set on each iteration of the 
      implicit loop*/
run;

data work.cars;
  set sashelp.cars; 
  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  /**variable = expression; creates new variables
      expressions can involve arithmetic operators, functions,
        and other stuff..*/
  /*arith expressions: + - * / and ** is exponentiation*/
run;

data work.cars;
  set sashelp.cars; 
  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;
  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
  /**can assign formats and labels during data step processing--
    these are the default formats, or permanent formats in
      the documentation*/
run;

proc print data=cars noobs label;
run;

proc print data=cars noobs label;
  label mpgCombo='EPA Combined';
  format profit comma8.;
run;


data work.AsianCars;
  set sashelp.cars; 
  where origin eq 'Asia';
  /**where processing is supported*/
  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;
  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
run;

data work.AsianCars;
  set sashelp.cars; 
  where origin eq 'Asia';

  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;

  drop origin; /**keep/drop statements are available to choose 
                columns for output*/
  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
run;

/**keep/drop are also data set options... */
data work.AsianCars(drop=origin);
  set sashelp.cars; 
  where origin eq 'Asia';

  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;

  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
run;

data work.AsianCars;
  set sashelp.cars(drop=origin); 
    /**don't want to apply it to the input data in this case...*/
  where origin eq 'Asia';

  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;

  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
run;


data work.AsianCars;
  set sashelp.cars; 

  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;

  where mpgCombo gt 20;/**where processing only applies to variables
          in the input data sets, if you want to condition on
          anything you create, you have to use some form of IF-THEN*/

  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
run;


data work.cars;
  set sashelp.cars; 

  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
  Profit = MSRP - Invoice;
  /**there are many functions available, and several are for character
      values...*/
  
  MakeModel1 = cat(make,model);
    /*cat puts items together with leading and trailing spaces
      left in place*/
  MakeModel2 = catt(make,model);/*the extra t is for TRIM-trailing blanks*/
  MakeModel3 = cats(make,model);/*s is STRIP-leading and trailing blanks*/
  MakeModel4 = catx(' ',make,model);
      /**catx removes all leading and trailing blanks,
          puts the delimiter (first argument) between elements*/

  format profit dollar10.;
  label mpgCombo='EPA Combined MPG';
run;


data stocks;
  set sashelp.stocks;

  year = year(date); /*several functions are available for extracting
                      info from dates/times**/
  day = day(date);
  month = month(date);
run;

data stocks;
  set sashelp.stocks;

  year = year(date); /*several functions are available for extracting
                      info from dates/times**/
  day = day(date);
  month = put(date,monname.);
  /*put converts numeric to character using the specified
    format to control the conversion*/
run;

proc print data=sashelp.stocks(obs=10);
  format date monname.;
run;




