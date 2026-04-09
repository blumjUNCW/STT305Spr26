libname SASData '~/SASData';

data SFWeather;
  merge SASData.weather_sanfran2017 SASData.weather_sanfran2016;
  /*merge matches records/rows from multiple data sets--usually with BY
    if you don't use BY, it matches on the row number*/
  /*Variables and their attributes are set up at compilation by
    scanning the contents of each table...*/
  by month;
  /*BY lists the set of variables you want to match records on
    expected to be the same name and type in all data sets*/

run;

data SFWeather;
  merge SASData.weather_sanfran2016(rename=(avgTemp=avgTemp16))
        SASData.weather_sanfran2017(rename=(avgTemp=avgTemp17));
  by month;

  diff17_16 = avgTemp17-avgTemp16;
  label diff17_16 = 'Avg Difference, 2017-2016';
  format diff17_16 10.2;
run;

data np_2015;
  merge SASData.np_2015 SASData.np_codelookup;
  by ParkCode;
  /*BY always presumes sorting, in each table when merging*/
run;

proc sort data=sasdata.np_2015 out=Sort2015;
  by ParkCode month;
run;
proc sort data=sasdata.np_codelookup out=SortCodes;
  by ParkCode;
run;

data np_2015;
  merge Sort2015 SortCodes;
  by ParkCode;
  /*BY always presumes sorting, in each table when merging*/
run;

data np_2015;
  merge Sort2015 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;

/**How about 2014?*/
proc sort data=sasdata.np_2014 out=Sort2014(rename=(park=ParkCode));
  by Park month;
run;/*make your BY variable name match somewhere in here...*/

data np_2014;
  merge Sort2014 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;

/*2016 is the same as 2015, effectively*/
proc sort data=sasdata.np_2016 out=Sort2016;
  by ParkCode month;
run;
data np_2016;
  merge Sort2016 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;

/*2017 already has some names in it...I'll get rid of them*/
proc sort data=sasdata.np_2017 
          out=Sort2017(rename=(UnitCode=ParkCode) drop=ParkName);
  by UnitCode month;
run;
data np_2017;
  merge Sort2017 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;

/**All of these merges preserve all records from all data sets, even
  if there is no match for a record
  
  You can use the IN= variables to monitor this...*/

data np_2017;
  merge Sort2017(in=inNP) 
  SortCodes(in=inCode keep=ParkCode ParkName);
  by ParkCode;

  if inNP and inCode then output;
    /*if there's a contribution from the park data and from the code
        data, output it (otherwise don't)

      contribution from both is a match*/
run;

data np_2017 mismatch;
  merge Sort2017(in=inNP) 
  SortCodes(in=inCode keep=ParkCode ParkName);
  by ParkCode;

  if inNP and inCode then output np_2017;
    else output mismatch;
run;

data np_2017 NPnotCode CodeNotNP;
  merge Sort2017(in=inNP) 
  SortCodes(in=inCode keep=ParkCode ParkName);
  by ParkCode;

  if inNP and inCode then output np_2017;
    else if inNP then output NPnotCode;
      else if inCode then output CodeNotNP;
run;
/*any match/mismatch records can be preserved with
  IN= variables and conditional output*/

/*Suppose I want to put all of four years together with the names...*/

/**Here's what we did repeated */
proc sort data=sasdata.np_codelookup out=SortCodes;
  by ParkCode;
run;
data np_2014;
  merge Sort2014 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;
proc sort data=sasdata.np_2015 out=Sort2015;
  by ParkCode month;
run;
proc sort data=sasdata.np_2016 out=Sort2016;
  by ParkCode month;
run;
proc sort data=sasdata.np_2017 
          out=Sort2017(rename=(UnitCode=ParkCode) drop=ParkName);
  by UnitCode month;
run;
data np_2014;
  merge Sort2014 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;
data np_2015;
  merge Sort2015 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;
data np_2016;
  merge Sort2016 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;
data np_2017;
  merge Sort2017 SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;

data np14_17;
  set np_2014 np_2015 np_2016 np_2017;
run; 
/**5 Sorts and 5 Data steps--five sorts are unavoidable...
  5 Data steps is excessive*/

data allNP;
  set Sort2014(rename=(type=ParkType)) Sort2015 Sort2016 Sort2017;
run;

data np14_17B;
  merge allNP SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;/*I ruined my sort on the NP data...*/

data allNP;
  set Sort2014(rename=(type=ParkType)) Sort2015 Sort2016 Sort2017;
  by ParkCode month;
  /*If the stuff is sorted, you can preserve it during concatenation
    using an appropriate BY statement
    This is called interleaving */
run;
data np14_17C;
  merge allNP SortCodes(keep=ParkCode ParkName);
  by ParkCode;

  CampingAll = sum(of camping:);
  format camping: comma12.;
run;


/*let's make a data set that will let us look at DayVisits across
  the four years...*/ 
data np14_17Merge;
  merge Sort2014(keep=ParkCode Region State Month DayVisits rename=(DayVisits=Visits14)) 
        Sort2015(keep=ParkCode Region State Month DayVisits rename=(DayVisits=Visits15))
        Sort2016(keep=ParkCode Region State Month DayVisits rename=(DayVisits=Visits16))
        Sort2017(keep=ParkCode Region State Month DayVisits rename=(DayVisits=Visits17))
        ;
  by ParkCode month;
  totVisits = sum(of Visits14-Visits17);
run;

data np14_17D(keep=ParkCode Region State Month DayVisits);
  merge allNP SortCodes(keep=ParkCode ParkName);
  by ParkCode;
run;
