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

  proc freq data=SASData.storm_2017;
    table basin;
  run;

  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    /**SELECT blocks can also be used for conditional branching*/
    select(basin);/*starts with SELECT and an optional expression and requires end*/
     when('NA') output Atlantic; /*true if the parameter here matches expression in SELECT*/
     when('EP','SP') output Pacific; /*when arguments support lists automatically*/
     otherwise output Indian;/*OTHERWISE is available to cover any values
                              not included in the WHEN statements*/
    end;
  run;

  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    select(basin);
     when('NA') output Atlantic; 
     when('EP','SP') output Pacific;
    end;/*you must cover all possibilities, either in the set of WHEN statements
          or by using an OTHERWISE*/
  run;

  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    select(basin);
     when('NA') output Atlantic; 
     when('EP','SP') output Pacific;
     when('NI','SI') output Indian;
    end;/*If you cover everyting in your WHEN statements, OTHERWISE is not
          needed*/
  run;

  
  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    select(substr(basin,2,1));/*any expression can be put in the select*/
     when('A') output Atlantic; 
     when('P') output Pacific;
     when('I') output Indian;
    end;
  run;

  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    duration=EndDate-StartDate+1;
      /*it does make some sense to do math on date values*/

    if startDate gt endDate then problem='Yes';
      else problem='No';/*can also make comparisons directly*/

    select(substr(basin,2,1));
     when('A') output Atlantic; 
     when('P') output Pacific;
     when('I') output Indian;
    end;
  run;

  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    duration=EndDate-StartDate+1;

    weeks=intck('week',startDate,endDate);
    /*intck - count intervals
        intck('interval-type',start,end)*/
    months=intck('month',startDate,endDate);
    /*default method is to look for standard
      boundaries between weeks...Saturday/Sunday
                or months..1st of Month
                or years..Dec 31/Jan 1*/

    select(substr(basin,2,1));
     when('A') output Atlantic; 
     when('P') output Pacific;
     when('I') output Indian;
    end;

    format endDate startDate weekdate.;
  run;

  
  data Atlantic Pacific Indian;
    set SASData.storm_2017;

    duration=EndDate-StartDate+1;

    weeks=intck('week',startDate,endDate);
    months=intck('month',startDate,endDate);

    weeksB=intck('week',startDate,endDate,'Continuous');
    monthsB=intck('month',startDate,endDate,'Continuous');

    select(substr(basin,2,1));
     when('A') output Atlantic; 
     when('P') output Pacific;
     when('I') output Indian;
    end;

    format endDate startDate weekdate.;
  run;

  /*Suppose I want to know how far apart any
    two storms start day is, within the same basin*/
  proc sort data=SASData.storm_2017 out=storm17;
    by basin startDate;
  run;

  data DaysApart;
    set storm17(drop=location);
    
    /**need to use startDate values on separate, adjacent records*/
    previous=lag(startDate);
    previous2=lag2(startDate);
    /*lag makes variable values from previous records available
      on the current record*/

    format previous previous2 date9.;

  run;

  
  data DaysApart;
    set storm17(drop=location);
    
    DaysAfter=startDate-lag(startDate);
    /**OK, but I have an issue when the basin changes... */

    label DaysAfter = 'Days from Previous Storm Start';
  run;

  data DaysApart;
    set storm17(drop=location);
    
    DaysAfter=startDate-lag(startDate);
    if basin eq lag(basin) then output;

    label DaysAfter = 'Days from Previous Storm Start';
  run;

  /*What if I want to know the time from when the first storm
    begins to the last storm's end, for each basin?*/

  /**I can track BY groups in a DATA step using first. and last. variables*/
  data SeasonLength;
    set storm17(drop=location);

    by basin;
    /*if you put a BY statement in a DATA step, two variables (for each by variable)
      are created: first.byvar and last.byvar 
      these variables are automatically dropped, so if you want to see them
        assign them to a new variable*/
    
    *basinStart=first.basin;
    *basinEnd=last.basin;

    if first.basin then SeasonStart=StartDate; /*at the start of each basin 
                                get the start date for the first storm*/
    
    if last.basin then do;/*for the last record in a basin...*/
      SeasonEnd=EndDate;/*get the ending date...*/
      SeasonLength=SeasonEnd-SeasonStart;/*calculate the duration...*/
      *output;/*output the result*/
    end;
    *keep basin SeasonStart SeasonEnd SeasonLength;
    format SeasonStart SeasonEnd mmddyy10.;
  run;/*variables are reset to missing when new records are read,
      including the StartDate variable*/

  data SeasonLength;
    set storm17(drop=location);
    retain SeasonStart;/*RETAIN tells the data step to not reset this
                        variable to missing when new records are read*/

    by basin;
    
    if first.basin then SeasonStart=StartDate; /*at the start of each basin 
                                get the start date for the first storm*/
    
    if last.basin then do;/*for the last record in a basin...*/
      SeasonEnd=EndDate;/*get the ending date...*/
      SeasonLength=SeasonEnd-SeasonStart;/*calculate the duration...*/
      weeks=intck('week',SeasonStart,SeasonEnd);
      output;/*output the result*/
    end;
    keep basin SeasonStart SeasonEnd SeasonLength weeks;
    format SeasonStart SeasonEnd mmddyy10.;
  run;

  /*Suppose we want to make an interval for predicted season start
  and end in the next year--earliest start is 2 weeks prior to this
  year's start, latest end is 2 weeks after this year's end*/

  data Projection;
    set storm17(drop=location);
    retain SeasonStart;/*RETAIN tells the data step to not reset this
                        variable to missing when new records are read*/

    by basin;
    
    if first.basin then SeasonStart=StartDate; /*at the start of each basin 
                                get the start date for the first storm*/
    
    if last.basin then do;/*for the last record in a basin...*/
      SeasonEnd=EndDate;/*get the ending date...*/
      SeasonLength=SeasonEnd-SeasonStart;/*calculate the duration...*/
      weeks=intck('week',SeasonStart,SeasonEnd);
      NextStart=intnx('year',SeasonStart,1,'same');
      NextEnd=intnx('year',SeasonEnd,1,'same');
      output;/*output the result*/
    end;
    keep basin SeasonStart SeasonEnd SeasonLength weeks NextStart NextEnd;
    format SeasonStart SeasonEnd NextStart NextEnd weekdate.;
  run;