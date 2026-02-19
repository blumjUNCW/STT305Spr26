proc sgplot data=sashelp.heart;
  scatter x=systolic y=diastolic;
    /**scatterplots require a specification of the x and y variables*/
run;

proc sgplot data=sashelp.heart;
  scatter x=systolic y=diastolic / group=weight_status;
    /**Group= is available for scatterplots
        changes color across groups by default
        missing values are taken as a separate group level*/
run;

proc sgplot data=sashelp.heart;
  scatter x=systolic y=diastolic / group=weight_status nomissinggroup;
    /**nomissinggroup is available*/
run;

proc sgplot data=sashelp.heart;
  where weight_status ne '';
  scatter x=systolic y=diastolic / group=weight_status;
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  scatter y=mpg_city x=horsepower / markerattrs=(symbol=square color=green);
    /**markerattrs= sets marker attributes including the color and symbol and
        size*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  scatter y=mpg_city x=horsepower / markerattrs=(symbol=triangledownfilled
                                                  color=orange);
    /**markerattrs= sets marker attributes including the color and symbol and
        size*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  scatter y=mpg_city x=horsepower / filledoutlinedmarkers
                                    markerattrs=(symbol=squarefilled color=orange);
                                    /*can separate fill from outline,
                                      also separates attributes**/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  scatter y=mpg_city x=horsepower / 
                filledoutlinedmarkers
                markerattrs=(symbol=squarefilled)
                markerfillattrs=(color=orange)
                markeroutlineattrs=(color=blue);
                /*can separate fill from outline,
                also separates attributes**/
run;


proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  scatter y=mpg_city x=horsepower / 
                colorresponse=msrp
                colormodel=(green yellow orange red)
                markerattrs=(symbol=squarefilled)
                ;
        /*colorresponse and colormodel let me heatmap
        the scatterplot points*/
run;

/**There are some scatterplot-like plotting methods 
  also...*/
proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  reg y=mpg_city x=horsepower;
    /**reg does a regression
    (first-degree/line by default)*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  reg y=mpg_city x=horsepower / degree=2;
    /**you can set the degree from 1 to 10*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  reg y=mpg_city x=horsepower / degree=2
                                nomarkers
                                lineattrs=(color=red);
    /**you can turn off the markers, set line color..*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  reg y=mpg_city x=horsepower / group=origin
                                markerattrs=(symbol=diamondfilled);
  /**can separate across a group variable*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  pbspline y=mpg_city x=horsepower;
    /**pbspline does spline (smooth) curves*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  pbspline y=mpg_city x=horsepower / smooth=1000;
    /**pbspline does spline (smooth) curves*/
run;

proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  pbspline y=mpg_city x=horsepower / smooth=10000;
    /**smooth sets the smoothness of the curve,
      higher=smoother*/
run;


proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  pbspline y=mpg_city x=horsepower / smooth=10000
                                  lineattrs=(color=red)
                                  nomarkers;
run;

proc sgplot data=sashelp.stocks;
  scatter x=date y=high / group=stock;
  where year(date) eq 2000;
run;

proc sgplot data=sashelp.stocks;
  series x=date y=high / group=stock;
  /**Series is connect-the-dots in data order*/
  where year(date) eq 2000;
run;

proc sgplot data=sashelp.stocks;
  series x=date y=high / group=stock markers;
  /**markers are off for series, but you can turn them on*/
  where year(date) eq 2000;
run;


proc sgplot data=sashelp.cars;
  where type in ('Sedan','Wagon');
  series y=mpg_city x=horsepower;
  /*the x-axis order should correspond to data order, or you'll
      get some weird stuff otherwise...*/
run;


proc sgplot data=sashelp.stocks;
  series x=date y=high / group=stock markers;
  where year(date) eq 2000;
  yaxis values=(40 to 160 by 40) minor minorcount=1 label='High Price'
            grid gridattrs=(color=grayAA);
  xaxis display=(nolabel) grid gridattrs=(color=grayAA);
  /*display= is used to choose NOT to display things...*/
run;
