clear
use "N:\Eking\Prevalence_study_data\Data_files\analcancer_meta.dta"

sort study
encode study, gen(study1)
gen hivart=hiv*art
recode hivart .=0 2=1 1=2 0=3
lab define hivart 3"HIV positive:pre-ART" 2"HIV positive:post-ART" 1"HIV positive:overall" 0"HIV negative"
lab values hivart hivart

encode country, gen(country1)
 
#delimit ;
twoway (scatter study1 rate , mlabel(country) mlabpos(12) mlabgap(0.2) mlabsize(tiny) by(hivart, colfirst cols(1) legend(off) subtitle(,size(vsmall))note("")noiytick noiyaxes imargin(zero) plotregion(color(white)  lstyle(none))  graphregion(color(white) lstyle(none))) ms(S) mcolor(black) xlab(0(20)160) ylab(1(1)8, labsize(small)tstyle(none)nogrid valuelabel angle(horizontal) noticks)graphregion(fcolor(white)))
(rcap lb ub study1, lcolor(black) by(hivart) horizontal graphregion(fcolor(white))),
graphregion(fcolor(white))
ytitle("")
xtitle("Incidence (per 100,000 person-years)", size(small))

;
