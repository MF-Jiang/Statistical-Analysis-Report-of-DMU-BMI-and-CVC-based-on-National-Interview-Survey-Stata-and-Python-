* make sure there is no using cache in stata
clear all

* Please make sure adult22.csv is in the same folder as the script file
import delimited "./adult22.csv", case(preserve) 

* Clear invalid data to prevent subsequent operations from being affected
drop if SEX_A != 1 & SEX_A != 2
drop if AGEP_A == 97 | AGEP_A == 98 | AGEP_A == 99
drop if RACEALLP_A == 7 | RACEALLP_A == 8 | RACEALLP_A == 9
drop if HOUTENURE_A == 7 | HOUTENURE_A == 8 | HOUTENURE_A == 9
drop if FRJUICTP_A == 7 | FRJUICTP_A == 8 | FRJUICTP_A == 9
drop if COFFEENOTP_A == 7 | COFFEENOTP_A == 8 | COFFEENOTP_A == 9
drop if SALADTP_A == 7 | SALADTP_A == 8 | SALADTP_A == 9
drop if FRIESTP_A == 7 | FRIESTP_A == 8 | FRIESTP_A == 9
drop if BEANSTP_A == 7 | BEANSTP_A == 8 | BEANSTP_A == 9
drop if PIZZATP_A == 7 | PIZZATP_A == 8 | PIZZATP_A == 9
drop if OVEGTP_A == 7 | OVEGTP_A == 8 | OVEGTP_A == 9
drop if CHDEV_A == 7 | CHDEV_A == 8 | CHDEV_A == 9
drop if ANGEV_A == 7 | ANGEV_A == 8 | ANGEV_A == 9
drop if MIEV_A == 7 | MIEV_A == 8 | MIEV_A == 9
drop if STREV_A == 7 | STREV_A == 8 | STREV_A == 9

* label and define the variable "age"
gen age_group = .
replace age_group = 1 if AGEP_A >= 18 & AGEP_A <= 40
replace age_group = 2 if AGEP_A >= 41 & AGEP_A <= 60
replace age_group = 3 if AGEP_A >= 61 & AGEP_A <= 80
replace age_group = 4 if AGEP_A >= 81

label define age_group_lbl 1 "18-40" 2 "41-60" 3 "61-80" 4 "81+"
label values age_group age_group_lbl
label variable age_group "AGE" 

* label and define the variable "sex"
label define sex_lbl 1 "Male" 2 "Female"
label values SEX_A sex_lbl
label variable SEX_A "SEX"

* label and define the variable "race"
label define race_lbl 1 "White only" 2 "Black/African American only" 3 "Asian only" 4 "AIAN only" 5 "AIAN and any other group" 6 "Other single and multiple races"
label values RACEALLP_A race_lbl
label variable RACEALLP_A "RACE"

* label and define the variable "residence"
label define residence_lbl 1 "Owned or being bought" 2 "Rented" 3 "Other arrangement"
label values HOUTENURE_A residence_lbl
label variable HOUTENURE_A "RESIDENCE"

* label and define the variable of  "place of residence"
label define region_lbl 1 "Northeast" 2 "Midwest" 3 "South" 4 "West"
label values REGION region_lbl
label variable REGION "REGION" 

* label lifestyle
label variable FRJUICTP_A "Number of times drank pure fruit juice"
label variable COFFEENOTP_A "Number of times drank coffee or tea with sugar"
label variable SALADTP_A "Number of times eat salad"
label variable FRIESTP_A "Number of times eat fried potatoes"
label variable BEANSTP_A "Number of times eat beans"
label variable PIZZATP_A "Number of times eat pizza"
label variable OVEGTP_A "Number of times eat other vegetables"
label define period 0 "Never" 1 "Daily" 2 "Weekly" 3 "Monthly"
label values FRJUICTP_A COFFEENOTP_A SALADTP_A FRIESTP_A BEANSTP_A PIZZATP_A OVEGTP_A period

* label and define the disease variables
label variable CHDEV_A "Coronary Heart Disease"
label variable ANGEV_A "Angina"
label variable MIEV_A "Heart Attack"
label variable STREV_A "Stroke"
label define yesno 1 "Diagnosed" 2 "Undiagnosed"
label values CHDEV_A ANGEV_A MIEV_A STREV_A yesno


* make sure collect cache is clean
collect clear
sort AGEP_A

gen never_coffee = (CHDEV_A == 1)
egen never_coffee_prop = mean(never_coffee), by(AGEP_A)

gen never_friredp = (ANGEV_A == 1)
egen never_friredp_prop = mean(never_friredp), by(AGEP_A)

gen never_pizza = (MIEV_A == 1)
egen never_pizza_prop = mean(never_pizza), by(AGEP_A)

gen never_pizza2 = (STREV_A == 1)
egen never_pizza2_prop = mean(never_pizza2), by(AGEP_A)

twoway (line never_coffee_prop AGEP_A, lcolor(blue) lwidth(medium)) (line never_friredp_prop AGEP_A, lcolor(red) lwidth(medium)) (line never_pizza_prop AGEP_A, lcolor(green) lwidth(medium)) (line never_pizza2_prop AGEP_A, lcolor(black) lwidth(medium)), title("Percentage of different Age Groups") ///
     xtitle("Age") ytitle("Rate (%)") ///
     graphregion(margin(small)) ///
     xlabel(18 20 (5) 85) ///
     ylabel(0 "0%" 0.1 "10%" 0.2 "20%" 0.3 "30%", angle(0)) ///
     legend(label(1 "Coronary Heart Disease") label(2 "Angina") label(3 "Heart Attack") label(4 "Stroke"))

