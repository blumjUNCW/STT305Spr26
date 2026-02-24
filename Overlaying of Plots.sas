proc sgplot data=sashelp.cars;
  reg x=horsepower y=mpg_highway;
  reg x=horsepower y=mpg_city;
  /*Scatter-type plots are compatible for overlaying,
   as long as you have one variable in common (x in this case)*/
run;

proc sgplot data=sashelp.cars;
  reg y=horsepower x=mpg_highway;
  pbspline y=horsepower x=mpg_city;
  /*Scatter-type plots are compatible for overlaying,
   as long as you have one variable in common (y in this case)*/
run;

proc sgplot data=sashelp.cars;
  reg x=horsepower y=mpg_highway / markerattrs=(symbol=circlefilled color=cxFFAA00)
                                lineattrs=(color=cxFFAA00);
  reg x=horsepower y=mpg_city  / markerattrs=(symbol=squarefilled color=cx00FFAA)
                                lineattrs=(color=cx00FFAA);
  /*Since they are separate plots, you can choose marker style separately for each
      but I have to make lines and colors match*/
run;


proc sgplot data=sashelp.cars;
  styleattrs datacontrastcolors=(red blue);
  reg x=horsepower y=mpg_highway;
  reg x=horsepower y=mpg_city;
  /*You can use datacontrastcolors to set the color list...*/
run;

proc sgplot data=sashelp.cars;
  styleattrs datacontrastcolors=(red blue);
  reg x=horsepower y=mpg_highway / legendlabel='Highway MPG';
  reg x=horsepower y=mpg_city / legendlabel='City MPG';
  /*legendlabel= lets you pick the text that goes in the legend
      for that plot*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_city stat=mean;
  hbar origin / response=mpg_highway stat=mean;
  /**can overlay bar charts of the same type if 
    you use the same charting variable*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_highway stat=mean;
  hbar origin / response=mpg_city stat=mean;
  /**can overlay bar charts of the same type if 
    you use the same charting variable
    may not look so good by default*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_city stat=mean;
  hbar origin / response=mpg_highway stat=mean
              barwidth=.5;
  /**barwidth is between 0 and 1,
      1 is 100% of the space allocated to 
      each individual bar*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_city stat=mean;
  hbar origin / response=mpg_highway stat=mean
              barwidth=.5 transparency=.2;
  /**transparency is also 0 to 1,
      0 is opaque, 1 is fully transparent = no fill*/
run;


proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_city stat=mean;
  hbar origin / response=mpg_highway stat=mean
              barwidth=.5 
              fillattrs=(color=cxFF9900 transparency=.2);
  /**transparency can also be set as part of fillattrs*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_highway stat=mean discreteoffset=-0.2;
  hbar origin / response=mpg_city stat=mean discreteoffset=0.2;
  /**hbar uses a discrete axis for the charting variable (origin)
      and you can put an offset on that with
      discreteoffset*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_highway stat=mean discreteoffset=-0.2
              barwidth=0.4;
  hbar origin / response=mpg_city stat=mean discreteoffset=0.2
              barwidth=0.4;
  /**usually I combine that with barwidth,
      barwidth = 2 * offset*/
run;

proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_highway stat=mean discreteoffset=-0.2
              barwidth=0.375;
  hbar origin / response=mpg_city stat=mean discreteoffset=0.2
              barwidth=0.375;
  /**usually I combine that with barwidth,
      barwidth = 2 * offset*/
run;

proc sgplot data=sashelp.cars;
  scatter x=horsepower y=mpg_highway;
  scatter x=horsepower y=msrp;
run;/**these two y-variables have vastly different scales*/

proc sgplot data=sashelp.cars;
  scatter x=horsepower y=mpg_highway;
  scatter x=horsepower y=msrp / y2axis;
  /*y2axis is the vertical axis on the right side of the frame*/
run;

proc sgplot data=sashelp.cars;
  scatter x=horsepower y=mpg_highway;
  scatter x=horsepower y=msrp / y2axis;
  yaxis labelattrs=(color=blue);
  y2axis labelattrs=(color=red);
  /*y2axis is also a statement to style that axis*/
run;


proc sgplot data=sashelp.cars;
  scatter x=horsepower y=mpg_highway / name='MPG';
  scatter x=horsepower y=msrp / y2axis name='Price';
  /**can give a value for name, which is the name
    for the graph legend*/
  yaxis labelattrs=(color=blue);
  y2axis labelattrs=(color=red);
  keylegend 'MPG' / position=bottomleft location=inside;
  keylegend 'Price' / position=bottomright location=inside;
run;


proc sgplot data=sashelp.cars;
  hbar origin / response=mpg_highway stat=mean discreteoffset=-0.2
              barwidth=0.375 x2axis;
  hbar origin / response=msrp stat=mean discreteoffset=0.2
              barwidth=0.375;
  /**x2axis is the horizontal axis at the top*/
run;

proc sgpanel data=sashelp.cars;
  panelby origin / rows=1;
  scatter x=horsepower y=mpg_city;
run;