clear
import excel "N:\Eking\Dropbox\PhD\My research\THESIS\studies of incidence.xlsx", firstrow
encode HPV, gen (hpv)
encode Study, gen(study)

keep if hpv==2|hpv==3|hpv==5|hpv==6
#delimit ;
twoway (scatter Incidence Age if study==1, mcolor (navy) )
(rcap lb ub Age if study==1, lcolor(navy) graphregion(fcolor(white)))
(scatter Incidence Age if study==2, mcolor (maroon) )
(rcap lb ub Age if study==2, lcolor(maroon) graphregion(fcolor(white)))
(scatter Incidence Age if study==3, mcolor (forest_green) )
(rcap lb ub Age if study==3, lcolor(forest_green) graphregion(fcolor(white))), 
by(hpv)

;
