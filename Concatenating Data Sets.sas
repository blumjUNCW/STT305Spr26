libname SASData '~/SASData';
/*concatenation (stacking) of tables is done in
  the DATA step with the SET statement...*/

data SFWeather;
  set SASData.weather_sanfran2016 SASData.weather_sanfran2017;
  /*implicit loop goes from first record in first data table listed
    to the last record in the last table listed*/
  /*column alignment ends up being on name and type*/
  /*
    1. at compilation, the first table's metadata is scanned and
       all variable attributes are pulled
    2. looks at subsequent tables--any variable with the same name
        is not added to the list. If it has the same name and a different
        type, and error is generated and processing stops. Attributes
        from the first instance are inherited for all records read
    3. anything not present in the first data set but present in subsequent
        data sets is added to the variable list */
run;

/*Year is not included in the combined data, but I have several
  ways to get it done. Easiest is by using an IN= variable*/
data SFWeather;
  set SASData.weather_sanfran2016(in=in16)
      SASData.weather_sanfran2017(in=in17)
      ;
      /* dataset(in=varname)
        varname is your choice--choose something not already in the data
        this is 0/1, 1 if the current record has a contribution from that
          table, 0 if not
        
        in= variables are automatically dropped*/
  *sf16=in16;
  *sf17=in17;
  if in16 then year=2016;
    else if in17 then year=2017;
run;

/*It's still a DATA step, even though we are combining data in it,
  so old ideas still apply*/

/*let's make a numeric month..*/
data SFWeather;
  set SASData.weather_sanfran2016(in=in16 rename=(month=mon))
      SASData.weather_sanfran2017(rename=(month=mon) in=in17)
      ;
  if in16 then year=2016;
    else if in17 then year=2017;
  month=input(scan(mon,1),best12.);
  drop mon;
run;

/*put in a date variable for each record--start with first of
  the month*/
data SFWeather;
  set SASData.weather_sanfran2016(in=in16 rename=(month=mon))
      SASData.weather_sanfran2017(rename=(month=mon) in=in17)
      ;
  if in16 then year=2016;
    else if in17 then year=2017;/*in vars get me the year...*/
  month=input(scan(mon,1),best12.);/*scan + input gets me the month*/
  /*if I have day, month, and year, is there a function that makes that
    into a date?*/
  date = mdy(month,1,year);

  format date monyy7.;
  drop mon;
run;

/*let's make it the end of the month..*/
data SFWeather;
  set SASData.weather_sanfran2016(in=in16 rename=(month=mon))
      SASData.weather_sanfran2017(rename=(month=mon) in=in17)
      ;
  if in16 then year=2016;
    else if in17 then year=2017;
  month=input(scan(mon,1),best12.);

  endOfMonth=intnx('month',mdy(month,1,year),0,'end');

  date = mdy(month,day(endOfMonth),year);

  format date monyy7. endOfMonth mmddyy10.;
  drop mon;
run;

/*we can drop intermediate stuff, or we can nest functions*/
data SFWeather;
  set SASData.weather_sanfran2016(in=in16 rename=(month=mon))
      SASData.weather_sanfran2017(rename=(month=mon) in=in17)
      ;
  if in16 then date=intnx('month',mdy(input(scan(mon,1),best12.),1,2016),0,'end');
    else if in17 then date=intnx('month',mdy(input(scan(mon,1),best12.),1,2017),0,'end');

  format date mmddyy10.;
  drop mon;
run;

data np14_17;
  set SASData.np_2014 SASData.np_2015 SASData.np_2016 SASData.np_2017;
  /*columns that "match" in terms of their data, don't match on their
  names here, so I get an unwanted mis-alignment
  So, I'll align the names that should be aligned...*/
run;

data np14_17;
  set SASData.np_2014(rename=(Park=ParkCode type=ParkType)) /*match names for 15/16*/
      SASData.np_2015
      SASData.np_2016
      SASData.np_2017(rename=(UnitCode=ParkCode) drop=ParkName)/*again, align mismatches*/
      ;
  /*only mismatch is ParkName, which is in the 2017 data only
    if I don't want it, I should explicitly drop it*/
run;

data np14_17;
  set SASData.np_2014(rename=(Park=ParkCode type=ParkType)) /*match names for 15/16*/
      SASData.np_2015
      SASData.np_2016
      SASData.np_2017(rename=(UnitCode=ParkCode) drop=ParkName)/*again, align mismatches*/
      ;
  campingAll = sum(of camping:);
  format camping: comma12.;
run;