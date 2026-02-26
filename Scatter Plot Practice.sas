title 'IBM Open vs Close, 2000 through 2002';
proc sgplot data=sashelp.stocks noautolegend;
  reg x=open y=close / markerattrs=(symbol=diamondfilled)
                    lineattrs=(color=red);
  *where year(date) between 2000 and 2002
        and stock='IBM';
  where date between '01JAN2000'd and '31DEC2002'd
        and stock='IBM';
run;

title 'IBM Open vs Close, 2000 through 2002';
proc sgplot data=sashelp.stocks;
  styleattrs datacontrastcolors=(cxfdc086 cxbeaed4 cx386cb0);
  reg x=open y=close / markerattrs=(symbol=trianglefilled)
                      group=date;
  format date year.;
  where year(date) between 2000 and 2002
        and stock='IBM';
  keylegend / location=inside position=topleft title=''
                across=1;
  yaxis labelpos=top labelattrs=(weight=bold size=12pt);
  xaxis labelpos=right labelattrs=(weight=bold size=12pt);
run;