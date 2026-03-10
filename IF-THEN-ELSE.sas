data try;
  set sashelp.cars;
  /*in the data step we have two forms of conditional branching:
    IF-THE-ELSE

    SELECT block*/
  if type eq 'Truck' or type eq 'SUV' then truck='Yes';/*if this statement is
                                        true, new variable truck is assigned Yes*/
    else truck='No';/*immediately after any if statement, you can put an
                        else to control what happens when the if condition is false*/
run;

data try2;
  set sashelp.cars;
  if type eq 'Truck' or type eq 'SUV' then truck='Yes';
    /*no implicit action that happens for a false if condition,
        truck is missing(blank) for those in this case*/
run;

data try3;
  set sashelp.cars;
  if type in ('Truck' 'SUV') then truck='Yes';
    /* in (list) is supported for IF also */
    else truck='No';
run;

data try4;
  set sashelp.cars;
  if type not in ('Truck' 'SUV') then truck='No';
    /*truck is assigned the character attribute implicitly at this first 
      encounter...and it also sets the length here to 2*/
    else truck='Yes';
run;

data try5;
  set sashelp.cars;

  length truck $3; /**set length for truck to be 3 and set
                    type to character ($)*/
  if type not in ('Truck' 'SUV') then truck='No';
    else truck='Yes';
run;

data try6;
  set sashelp.cars;

  if type not in ('Truck' 'SUV') then truck='No';
    else truck='Yes';
  length truck $3; /**this needs to be done before any other encounter
                    of truck in the code*/
run;

data try7;
  length truck $3; /**this needs to be done before any other encounter
                    of truck in the code*/
  set sashelp.cars;

  if type not in ('Truck' 'SUV') then truck='No';
    else truck='Yes';
run;