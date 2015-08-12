clear
cd "N:\Eking\Prevalence_study_data\Graphs"
use "N:\Eking\Prevalence_study_data\Data_files\analcancer_meta.dta"

sort study


encode country, gen(country1)
 
#delimit ;
twoway (scatter study1 rate ,  by(hivart, colfirst cols(1) legend(off) subtitle(,size(vsmall))note("")noiytick noiyaxes imargin(zero) plotregion(color(white)  lstyle(none))  graphregion(color(white) lstyle(none))) ms(S) mcolor(black) xlab(0(20)160) ylab(1(1)8, labsize(small)tstyle(none)nogrid valuelabel angle(horizontal) noticks)graphregion(fcolor(white)))
(rcap lb ub study1, lcolor(black) by(hivart) horizontal graphregion(fcolor(white))),
graphregion(fcolor(white))
ytitle("")
xtitle("Incidence (per 100,000 person-years)", size(small))
xsize(17.23)
ysize (12.5)
;
graph save testsize, replace
;
graph export "N:\Eking\Prevalence_study_data\Do_files\THESIS_METAANALYSES\analmeta.png", replace width(1500)
;
