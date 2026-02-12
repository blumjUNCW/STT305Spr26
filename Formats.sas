proc freq data=sashelp.stocks;
  where high gt 110;
  table date;
  /*not a great table, each date is its own category*/
run;

/*SAS provides formats to change the display of values 
 (and we can make our own), but categorization is also
 done with respect to the active format*/

proc freq data=sashelp.stocks;
  where high gt 110;
  table date;
  format date monname.;
  /*monname displays dates as month name only,
    so each category is a month name...**/
run;

proc freq data=sashelp.stocks;
  where high gt 110;
  table date;
  format date year.;
  /*This time, it's years**/
run;

proc freq data=sashelp.stocks order=formatted;
  where high gt 110;
  table date;
  format date qtr.;
  /*This time, it's quarters**/
run;

proc print data=sashelp.stocks;
    var low high;
    format low high dollar8.2;
run;

/**You can write your own formats with PROC FORMAT*/

/**Write a format for the Type variable in SASHelp.Cars that reformats
  it to 3 categories--Truck, Car, Hybrid*/

/**The VALUE statement defines a format--first element is the format name
      (without a .)*/
      /**Format naming rules:
          1. Up to 32 characters total
          2. Can contain letters, underscores, and digits
          3. If it's for character values it must start with $
              For numeric, must begin with a letter or underscore
          4. The last character cannot be a digit*/
      /**Remainder of the value statement is the set of formatting rules
          you want to apply (so it's a long statement I usually break over
          several lines
          
          Any rule is of the form value-range = label */
proc format;
    value $NewType
      'Truck'='Truck'
      'SUV' = 'Truck'
      'Sedan' = 'Car'
      'Wagon' = 'Car'
      'Sports' = 'Car'
      'Hybrid' = 'Hybrid'
      ;/**One long value statement ends here*/
run;

proc means data=sashelp.cars;
    class type;/**categories are formed based on distinct formatted
                values*/
    format type $NewType.;/**Any time I use a format, there's a dot in the name*/
    var mpg:;
      /**In variable names: text: is any variable that starts with text
          : is a wildcard for any character set but can only be at the end*/
run;

proc format;
    value $NewTypeB
      'Truck','SUV' = 'Truck'
      'Sedan','Wagon','Sports' = 'Car'
      'Hybrid' = 'Hybrid'
      ;/**On the left side of any rule,
          you can give a comma-separated list of values*/
run;
proc means data=sashelp.cars;
    class type;
    format type $NewTypeB.;
    var mpg:;
run;


proc format;
    value $NewTypeC
      'Truck','SUV' = 'Truck'
      'Sedan','Wagon','Sports' = 'Car'
      ;/**Anything left out of the format definition
        retains it's internal formatting*/
run;
proc means data=sashelp.cars;
    class type;
    format type $NewTypeC6.;
    /*Default width of formats is based on the longest label...
        but you can change it when calling the format*/
    var mpg:;
run;


proc format;
    value $NewTypeD
      'Truck','SUV' = 'Truck'
      'Hybrid' = 'Hybrid'
      other = 'Car'
      ;/**other (unquoted) on the left is then a rule
        for every other value you didn't make a rule for*/
run;
proc means data=sashelp.cars;
    class type;
    format type $NewTypeD.;
    var mpg:;
run;

proc format;
    value $NewChol
      'Desirable' = '1. Desirable'
      'Borderline' = '2. Borderline'
      'High' = '3. High'
      ;
    value $NewWeight
      'Underweight' = 'A. Under'
      'Normal' = 'B. Normal'
      'Overweight' = 'C. Over'
      ;
run;

proc freq data=sashelp.heart order=formatted;
    table Chol_status Weight_Status;
    format Chol_status $NewChol.
           Weight_Status $NewWeight.;
run;

proc means data=sashelp.heart q1 median q3;
  var systolic diastolic;
run;
/**Create categories corresponding to approximately
  the bottom, 2nd, 3rd, and top quartile*/

proc format;
    value sysQuart
      0 - 120 = '1st Quartile'
      120-<132 = '2nd Quartile'
      132-<148 = '3rd Quartile'
      other = '4th Quartile'
      ;
run;
/**A value range on the left side is of the form
       A-B or A<-B, A-<B, A<-<B 
       A-B is inclusive of A & B
        the < removes the corresponding endpoint*/
proc freq data=sashelp.heart order=formatted;
    table Chol_status*systolic;
    format Chol_status $NewChol. 
            systolic sysQuart.;
run;

proc format;
    value sysQuartB
      low - 120 = '1st Quartile'
      120-<132 = '2nd Quartile'
      132-<148 = '3rd Quartile'
      148 - high = '4th Quartile'
      ;
      /**low = smallest value in the data
          high = largest value in the data
          you cannot use the < with either*/
run;
proc freq data=sashelp.heart order=formatted;
    table Chol_status*systolic;
    format Chol_status $NewChol. 
            systolic sysQuartB.;
run;

proc format;
    value $Interesting
      'Sedan'-'Wagon' = 'Car'
      'Hybrid' = 'Hybrid'
      other = 'Truck'
      ;/**Value ranges are legal for character
       data--use alphanumeric order*/
run;

proc freq data=sashelp.cars;
  table type;
  format type $Interesting.;
  /**this puts Truck into the rule for Car since
    it is alphabetically between S and W*/
run;

proc format cntlout=myFormats;
    value $NewChol
      'Desirable' = '1. Desirable'
      'Borderline' = '2. Borderline'
      'High' = '3. High'
      ;
    value $NewWeight
      'Underweight' = 'A. Under'
      'Normal' = 'B. Normal'
      'Overweight' = 'C. Over'
      ;
run;/**It's possible to store definitions
  for reuse in a couple of different ways*/
