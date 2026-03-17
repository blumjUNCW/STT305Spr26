libname SASData '~/SASData';

/**Create a new data set from Storm_Damage that has the following columns:
  Name - name of the storm **
  StormType - Hurricane or Tropical Storm **
  Date - formatted to mm/dd/yyyy **
  Category - Storm category for hurricanes, missing for TS
  Cost - formatted as dollars **

  Only want these five, get rid of the rest...
  */

  data Test;
    set SASData.storm_damage;

    check1=scan(event,1);
    check2=scan(event,2);
    check3=scan(event,3);

    sub1=substr(event,1,1);
    sub2=substr(event,5);
    sub3=substr(event,3,5);

    if scan(event,1) eq 'Hurricane' then name=scan(event,2);
      else name=scan(event,3);

    nameB=scan(event,-1);

    format date mmddyy10. cost dollar20.;
  run;

  data Test2(drop=summary);
    set SASData.storm_damage;

    if substr(event,1,1) eq 'H' then do;
      name=scan(event,2);
      stormType='Hurricane';
    end;
    else do;
      name=scan(event,3);
      stormType='Tropical Storm';
    end;
      
    format date mmddyy10. cost dollar20.;
  run;/**My length for StormType is insufficient--length 9 comes from literal
                                assignment to Hurricane as the first encounter
        Name is more than enough...scan is applied to event, which is length 22*/

  data Test3(drop=summary);
    set SASData.storm_damage;

    length stormType $20;/*before it is encountered, set a length for StormType*/
    if substr(event,1,1) eq 'H' then do;
      name=scan(event,2);
      stormType='Hurricane';
    end;
    else do;
      name=scan(event,3);
      stormType='Tropical Storm';
    end;
      
    format date mmddyy10. cost dollar20.;
  run;

  data Test4(drop=summary);
    set SASData.storm_damage;

    if substr(event,1,1) eq 'H' then do;
      name=scan(event,2);
      stormType=scan(event,1);
    end;
    else do;
      name=scan(event,3);
      stormType=catx(' ',scan(event,1),scan(event,2));
    end;
      
    format date mmddyy10. cost dollar20.;
  run;

  data Test5;
    set SASData.storm_damage;

    if substr(event,1,1) eq 'H' then do;
      name=scan(event,2);
      stormType=scan(event,1);
    end;
    else do;
      name=scan(event,3);
      stormType=catx(' ',scan(event,1),scan(event,2));
    end;

    /**find the first instance of "category" (case-insensitive) in Summary*/
    location=find(summary,'category','i');
    /* i as third argument makes the finding case-insensitive*/
    
    /*Now I need the number that follows it...*/
    categoryLoc = anydigit(Summary,location);/**where it is */
    categoryChar = substr(Summary,categoryLoc,1);/**What it is*/
    category = input(categoryChar,1.);
        /**Input converts character to numeric, when legal,
            using a format as a conversion instruction*/

    format date mmddyy10. cost dollar20.;
  run;

  
  data Finish(keep=name StormType date cost category);
    set SASData.storm_damage;

    if substr(event,1,1) eq 'H' then do;
      name=scan(event,2);
      stormType=scan(event,1);
      category=input(substr(Summary,anydigit(Summary,find(summary,'category','i')),1),1.);
      /*Nesting of functions is permitted*/
    end;
    else do;
      name=scan(event,3);
      stormType=catx(' ',scan(event,1),scan(event,2));
    end;

    format date mmddyy10. cost dollar20.;
  run;

  /*What if I wanted separate data sets for tropical storms and
    hurricanes?*/

  data Hurricanes(keep=name date cost category) Tropical(keep=name date cost);
    length name $20;
    format category 1. date mmddyy10. cost dollar20.;
    /*Multiple data sets, with separate options, can be listed in the
        DATA statement--typically I will then control output somewhere in my 
            remaining code*/
    set SASData.storm_damage;

    if substr(event,1,1) eq 'H' then do;
      name=scan(event,2);
      category=input(substr(Summary,anydigit(Summary,find(summary,'category','i')),1),1.);
      output Hurricanes; /*output data-set-name; directs output of the current record
                          to the specified data set. If no data set is listed, output
                          is to all data sets*/
    end;
    else do;
      name=scan(event,3);
      output Tropical;
   end;

  run;