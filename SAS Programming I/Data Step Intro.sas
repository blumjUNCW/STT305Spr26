/*************************************
Introduction to the DATA step
1/22/2026
*************************************/

data work.myCars work.HighMPG;/**data step can create data sets...**/
  set sashelp.cars;/**from existing table(s), SET chooses a table**/

  mpgCombo = 0.6*mpg_city + 0.4*mpg_highway;
    /**assignment statements: variable = expression; **/

  if type = 'Truck' or type = 'SUV' then category = 'Truck/SUV';
    else category = 'Car';/**conditional logic/branching is done with IF-THEN-ELSE**/

  name=catx(' ',make,model);

  if mpgCombo ge 25 then output work.HighMPG;
    else output work.myCars;
  
run;
