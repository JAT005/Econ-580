clear

cd ~/Documents/580/replication


ssc install estout, replace

estimates clear


import delimited replication_data.csv, clear varnames(1)


gen double agrilw_num = real(agrilw)
drop agrilw
rename agrilw_num agrilw

gen double roundwoodw_num = real(roundwoodw)
drop roundwoodw
rename roundwoodw_num rwoodw


gen kapw1 = kapw/1000
gen landuse_1 = landuse/100
drop landuse
rename landuse_1 landuse

gen woodint_1 = woodint/100
drop woodint
rename woodint_1 woodint


gen ln_mcap = ln(mcap)
gen ln_strade = ln(strade)
gen ln_lly = ln(lly)
gen ln_dc = ln(dc)
gen ln_secsch = ln(secsch)
gen ln_kapw1 = ln(kapw1)
gen ln_agrilw = ln(agrilw)
gen ln_rwoodw = ln(rwoodw)
gen ln_r = ln(r)


encode country, gen(country_id)
encode industry, gen(industry_id)


xtset country_id industry_id


xtreg ln_r c.finint#c.ln_mcap c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m1


xtreg ln_r c.finint#c.ln_strade c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m2


xtreg ln_r c.finint#c.ln_lly c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m3

xtreg ln_r c.finint#c.ln_dc c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m4


xtreg ln_r c.finint#c.conc c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m5


xtreg ln_r c.finint#c.margin c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m6


xtreg ln_r c.finint#c.acstan c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m7


xtreg ln_r c.finint#c.minority c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m8

xtreg ln_r c.finint#c.creditor c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m9

xtreg ln_r c.finint#c.govbor c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m10

xtreg ln_r c.finint#c.domsav c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m11

xtreg ln_r c.finint#c.govsav c.labcomus#c.ln_secsch c.capus#c.ln_kapw1 c.landuse#c.ln_agrilw c.woodint#c.ln_rwoodw i.country_id i.industry_id, robust
estimates store m12


xtreg ln_r c.finint#c.govbor  i.country_id i.industry_id, robust
estimates store m13

xtreg ln_r c.finint#c.domsav i.country_id i.industry_id, robust
estimates store m14

xtreg ln_r c.finint#c.govsav  i.country_id i.industry_id, robust
estimates store m15


* For LaTeX output:
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 using "mytable.tex", ///
    replace ///
    b(3) t(2) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    drop(*industry* *country* _cons) ///
    booktabs ///
    mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" "(7)" "(8)" "(9)") ///
    stats(r2_a N, fmt(3 0) labels("Adj R²" "N")) ///
    addnote("Robust t-values in parentheses" ///
            "*** p<0.01, ** p<0.05, * p<0.1")
			
esttab m10 m11 m12 using "extension.tex", ///
    replace ///
    b(3) t(2) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    drop(*industry* *country* _cons) ///
    booktabs ///
    mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" "(7)" "(8)" "(9)") ///
    stats(r2_a N, fmt(3 0) labels("Adj R²" "N")) ///
    addnote("Robust t-values in parentheses" ///
            "*** p<0.01, ** p<0.05, * p<0.1")
			
esttab m13 m14 m15 using "extensionbasic.tex", ///
    replace ///
    b(3) t(2) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    drop(*industry* *country* _cons) ///
    booktabs ///
    mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" "(7)" "(8)" "(9)") ///
    stats(r2_a N, fmt(3 0) labels("Adj R²" "N")) ///
    addnote("Robust t-values in parentheses" ///
            "*** p<0.01, ** p<0.05, * p<0.1")
			