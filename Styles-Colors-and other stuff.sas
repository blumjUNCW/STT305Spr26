
proc sgplot data=sashelp.heart;
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      fillattrs=(color=red);
                      /**How do I set colors for group charts?*/
run;


proc sgplot data=sashelp.heart;
  styleattrs datacolors=(blue red green);
  /**styleattrs sets global styling lists
      datacolors are fill colors*/
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
run;

proc sgplot data=sashelp.heart;
  styleattrs datacolors=(lightstrongpurple mediumvividreddishorange 
                            darkstrongbluishgreen);
  /**sas provides interesting color naming*/
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
run;

/**Most of the time, I'll use RGB color codes
  form is: cxRRGGBB  NN is intensity in hex (base 16)*/
proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cxFF0000 cx00FF00 cx0000FF);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
run;


proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
run;


proc sgplot data=sashelp.stocks;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
    /*datacolors is for fills..*/
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
run;

proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3);
    /*datacontrastcolors is for lines and markers..*/
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
run;

proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled);
    /*default behavior for markers is to separate the attributes of
        color and symbol and cycle through colors until you run
          out and then change symbols*/
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
run;

ods graphics / attrpriority=none;
  /*default priority is color, you can change it to none (and only that)*/
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
    /*since line patterns now also cycle, I'll just set it to
      one thing*/
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
run;