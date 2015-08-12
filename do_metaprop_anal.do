capture log close
cd "N:\Eking\Prevalence_study_data"

set more off
clear
use "C:\EllieDropboxCache\Dropbox\PhD\My research\THESIS\CHAPTERS\CH2_LIT_REVIEW\anal.dta"

rename study Study
rename anyhpv any
rename hrhpv hr
lab var Study ""
lab var sample "Sample size (n)"
lab define hiv 0 "HIV negative" 1"HIV positive" 2"Unknown HIV prevalence"
lab values hiv hiv

encode recruitment, gen(recruit)
encode Study, gen(study1)
encode region, gen(region1)
lab var recruit "Recruitment strategy"
lab var studylocation "Location"
lab var region1 "Region"


//CHANGED TO DOING METAPROP BECAUSE USES BINOMIAL CONFIDENCE LIMITS NOT APPROXIMATION TO NORMAL
*SEE PREVIOUS VERSIONS OF THIS DO_FILE FOR METAN FUNCTIONS
#delimit ;
mymetaprop any sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("Any HPV", size(small))
xscale(r(0, 70))
xlabel(0,10,20,30,40,50,60)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_analany1.gph, replace
;
#delimit ;
mymetaprop hr sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("High risk HPV", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20,30,40,50,60)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_analhr1.gph, replace
;
#delimit ;
graph combine metan_analany1.gph metan_analhr1.gph, 
title("Oral HPV DNA prevalence in MSM", size(small)) 
cols(2)
note("Weights are from random effects analyses")
scheme(s1mono) plotregion(lstyle(none)) 
;

