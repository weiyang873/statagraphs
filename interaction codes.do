/***********graphing interactions*****
*This is an short code for graphing interactions using marginsplot
Maginsplot should work on the majority of regressions
but there are some regression 
commends after which marignslot is not allowed*/ 

*** set your directory in ""
cd "C:\Stata"  

*** open your file
use filename.dta, clear
*** label your dependent variable 
label variable dv "dv_lab"

*** label your independent variable 
label variable dv "dv_lab"

label variable iv "iv_lab"

*** label your moderator variable 
label variable mod "iv_lab"

   

*** run the regression here 
reg dv iv mod c.iv#c.mod,robust 	

local lab`dv' : var label `dv' 
local lab`iv' : var label `iv' 
local lab`mod' : var label `mod' 

	
qui sum `iv' if e(sample)
local rmax_`iv'=r(max)
local rmin_`iv'=r(min)
local diff=	 (`rmax_`iv''-`rmin_`iv'')/100	 			 
			
** graphing interactions at mean+2sd and mean-2sd
qui sum `mod' if e(sample)
local up_`mod'=r(mean)+2*r(sd)
local down_`mod'=r(mean)-2*r(sd)
local interval_`mod'=r(mean)+4*r(sd)
		 
					
			 				 			 
qui margins ,  at (`iv'=(`rmin_`iv''(`diff')`rmax_`iv'') `mod'=(`down_`mod''(`interval_`mod'')`up_`mod'') atmeans

marginsplot, x ( `var')  /// * add noci at the end of this line if you don't want confidence interval displayed
  xtitle(" `lab`iv''") ytitle(" `lab`dv''" ) ///
  title("Interaction graph") ///
  legend(order(1 "Low `lab`var''"  2 "High `lab`var''"))
  
   
graph save  Graph "graph_`lab`var''.gph", replace
graph export "graph_`lab`var''.png", as(png) replace
