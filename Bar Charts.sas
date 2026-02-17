/**For Graphs/Charts we will use PROC SGPLOT and SGPANEL
  SG->Statistical Graphics*/

proc sgplot data=sashelp.heart;
  /**SGPLOT will include at least one plotting statement (maybe more than one)
     and possibly several styling statements*/
  hbar chol_status;
  /**hbar--horizontal bar chart, 
      hbar variable; the variable is treated as categorical
    Default summary (on horizontal axis) is the frequency count for each category*/
run;

proc sgplot data=sashelp.heart;
  vbar chol_status;/**vbar, same with vertical bars*/
run;

proc sgplot data=sashelp.heart;
  vbar chol_status / stat=percent;/**default stat can be changed from frequency
                                    to relative frequency/percent*/
run;

proc sgplot data=sashelp.heart;
  vbar chol_status / response=systolic;
    /**response= picks a quantitative variable to summarize in each group
        default stat is sum, which you can change...*/
run;

proc sgplot data=sashelp.heart;
  vbar chol_status / response=systolic stat=median;
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume;
run;/**every value of date is its own category, as formatted..*/

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  /**applying a format changes the categories potentially */
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume group=stock;
  /**group= makes a grouped chart, variable chosen is
      taken as categorical
      
      Bar is cut into pieces for each level of the group variable*/
  format date qtr.;
run;


proc sgplot data=sashelp.stocks;
  hbar stock / response=volume group=date;
  /**group= categorizes based on the active format*/
  format date qtr.;
run;

proc sgplot data=sashelp.heart;
  vbar chol_status / response=systolic stat=median 
                      group=weight_status;
  /**For mean or median stats, stacked bars don't make
  much sense...*/
run;

proc sgplot data=sashelp.heart;
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster;
        /**Cluster puts a bar for each group within each
            level of the charting variable*/
run;

proc sgplot data=sashelp.heart;
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      dataskin=sheen;
run;


proc sgplot data=sashelp.heart;
  vbar chol_status / response=systolic stat=median
                      fillattrs=(color=cyan);
                      /**fillattrs: bar fill attributes*/
run;

proc sgplot data=sashelp.heart;
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      dataskin=sheen fillattrs=(color=cyan);
                      /**You only get to pick one color with
                        fillattrs, not enough for groups...*/
run;

proc sgplot data=sashelp.heart;
  hbar chol_status / response=systolic stat=median 
                      group=weight_status groupdisplay=cluster
                      outlineattrs=(color=black);
                      /**outlineattrs sets bar outline attributes*/
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  /**You can include axis statements, XAXIS and/or YAXIS
    to style/alter the axes*/
  yaxis label='Quarter' labelpos=top labelattrs=(weight=bold size=12pt);
  /**In an axis, you can set the label to any text with label='Text' */
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  yaxis label='Quarter' labelpos=top labelattrs=(weight=bold size=12pt) 
          discreteorder=formatted;
          /**Ordering is done for graphs in rather localized places...*/
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  yaxis label='Quarter' labelpos=top labelattrs=(weight=bold size=12pt) 
          discreteorder=formatted;
  xaxis label='Total Volume' values=(0 to 10000000000 by 5000000000) 
        minor minorcount=4;
        /**values are the text that appears at each major tick,
          for quantitative axes you can say values=(A to B by C)
          
          minor says display some minor ticks,
          minor count is the number of minor ticks between two majors*/
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  yaxis label='Quarter' labelpos=top labelattrs=(weight=bold size=12pt) 
          discreteorder=formatted;
  xaxis label='Total Volume' values=(0 to 10000000000 by 1000000000)
        fitpolicy=stagger;
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  yaxis label='Quarter' labelpos=top labelattrs=(weight=bold size=12pt) 
          discreteorder=formatted;
  xaxis label='Total Volume' values=(0 to 10000000000 by 2000000000)
        fitpolicy=stagger grid gridattrs=(color=gray66);
        /**Grid puts a reference line at every major tick*/
run;

proc sgplot data=sashelp.stocks;
  hbar date / response=volume ;
  format date qtr.;
  yaxis label='Quarter' labelpos=top labelattrs=(weight=bold size=12pt) 
          discreteorder=formatted;
  xaxis label='Total Volume' values=(0 to 10000000000 by 2000000000)
        fitpolicy=stagger grid gridattrs=(color=gray66) offsetmax=0;
run;