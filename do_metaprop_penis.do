capture log close
cd "C:\EllieDropboxCache\Dropbox\PhD\My research\THESIS\CHAPTERS\CH2_LIT_REVIEW"

set more off
clear
use "C:\EllieDropboxCache\Dropbox\PhD\My research\THESIS\CHAPTERS\CH2_LIT_REVIEW\penis.dta"

rename study Study
lab var Study ""
lab var sample "Sample size (n)"
lab define hiv 0 "HIV negative" 1"HIV positive" 2"Unknown HIV prevalence"
lab values hiv hiv

encode recruitment, gen(recruit)
encode Study, gen(study1)
encode region, gen(region1)
encode site, gen(site1)


//CHANGED TO DOING METAPROP BECAUSE USES BINOMIAL CONFIDENCE LIMITS NOT APPROXIMATION TO NORMAL
*SEE PREVIOUS VERSIONS OF THIS DO_FILE FOR METAN FUNCTIONS
#delimit ;
mymetaprop hpv16 sample if hiv==0, random by(site1) cimethod(exact) nowt
lcols(Study sample)
nooverall
xscale(r(0, 0.7))
xlabel(0,10)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
graph save hpv16.gph
;
#delimit ;
mymetaprop hpv16 sample, random by(recruit) cimethod(exact) nowt
lcols(Study sample)
nooverall
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60 , 70 , 80)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
#delimit ;
mymetaprop hpv16 sample, random by(region1) cimethod(exact) nowt
lcols(Study sample)
nooverall
xscale(r(0, 0.7))
xlabel(0,10,20, 30, 40, 50, 60 , 70 , 80)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 
#delimit ;
mymetaprop hpv18 sample, random by(hiv) cimethod(exact) nowt
lcols(Study sample)
nooverall
subtitle("HPV16", size(small))
xscale(r(0, 0.7))
xlabel(0,10,20, 30)
xtitle("Prevalence (%)", size(vsmall)) 
scheme(s1mono) plotregion(lstyle(none))
; 



*/
gen p_h16 = .
gen se_h16 = . 

gen p_h18 = .
gen se_h18 = . 



// get proportions and std errors 
forv i =1(1)12 {
capture noisily cii sample[`i'] hpv16[`i'], binomial
qui replace p_h16 = r(mean)*100 in `i'
qui replace se_h16 = r(se)*100 in `i'
} 
 
 


forv i =1(1)12 {
capture noisily cii sample[`i'] hpv18[`i'], binomial
qui replace p_h18 = r(mean)*100 in `i'
qui replace se_h18 = r(se)*100 in `i'
} 
  




**************************************************************************************************************
*REGRESSION & BUBBLE PLOTS
************************************************************************************************************

*HPV16
metareg p_h16 medianage , wsse(se_h16) graph
xi: metareg p_h16 i.hiv , wsse(se_h16) 




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
metareg p_h16 medianage , wsse(se_h16) graph
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
twoway (scatter p_h16 medianage [aw=1/se_h16^2] if hiv==0, msymbol(O) mlcolor(ltblue) mfcolor(ltblue) 
text(79 20 "`tau_any'", placement(e) size(vsmall))text(75 20 "`I_any'", placement(e)size(vsmall)) text(72 20 "`R_any'", placement(e)size(vsmall)) text(68 20 "`pvalue_any'", placement(e)size(vsmall))) 
(scatter p_h16 medianage [aw=1/se_h16^2] if hiv==1, msymbol(O) mlcolor(dkorange) mfcolor(dkorange))
(scatter p_h16 medianage [aw=1/se_h16^2] if hiv==2, msymbol(O) mlcolor(gs5) mfcolor(gs5)) 
(scatter p_h16 medianage [aw=1/se_h16^2], msymbol (none) mlabel(Study) mlabsize(vsmall) mlabposition(3) mlabgap(halftiny) mlabcolor(black))
(line fitty medianage, lcolor(sienna)), 
xtitle("Median age of study sample (years)")
ytitle(" Prevalence (%)")
xlab(20 30 40 50 60, nogrid)
ylab(0 20 40 60 80, nogrid)
yscale(range(0 60))
legend(order(1 "HIV negative" 2 "HIV positive" 3 "Unknown HIV status") rows(1) size(small))
plotregion(lstyle(none)) graphregion(color(gs16))

;
