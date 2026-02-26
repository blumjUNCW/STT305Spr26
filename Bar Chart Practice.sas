proc sgplot data=sashelp.cars;
  where type in ('SUV' 'Sedan' 'Wagon');
  styleattrs datacolors=(cx377eb8 cx4daf4a cx984ea3);
  hbar origin / response=mpg_city stat=median 
                group=type groupdisplay=cluster
                outlineattrs=(color=black);
run;

proc sgplot data=sashelp.cars;
  where type in ('SUV' 'Sedan' 'Wagon');
  styleattrs datacolors=(cx377eb8 cx4daf4a cx984ea3);
  hbar origin / response=mpg_city stat=mean 
                group=type groupdisplay=cluster
                outlineattrs=(color=black);
  yaxis display=(nolabel) valueattrs=(color=cx377eb8 weight=bold);
  xaxis label='Average City MPG' labelattrs=(style=italic size=12pt)
        values=(0 to 25 by 5);
  keylegend / position=topleft border title='';
run;