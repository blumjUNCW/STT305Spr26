libname SASData '~/SASData';

/**Suppose I wanted to make quality in the RealEstate data a character
  variable with the correct values, while still keeping it
  named quality*/

data try1;
  set SASData.realestate;/*quality is numeric in this data set...*/
  if quality eq 1 then quality='High';/*So, I can't store character data in it*/

run;

data try2;
  length quality $10;/*say quality is character, length 10...*/
  set SASData.realestate;/*..even though here it's numeric*/
      /*which then creates a conflicting variable type*/
run;

data correct;
  set SASData.realestate(rename=(quality=QualityCode sq_ft=SquareFeet));
              /*as a dataset option rename=(oldname=newname)
                allows you to rename a column at the input phase*/
  length quality $10;
  if qualityCode eq 1 then quality='High';
    else if qualityCode eq 2 then quality='Medium';
      else quality = 'Low';
run;


data wrong1;
  set SASData.realestate;
  rename quality=QualityCode sq_ft=SquareFeet;
    /**rename is a statement...it is equivalent to 
        applying the option to the output data set*/
  length quality $10;
  if qualityCode eq 1 then quality='High';
    else if qualityCode eq 2 then quality='Medium';
      else quality = 'Low';
run;

data wrong2(rename=(quality=QualityCode sq_ft=SquareFeet));
    /**doing this for the output data set is too late */
  set SASData.realestate;
  length quality $10;
  if qualityCode eq 1 then quality='High';
    else if qualityCode eq 2 then quality='Medium';
      else quality = 'Low';
run;

data correct;
  set SASData.realestate(rename=(quality=QualityCode sq_ft=SquareFeet));
              /*as a dataset option rename=(oldname=newname)
                allows you to rename a column at the input phase*/
  length quality $10;
  if qualityCode eq 1 then quality='High';
    else if qualityCode eq 2 then quality='Medium';
      else quality = 'Low';

  drop QualityCode;
run;

data correct(drop=QualityCode);
  set SASData.realestate(rename=(quality=QualityCode sq_ft=SquareFeet));
              /*as a dataset option rename=(oldname=newname)
                allows you to rename a column at the input phase*/
  length quality $10;
  if qualityCode eq 1 then quality='High';
    else if qualityCode eq 2 then quality='Medium';
      else quality = 'Low';

run;

data rounding;
  value = 100/7;
  ceiling = ceil(value);
  floor = floor(value);
  round = round(value);
  round1 = round(value,1);
  roundTenth = round(value,.1);
  roundHundredth = round(value,.01);
  roundTen = round(value,10);

  format value 4.1;

  diff = value - round1;
run;

data today;
  CurrentDate = today();
    /**Today() is a function with no arguments to return
        the current date--parentheses are required to identify
        it as a function, but no argument is permitted inside them*/
  year = year(CurrentDate);
  month = month(CurrentDate);
  day = day(CurrentDate);
  format CurrentDate weekdate.;
run;