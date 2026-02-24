
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


proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
  /*legend styles are set in the keylegend statement
    keylegend name(s) / options;
      name(s) might be blank
  */
  keylegend / title='Weight';
    /**the legend has a title, which is usually the group= variable
        label when group is used*/
run;

proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
   keylegend / title='Weight' position=topright;
    /**Position= moves the legend around the box...
        top, bottom, left right, topleft, topright, bottomleft, bottomright*/
run;

proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
   keylegend / title='Weight' position=right;
    /**Depending on where you put it, the legend is written 
      horizontally or vertically*/
run;

proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
   keylegend / title='Weight' position=topleft noborder ;
    /**can remove the border...*/
run;

ods graphics / noborder;
proc sgplot data=sashelp.heart noborder;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      ;
   keylegend / title='Weight' position=topleft noborder ;
run;/*NOBORDER is usable in three different places to remove 
  bounding boxes*/

ods graphics / attrpriority=none;
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
  keylegend / location=inside position=bottomleft;
    /*location is either inside or outside (default)
        inside is in the plotting area*/
run;


ods graphics / attrpriority=none;
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
  keylegend / location=inside position=bottomleft
          across=1;
    /*across sets the number of columns in a legend
      down sets the number of rows
      usually, I would only set one of these*/
run;

ods graphics / attrpriority=none;
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
  keylegend / location=inside position=bottomleft
          across=1 title='';
    /*there is no display= like there is in an axis statement,
       you can blank out the title*/
run;


ods graphics / attrpriority=none;
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
  keylegend / location=inside position=bottomright
          across=1 title='';
    /*if it's inside, the legend can collide with the graph
      graph points are seen...*/
run;



ods graphics / attrpriority=none;
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
  keylegend / location=inside position=bottomright
          across=1 title='' opaque;
    /*can make the legend non-transparent if I want*/
run;


ods graphics / noborder;
proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      ;
   keylegend / title='Weight' position=topright noborder 
                location=inside across=1;
    /*If you really want the legend inside but there isn't room
      by default, you can manipulate the axes...*/
run;

proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      ;
   keylegend / title='Weight' position=topright noborder 
                location=inside across=1;
   xaxis values=(0 to 175 by 25);
    /*can play with the value set on the axis to create some extra
        whitespace to fit the legend on the right side*/
run;

proc sgplot data=sashelp.heart;
  styleattrs datacolors=(cx1b9e77 cxd95f02 cx7570b3);
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      ;
   keylegend / title='Weight' position=topright noborder 
                location=inside across=1;
   xaxis offsetmax=.16;
    /*offsetmax can also be used to create whitespace without adding
      major ticks to the axis. Here I'm setting it to 16%*/
run;

ods graphics / attrpriority=none;
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cx1b9e77 cxd95f02 cx7570b3)
             datasymbols=(diamondfilled squarefilled circlefilled)
             datalinepatterns=(solid);
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price';
  xaxis display=(nolabel);
  keylegend / location=inside position=bottomright
          title='';
  yaxis offsetmin=.075;
run;