#delimit ;
mymetaprop hpv16 sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("HPV16", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_analhpv16.gph, replace

#delimit ;
mymetaprop hpv16 sample if hiv==0, random by(region1) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-negative HPV16 prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
#delimit ;
mymetaprop hpv16 sample if hiv==0&year<2009, random by(region1) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-negative HPV16 prevalence", size(small))
texts(160)
xscale(r(0, 0.7))
xlabel(0,10,20, 30)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
nooverall
nosubgroup
;
#delimit ;
mymetaprop hr sample if year<2009, by(hiv) random cimethod(exact) nowt
lcols(Study sample studylocation region1 recruit )
texts(160)
xscale(r(0, 0.7))
xlabel(10,20, 30, 40, 50, 60, 70, 80, 90, 100)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
nooverall
nosubgroup
nobox
astext(70)
;  

#delimit ;
mymetaprop lr sample if year<2009, by(hiv) random cimethod(exact) nowt
lcols(Study sample studylocation region1 recruit  )
texts(160)
xscale(r(0, 0.7))
xlabel(10,20, 30, 40, 50, 60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
nooverall
nosubgroup
nobox
astext(80)
; 

#delimit ;
mymetaprop hpv16 sample if year<2009, by(hiv) random cimethod(exact) nowt
lcols(Study sample studylocation region1 recruit )
texts(140)
xlabel(10,20, 30, 40, 50, 60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
nooverall
nosubgroup
nobox
astext(80)
;  

#delimit ;
mymetaprop hpv6 sample if year<2009, by(hiv) random cimethod(exact) nowt
lcols(Study sample studylocation region1 recruit )
texts(140)
xlabel(10,20, 30, 40, 50, 60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
nooverall
nosubgroup
nobox
astext(80)
;  
#delimit ;
mymetaprop hpv16 sample if hiv==0, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-negative HPV16 prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
#delimit ;
mymetaprop hr sample if hiv==0&year<2009, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-negative HR-HPV prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 

#delimit ;
mymetaprop hpv16 sample if hiv==0&year<2009, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-negative HPV16 prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
#delimit ;
mymetaprop hpv16 sample if hiv==1, random by(region1) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-positive HPV16 prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,20,40,60)
astext(70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
;
#delimit ;
mymetaprop hpv16 sample if hiv==1&year<2009, random by(region1) cimethod(exact) nowt
lcols(Study sample)
subtitle("HPV16", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
;
#delimit ;
mymetaprop hr sample if hiv==1&year<2009, random by(region1) cimethod(exact) nowt
lcols(Study sample)
subtitle("High risk HPV", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60, 70, 80, 90, 100)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
;
#delimit ;
mymetaprop lr sample if year<2009, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
subtitle("Low risk HPV", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
;
#delimit ;
mymetaprop hpv6 sample , random by(hiv) cimethod(exact) nowt
lcols(Study sample)
subtitle("HPV6", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
astext(70)
;
#delimit ;
mymetaprop hpv16 sample if hiv==1&year<2009, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-positive HPV16 prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
;
#delimit ;
mymetaprop hr sample if hiv==1&year<2009, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
subtitle("HIV-positive HR-HPV prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60, 70, 80, 90, 100)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
;
#delimit ;
mymetaprop hpv16 sample if hiv==1, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("HIV-positive HPV16 prevalence", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20,30,40,50,60, 70)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
 
;
#delimit ;
mymetaprop hpv18 sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("HPV18", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20,30,40,50,60)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_oralhpv18.gph, replace
;

#delimit ;
mymetaprop hpv6 sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("HPV6", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20,30)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_oralhpv6.gph, replace
;
#delimit ;
mymetaprop hpv11 sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("HPV11", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20,30,40,50,60)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_oralhpv11.gph, replace
;

#delimit ;
graph combine metan_oralany1.gph metan_oralhr1.gph, 
title("Oral HPV DNA prevalence in MSM", size(small)) 
cols(2)
note("Weights are from random effects analyses")
scheme(s1mono) plotregion(lstyle(none)) 
;
#delimit ;

#delimit ;
graph combine metan_oralhpv16.gph metan_oralhr1.gph, 
title("Oral HPV DNA prevalence in MSM", size(small)) 
cols(2)
note("Weights are from random effects analyses")
scheme(s1mono) plotregion(lstyle(none)) 
;
#delimit ;

#delimit ;
graph combine  metan_oralhpv6.gph metan_oralany1.gph metan_oralvac.gph , 
title("Oral HPV DNA prevalence in MSM", size(small)) 
cols(2)
note("Weights are from random effects analyses")
scheme(s1mono) plotregion(lstyle(none)) 
;
#delimit ;


/*
mymetaprop vac sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
astext(70)
subtitle("HPV6/11/16/18", size(small))
xscale(r(0, 0.7))
xlabel(0,0.2,0.4,0.6)
xtitle("                                             Proportion", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save metan_oralvac1.gph, replace
;




// for random-effects meta-analysis
#delimit ;
mymetan p_any se_any , by(hiv)  
random nowt nobox
lcols(Study sample)
textsize(90)  
xtitle("                                             Prevalence (%)", size(vsmall)) 
xscale(r(0, 70))
xlabel(0,20,40,60)
astext(70) 
nooverall 
nulloff 
subtitle("Any HPV", size(small)) 
nowarning scheme(s1mono) plotregion(lstyle(none))

;
graph save metan_oralany.gph, replace
;

#delimit ;
mymetan p_hr se_hr , by(hiv)  
random nowt nobox
lcols(Study sample)  
textsize(70)
xtitle("                                             Prevalence (%)", size(vsmall)) 
xscale(r(0, 80))
xlabel(0,20,40,60,80) 
astext(70) 
nooverall 
nulloff 
subtitle("High risk HPV", size(small)) 
scheme(s1mono) plotregion(lstyle(none))
nowarning
;

graph save metan_oralhr.gph, replace
;
#delimit ;
graph combine metan_oralany.gph metan_oralhr.gph, 
title("Oral HPV DNA prevalence in MSM", size(small)) 
cols(2)
note("Weights are from random effects analyses")
scheme(s1mono) plotregion(lstyle(none)) 
;


#delimit cr
graph save metan_oral.gph, replace

local hpv any hr vac hpv16 hpv18 hpv6 hpv11

*VACIINE TYPES AND INDIVIDUAL:
#delimit ;
foreach var in `hpv'{
;
mymetan p_`var' se_`var' , by(hiv)  
random nowt nobox
lcols(Study sample)
textsize(70)  
xtitle("                                             Prevalence (%)", size(vsmall)) 
xscale(r(0, 80))
xlabel(0,20,40,60,80)
astext(70) 
nooverall 
nulloff 
subtitle("`var'", size(small)) 
nowarning scheme(s1mono) plotregion(lstyle(none))

;
graph save metan_oral`var'.gph, replace
;
}
;
#delimit ;
graph combine metan_oralvac.gph metan_oralhpv16.gph, 
title("Oral HPV DNA prevalence in MSM", size(small)) 
cols(2)
note("Weights are from random effects analyses")
scheme(s1mono) plotregion(lstyle(none)) 
;

#delimit ;
 metaprop vac sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
;


*/
gen p_any = .
gen se_any = . 

gen p_hr = .
gen se_hr = . 

gen p_h16 = .
gen se_h16 = . 



// get proportions and std errors 
forv i =1(1)19 {
cii sample[`i'] any[`i'], binomial
qui replace p_any = r(mean)*100 in `i'
qui replace se_any = r(se)*100 in `i'
} 
 
 
forv i =1(1)19 {
capture noisily cii sample[`i'] hr[`i'], binomial
qui replace p_hr = r(mean)*100 in `i'
qui replace se_hr = r(se)*100 in `i'
} 

forv i =1(1)19 {
capture noisily cii sample[`i'] hpv16[`i'], binomial
qui replace p_h16 = r(mean)*100 in `i'
qui replace se_h16 = r(se)*100 in `i'
} 
  




**************************************************************************************************************
*REGRESSION & BUBBLE PLOTS
************************************************************************************************************

*HPV16
metareg p_h16 medianage , wsse(se_h16) graph
xi: metareg p_h16 i.hiv , wsse(se_h16) permute(10000,joint(_Ihiv_1 _Ihiv_2))
xi: metareg p_h16 i.hiv , wsse(se_h16) 

/*
	
				
						1HIV clinic	5	
						2STI clinic	6	
3STI	clinic/gastroenterology clinic	1	
						4University	1	
						5community	3	
				6community/clinic	3	
				
	
*/
recode recruit 3=2 4=3 5=3 6=3 


recode oralspec 2=1 3=1 4=1 8=1 5=1 7=0 1=0 6=0
xi: metareg p_h16 i.recruit , wsse(se_h16) permute(1000,joint(_Irecruit_2 _Irecruit_3 )) 
xi: metareg p_h16 i.recruit , wsse(se_h16)  

xi: metareg p_h16 i.oralspec , wsse(se_h16) 
metareg p_h16 strobe, wsse(se_h16) 
xi: metareg p_h16 i.hiv medianage , wsse(se_h16) permute(2000,joint(_Ihiv_1 _Ihiv_2))




gen pos=0
***********************
*NOT STRATIFIED BY HIV
*************************
metareg p_any medianage , wsse(se_any) graph
*metareg p_any medianage , wsse(se_any) permute(20000)
 /*e(N) =  16
               e(tau2) =  147.5250117938128
               e(df_m) =  1
                  e(Q) =  319.8413995765218
               e(df_Q) =  14
                 e(I2) =  .9562283055960349
               e(df_r) =  14
               e(q_KH) =  .9927421041897365
              e(remll) =  -47.31590190083314
            e(remll_c) =  -180.0150046243789
             e(chi2_c) =  265.3982054470915
             e(tau2_0) =  230.296639597105
                  e(F) =  8.78712632440479
*/
predict fitty
local sq = char(178)
displ "`sq"'


local tau_any= "e(tau2)"
local tau_any : display %4.0f `tau_any'
local tau_any= "Tau`sq'  =`tau_any'"
display "`tau_any'"

local I_any= "e(I2)*100"
local I_any : display %2.0f `I_any'
local I_any= "I`sq'  =`I_any'"
display "`I_any'"

local R_any= "((e(tau2_0)-e(tau2))/e(tau2_0))*100"
local R_any : display %3.0f `R_any'
local R_any= "Adjusted R`sq'  =`R_any'"
display "`R_any'"

testparm medianage
local pvalue_any= r(p)
local pvalue_any : display %6.2f `pvalue_any'
local pvalue_any= "p=`pvalue_any'"
display "`pvalue_any'"


#delimit ;
twoway (scatter p_any medianage [aw=1/se_any^2] if hiv==0, msymbol (Oh) 
text(59 20 "`tau_any'", placement(e) size(vsmall))text(55 20 "`I_any'", placement(e)size(vsmall)) text(52 20 "`R_any'", placement(e)size(vsmall)) text(48 20 "`pvalue_any'", placement(e)size(vsmall))) 
(scatter p_any medianage [aw=1/se_any^2] if hiv==1, msymbol(O) mlcolor(gs5) mfcolor(gs15))
(scatter p_any medianage [aw=1/se_any^2] if hiv==2, msymbol(O) mlcolor(gs5) mfcolor(gs10)) 
(scatter p_any medianage [aw=1/se_any^2], msymbol (none) mlabel(zoteroref) mlabsize(tiny) mlabposition(0)  mlabcolor(black))
(line fitty medianage, lcolor(sienna)), 
xtitle("Median age of study sample (years)")
ytitle(" Prevalence (%)")
title("Any HPV")
xlab(20 30 40 50 60, nogrid)
ylab(0 20 40 60, nogrid)
yscale(range(0 60))
legend(order(1 "HIV negative" 2 "HIV positive" 3 "Unknown HIV status") rows(1) size(small))

;
#delimit cr
graph save metareg_age_any.gph, replace

metareg p_hr medianage , wsse(se_hr) graph
*metareg p_hr medianage , wsse(se_hr) permute(20000)
predict fitty_hr
 
local sq = char(178)
displ "`sq"'


local tau_hr= "e(tau2)"
local tau_hr : display %4.0f `tau_hr'
local tau_hr= "Tau`sq'  =`tau_hr'"
display "`tau_hr'"

local I_hr= "e(I2)*100"
local I_hr : display %2.0f `I_hr'
local I_hr= "I`sq'  =`I_hr'"
display "`I_hr'"

local R_hr= "((e(tau2_0)-e(tau2))/e(tau2_0))*100"
local R_hr : display %3.0f `R_hr'
local R_hr= "Adjusted R`sq'  =`R_hr'"
display "`R_hr'"

testparm medianage
local pvalue_hr= r(p)
local pvalue_hr : display %6.2f `pvalue_hr'
local pvalue_hr= "p=`pvalue_hr'"
display "`pvalue_hr'"



#delimit ;
twoway 
(scatter p_hr medianage [aw=1/se_any^2] if hiv==1, msymbol(O) mlcolor(gs5) mfcolor(gs15))
(scatter p_hr medianage [aw=1/se_hr^2]if hiv==0, msymbol (Oh) mlcolor(gs5)
text(59 20 "`tau_hr'", placement(e) size(vsmall))text(55 20 "`I_hr'", placement(e)size(vsmall)) text(52 20 "`R_hr'", placement(e)size(vsmall)) text(48 20 "`pvalue_hr'", placement(e)size(vsmall)))
(scatter p_hr medianage [aw=1/se_any^2], msymbol (none) mlabel(zoteroref) mlabsize(tiny) mlabposition(0)  mlabcolor(black))
(line fitty_hr medianage, lcolor(sienna)), 
xtitle("Median age of study sample (years)")
title("High-risk HPV")
ylab(0 20 40 60, nogrid)
ylab(, nogrid)
yscale(range(0 60))
xlab(20 30 40 50 60, nogrid)
legend(off)
;
graph save metareg_age_hr.gph, replace
;
*grc1leg does the same as graph combine arrays separately drawn graphs into one graph and shows a single common legend taken from one of the graphs.
#delimit ;
grc1leg metareg_age_any.gph metareg_age_hr.gph,  
cols(2)
legendfrom(metareg_age_any.gph)
position(6)
span
note("Bubbles are weighted in size by inverse of within-study variance." "Study reference represented by number within bubble")

;
graph save metareg_age.gph, replace
;
#delimit cr

*median age and strobe graphs stratfied by hiv
**********
*HIV NEG
***********

preserve
drop if hiv==1|hiv==2
metareg p_any medianage , wsse(se_any) graph
 /*e(N) =  16
               e(tau2) =  147.5250117938128
               e(df_m) =  1
                  e(Q) =  319.8413995765218
               e(df_Q) =  14
                 e(I2) =  .9562283055960349
               e(df_r) =  14
               e(q_KH) =  .9927421041897365
              e(remll) =  -47.31590190083314
            e(remll_c) =  -180.0150046243789
             e(chi2_c) =  265.3982054470915
             e(tau2_0) =  230.296639597105
                  e(F) =  8.78712632440479
*/

predict fit1
local sq = char(178)
displ "`sq"'


local tau_any= "e(tau2)"
local tau_any : display %4.0f `tau_any'
local tau_any= "Tau`sq'  =`tau_any'"
display "`tau_any'"

local I_any= "e(I2)*100"
local I_any : display %2.0f `I_any'
local I_any= "I`sq'  =`I_any'"
display "`I_any'"

local R_any= "((e(tau2_0)-e(tau2))/e(tau2_0))*100"
local R_any : display %3.0f `R_any'
local R_any= "Adjusted R`sq'  =`R_any'"
display "`R_any'"

testparm medianage
local pvalue_any= r(p)
local pvalue_any : display %4.2f `pvalue_any'
local pvalue_any= "p=`pvalue_any'"
display "`pvalue_any'"


#delimit ;
twoway (scatter p_any medianage [aw=1/se_any^2], msymbol (Oh) 
text(59 20 "`tau_any'", placement(e) size(vsmall))text(55 20 "`I_any'", placement(e)size(vsmall)) text(52 20 "`R_any'", placement(e)size(vsmall)) text(48 20 "`pvalue_any'", placement(e)size(vsmall))) 
(scatter p_any medianage [aw=1/se_any^2], msymbol (none) mlabel(zoteroref) mlabsize(vsmall) mlabposition(0)  mlabcolor(black))
(line fit1 medianage, lcolor(sienna)), 
legend(off)
xtitle("Median age of study sample (years)")
ytitle(" Prevalence (%)")
title("Any HPV")
xlab(20 30 40 50 60, nogrid)
ylab(0 20 40 60, nogrid)
yscale(range(0 60))
;
#delimit cr
graph save metareg_age_any.gph, replace

metareg p_hr medianage , wsse(se_hr) graph

local sq = char(178)
displ "`sq"'


local tau_hr= "e(tau2)"
local tau_hr : display %4.0f `tau_hr'
local tau_hr= "Tau`sq'  =`tau_hr'"
display "`tau_hr'"

local I_hr= "e(I2)*100"
local I_hr : display %2.0f `I_hr'
local I_hr= "I`sq'  =`I_hr'"
display "`I_hr'"

local R_hr= "((e(tau2_0)-e(tau2))/e(tau2_0))*100"
local R_hr : display %3.0f `R_hr'
local R_hr= "Adjusted R`sq'  =`R_hr'"
display "`R_hr'"

testparm medianage
local pvalue_hr= r(p)
local pvalue_hr : display %4.2f `pvalue_hr'
local pvalue_hr= "p=`pvalue_hr'"
display "`pvalue_hr'"
predict fit1_hr


#delimit ;
twoway (scatter p_hr medianage [aw=1/se_hr^2], msymbol (Oh) 
text(59 20 "`tau_hr'", placement(e)size(vsmall)) text(55 20 "`I_hr'", placement(e)size(vsmall)) text(52 20 "`R_hr'", placement(e) size(vsmall)) text(48 20 "`pvalue_hr'", placement(e) size(vsmall))) 
(scatter p_hr medianage [aw=1/se_any^2], msymbol (none) mlabel(zoteroref) mlabsize(vsmall) mlabposition(0) mlabcolor(black))
(line fit1_hr medianage, lcolor(sienna)), 
legend(off)
xtitle("Median age of study sample (years)")
 
title("High risk HPV")
ylab(0 20 40 60, nogrid)
yscale(range(0 60))
xlab(20 30 40 50 60, nogrid)

;
graph save metareg_age_hr.gph, replace
;
#delimit ;
graph combine metareg_age_any.gph metareg_age_hr.gph, 
title("HIV negative", size(small)) 
cols(2)
;
#delimit cr
graph save metareg_age_neg.gph, replace

restore

*****************************************************************************************************************************************
*HIV POS
*******************************************************************************************************************************************
preserve

drop if hiv==2|hiv==0
metareg p_any medianage , wsse(se_any) graph
 /*e(N) =  16
               e(tau2) =  147.5250117938128
               e(df_m) =  1
                  e(Q) =  319.8413995765218
               e(df_Q) =  14
                 e(I2) =  .9562283055960349
               e(df_r) =  14
               e(q_KH) =  .9927421041897365
              e(remll) =  -47.31590190083314
            e(remll_c) =  -180.0150046243789
             e(chi2_c) =  265.3982054470915
             e(tau2_0) =  230.296639597105
                  e(F) =  8.78712632440479
*/
predict fit2
local sq = char(178)
displ "`sq"'


local tau_any= "e(tau2)"
local tau_any : display %4.0f `tau_any'
local tau_any= "Tau`sq'  =`tau_any'"
display "`tau_any'"

local I_any= "e(I2)*100"
local I_any : display %2.0f `I_any'
local I_any= "I`sq'  =`I_any'"
display "`I_any'"

local R_any= "((e(tau2_0)-e(tau2))/e(tau2_0))*100"
local R_any : display %3.0f `R_any'
local R_any= "Adjusted R`sq'  =`R_any'"
display "`R_any'"

testparm medianage
local pvalue_any= r(p)
local pvalue_any : display %4.2f `pvalue_any'
local pvalue_any= "p=`pvalue_any'"
display "`pvalue_any'"



#delimit ;
twoway (scatter p_any medianage [aw=1/se_any^2], msymbol (Oh) 
text(59 20 "`tau_any'", placement(e)size(vsmall)) text(55 20 "`I_any'", placement(e) size(vsmall)) text(52 20 "`R_any'", placement(e) size(vsmall)) text(48 20 "`pvalue_any'", placement(e) size(vsmall))) 
(scatter p_any medianage [aw=1/se_any^2], msymbol (none) mlabel(zoteroref) mlabsize(vsmall) mlabposition(0) mlabcolor(black))
(line fit2 medianage, lcolor(sienna)), 
legend(off)
xtitle("Median age of study sample (years)")
ytitle(" Prevalence (%)")
 
ylab(, nogrid)
ylab(0 20 40 60, nogrid)
yscale(range(0 60))
xlab(20 30 40 50 60, nogrid)

;
#delimit cr
graph save metareg_age_any.gph, replace

metareg p_hr medianage , wsse(se_hr) graph

local sq = char(178)
displ "`sq"'


local tau_hr= "e(tau2)"
local tau_hr : display %4.0f `tau_hr'
local tau_hr= "Tau`sq'=`tau_hr'"
display "`tau_hr'"

local I_hr= "e(I2)*100"
local I_hr : display %2.0f `I_hr'
local I_hr= "I`sq'=`I_hr'"
display "`I_hr'"

local R_hr= "((e(tau2_0)-e(tau2))/e(tau2_0))*100"
local R_hr : display %3.0f `R_hr'
local R_hr= "Adjusted R`sq'=`R_hr'"
display "`R_hr'"

testparm medianage
local pvalue_hr= r(p)
local pvalue_hr : display %4.2f `pvalue_hr'
local pvalue_hr= "p=`pvalue_hr'"
display "`pvalue_hr'"
predict fit2_hr


#delimit ;
twoway (scatter p_hr medianage [aw=1/se_hr^2], msymbol (Oh) 
text(59 20 "`tau_hr'", placement(e)size(vsmall)) text(55 20 "`I_hr'", placement(e) size(vsmall)) text(52 20 "`R_hr'", placement(e) size(vsmall)) text(48 20 "`pvalue_hr'", placement(e) size(vsmall))) 
(scatter p_hr medianage [aw=1/se_any^2], msymbol (none) mlabel(zoteroref) mlabsize(vsmall) mlabposition(0) mlabcolor(black))
(line fit2_hr medianage, lcolor(sienna)), 
legend(off)
xtitle("Median age of study sample (years)")
 
 
ylab(0 20 40 60, nogrid)
yscale(range(0 60))
xlab(20 30 40 50 60, nogrid)

;
graph save metareg_age_hr.gph, replace
;
#delimit ;
graph combine metareg_age_any.gph metareg_age_hr.gph, 
title("HIV positive", size(small)) 
cols(2)

;
graph save metareg_age_pos.gph, replace
;
restore
;
***********************************
*GRAPH COMBINE
#delimit ;
graph combine metareg_age_neg.gph metareg_age_pos.gph  , 
 
cols(1)
note("Bubbles are weighted in size by inverse of within-study variance" "Study reference represented by number within bubble")
;

#delimit cr
graph save metareg_age_hiv.gph, replace

metabias p_any se_any, egger graph
metabias p_any se_any if hiv==1, egger graph

metabias p_any se_any if hiv==0, egger graph
metafunnel p_any se_any

metafunnel p_any se_any, by(hiv)
metafunnel p_any se_any if hiv==1
metafunnel p_any se_any if hiv==0



xi: metareg p_hr medianage , wsse(se_hr) 

xi: metareg p_hr i.oralspec , wsse(se_hr) 

*DO THIS ABOVE
*recode recruit 4=3
*recode oralspec 2=1 3=1 4=1 8=1 5=1 7=0 1=0 6=0
drop if hiv==2
xi:metareg p_any i.recruit, wsse(se_any)
xi: metareg p_any i.oralspec, wsse(se_any)
/*

. metareg logor cholreduc ihd2 ihd3, wsse(selogor)
> permute(5000, joint(ihd2 ihd3))
Monte Carlo permutation test for meta-regression
Moment-based estimate of between-study variance
Without Knapp & Hartung modification to standard errors
joint1 : ihd2 ihd3
P-values unadjusted and adjusted for multiple testing
Number of obs = 28
Permutations = 5000
P
logor Unadjusted Adjusted
cholreduc 0.009 0.028
ihd2 0.611 0.933
ihd3 0.907 0.999
joint1 0.883
largest Monte Carlo SE(P) = 0.0069
WARNING:
Monte Carlo methods use random numbers, so results may differ between runs.
Ensure you specify enough permutations to obtain the desired precision.
The p-value of 0.883 for the joint test of ihd2 and ihd3 indicates that there is very
little evidence that the log odds-ratio differs among these three categories of studies,
after adjusting for the degree of cholesterol reduction achieved in each study.
*/
xi:metareg p_any i.recruit, wsse(se_any) permute(20000,joint(_Irecruit_2 _Irecruit_3))
xi:metareg p_any i.oralspec, wsse(se_any) permute(20000)
metareg p_hr strobe, wsse(se_hr) permute(20000) 
metareg p_any strobe, wsse(se_any) permute(20000)

xi: metareg p_any medianage i.hiv, wsse(se_any) 
xi: metareg p_any medianage i.hiv, wsse(se_any) permute(20000,joint(_Ihiv_1 _Ihiv_2))
metareg p_any recruit hiv oralspec medianage strobe, wsse(se_any) permute(1000)
bysort hiv: metareg p_any medianage , wsse(se_any) graph
 metareg p_any medianage , wsse(se_any) graph
bysort hiv: metareg p_any strobe , wsse(se_any) graph

metareg p_any strobe , wsse(se_any) graph

metareg p_any strobe, wsse(se_any)
metareg p_any hiv, wsse(se_any)
metareg p_any recruit, wsse(se_any)

metareg p_hr recruit hiv oralspec medianage strobe, wsse(se_hr)
metareg p_hr recruit hiv oralspec medianage strobe, wsse(se_hr) permute(1000)
metareg p_hr medianage, wsse(se_hr)
metareg p_hr strobe, wsse(se_hr)
metareg p_hr hiv, wsse(se_hr)
metareg p_hr recruit, wsse(se_hr)

*HIV neg
preserve
drop if hiv==2|hiv==1
metareg p_any recruit oralspec medianage strobe, wsse(se_any) 
metareg p_any recruit oralspec medianage strobe, wsse(se_any) permute(1000)
metareg p_any medianage, wsse(se_any) graph
metareg p_any strobe, wsse(se_any)
metareg p_any recruit, wsse(se_any)

metareg p_hr recruit oralspec medianage strobe, wsse(se_hr) 
metareg p_hr recruit oralspec medianage strobe, wsse(se_hr) permute(1000)
metareg p_hr medianage, wsse(se_hr) graph
metareg p_hr strobe, wsse(se_hr)
metareg p_hr recruit, wsse(se_hr)
restore



*HIV pos
preserve
drop if hiv==2|hiv==0
metareg p_any recruit oralspec medianage strobe, wsse(se_any) 
metareg p_any recruit oralspec medianage strobe, wsse(se_any) permute(1000)
metareg p_any medianage, wsse(se_any) graph
metareg p_any strobe, wsse(se_any) graph
xi: metareg p_any i.recruit, wsse(se_any) 

metareg p_hr recruit oralspec medianage strobe, wsse(se_hr) 
metareg p_hr recruit oralspec medianage strobe, wsse(se_hr) permute(1000)
metareg p_hr medianage, wsse(se_hr) graph
metareg p_hr strobe, wsse(se_hr) graph
metareg p_hr recruit, wsse(se_hr) graph
restore
/*
metan p se_any  if hiv==0, lcols(study sample)  xtitle("prevlaence (%)", size(small)) xlabel(0,10,20,30,40,50,60,70) nulloff random nowt nobox subtitle("HIV negative", size(small))
graph save metan_oralany_neg.gph, replace

metan p se_any  if hiv==1, lcols(study sample)  xtitle("prevlaence (%)", size(small)) xlabel(0,10,20,30,40,50,60,70) nulloff random nowt nobox subtitle("HIV infected", size(small))
graph save metan_oralany_pos.gph, replace

#delimit ;
graph combine metan_oralany_neg.gph metan_oralany_pos.gph, 
title("oral HPV DNA prevalence in MSM", size(small)) 
cols(1)
;
*/
recode recruit 3=2 4=5
recode recruit 6=5

recode oralspec 8=5 2=5 7=1 4=5 3=5 6=1 
