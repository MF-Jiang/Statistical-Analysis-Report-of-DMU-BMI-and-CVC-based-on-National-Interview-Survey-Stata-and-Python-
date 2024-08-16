* make sure there is no using cache in stata
clear all

* Please make sure adult22.csv is in the same folder as the script file
import delimited "./adult22.csv", case(preserve) 

* Clear invalid data to prevent subsequent operations from being affected
drop if SEX_A != 1 & SEX_A != 2
drop if AGEP_A == 97 | AGEP_A == 98 | AGEP_A == 99
drop if RACEALLP_A == 7 | RACEALLP_A == 8 | RACEALLP_A == 9
drop if HOUTENURE_A == 7 | HOUTENURE_A == 8 | HOUTENURE_A == 9

drop if CHDEV_A == 7 | CHDEV_A == 8 | CHDEV_A == 9
drop if ANGEV_A == 7 | ANGEV_A == 8 | ANGEV_A == 9
drop if MIEV_A == 7 | MIEV_A == 8 | MIEV_A == 9
drop if STREV_A == 7 | STREV_A == 8 | STREV_A == 9

drop if BMICAT_A == 9 

drop if FRJUICTP_A == 7 | FRJUICTP_A == 8 | FRJUICTP_A == 9
drop if COFFEENOTP_A == 7 | COFFEENOTP_A == 8 | COFFEENOTP_A == 9
drop if SALADTP_A == 7 | SALADTP_A == 8 | SALADTP_A == 9
drop if FRIESTP_A == 7 | FRIESTP_A == 8 | FRIESTP_A == 9
drop if BEANSTP_A == 7 | BEANSTP_A == 8 | BEANSTP_A == 9
drop if PIZZATP_A == 7 | PIZZATP_A == 8 | PIZZATP_A == 9
drop if OVEGTP_A == 7 | OVEGTP_A == 8 | OVEGTP_A == 9

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

* label and define the disease variables
label variable CHDEV_A "Coronary Heart Disease"
label variable ANGEV_A "Angina"
label variable MIEV_A "Heart Attack"
label variable STREV_A "Stroke"
label define yesno 1 "Diagnosed" 2 "Undiagnosed"
label values CHDEV_A ANGEV_A MIEV_A STREV_A yesno

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

* label BMI
label variable BMICAT_A "BMI"
label define bmitype 1 "Underweight" 2 "Healthy weight" 3 "Overweight" 4 "Obese"
label values BMICAT_A bmitype

* make sure collect cache is clean
collect clear


// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(CHDEV_A),statistic(percent, across(CHDEV_A)) nototals nformat(%9.0fc percent) sformat("(%s%%)" percent)  name(table_Eat)
// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(ANGEV_A), statistic(percent, across(ANGEV_A)) nototals nformat(%9.0fc percent) sformat("(%s%%)" percent) name(table_Eat) append
// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(MIEV_A), statistic(percent, across(MIEV_A)) nototals nformat(%9.0fc percent) sformat("(%s%%)" percent) name(table_Eat) append
// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(STREV_A), statistic(percent, across(STREV_A)) nototals nformat(%9.0fc percent) sformat("(%s%%)" percent) name(table_Eat) append

// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(BMICAT_A),statistic(percent, across(BMICAT_A)) nototals nformat(%9.0fc percent) sformat("(%s%%)" percent)  name(table_Eat)

// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(CHDEV_A),statistic(frequency) nototals nformat(%9.0fc percent) sformat("(%s%%)" frequency)  name(table_Eat)
// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(ANGEV_A), statistic(frequency) nototals nformat(%9.0fc percent) sformat("(%s%%)" frequency) name(table_Eat) append
// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(MIEV_A), statistic(frequency) nototals nformat(%9.0fc percent) sformat("(%s%%)" frequency) name(table_Eat) append
// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(STREV_A), statistic(frequency) nototals nformat(%9.0fc percent) sformat("(%s%%)" frequency) name(table_Eat) append

// quietly:table (OVEGTP_A PIZZATP_A FRIESTP_A)(BMICAT_A),statistic(frequency) nototals nformat(%9.0fc percent) sformat("(%s%%)" frequency)  name(table_Eat)
//
//
// collect layout ((OVEGTP_A)#(PIZZATP_A)#(FRIESTP_A)) (BMICAT_A)


gen CHDEV_A_B = (CHDEV_A==1)
gen ANGEV_A_B = (ANGEV_A==1)
gen MIEV_A_B = (MIEV_A==1)
gen STREV_A_B = (STREV_A==1)

label variable CHDEV_A_B "Coronary Heart Disease"
label variable ANGEV_A_B "Angina"
label variable MIEV_A_B "Heart Attack"
label variable STREV_A_B "Stroke"

label define period2 0 "Never" 3 "Daily" 2 "Weekly" 1 "Monthly"

gen BMICAT_A_R = .
replace BMICAT_A_R = 0 if BMICAT_A == 1
replace BMICAT_A_R = 1 if BMICAT_A == 2
replace BMICAT_A_R = 2 if BMICAT_A == 3
replace BMICAT_A_R = 3 if BMICAT_A == 4

gen FRJUICTP_A_R = .
replace FRJUICTP_A_R = 0 if FRJUICTP_A == 0
replace FRJUICTP_A_R = 1 if FRJUICTP_A == 3
replace FRJUICTP_A_R = 2 if FRJUICTP_A == 2
replace FRJUICTP_A_R = 3 if FRJUICTP_A == 1

gen COFFEENOTP_A_R = .
replace COFFEENOTP_A_R = 0 if COFFEENOTP_A == 0
replace COFFEENOTP_A_R = 1 if COFFEENOTP_A == 3
replace COFFEENOTP_A_R = 2 if COFFEENOTP_A == 2
replace COFFEENOTP_A_R = 3 if COFFEENOTP_A == 1

gen SALADTP_A_R = .
replace SALADTP_A_R = 0 if SALADTP_A == 0
replace SALADTP_A_R = 1 if SALADTP_A == 3
replace SALADTP_A_R = 2 if SALADTP_A == 2
replace SALADTP_A_R = 3 if SALADTP_A == 1

gen FRIESTP_A_R = .
replace FRIESTP_A_R = 0 if FRIESTP_A == 0
replace FRIESTP_A_R = 1 if FRIESTP_A == 3
replace FRIESTP_A_R = 2 if FRIESTP_A == 2
replace FRIESTP_A_R = 3 if FRIESTP_A == 1

gen BEANSTP_A_R = .
replace BEANSTP_A_R = 0 if BEANSTP_A == 0
replace BEANSTP_A_R = 1 if BEANSTP_A == 3
replace BEANSTP_A_R = 2 if BEANSTP_A == 2
replace BEANSTP_A_R = 3 if BEANSTP_A == 1

gen PIZZATP_A_R = .
replace PIZZATP_A_R = 0 if PIZZATP_A == 0
replace PIZZATP_A_R = 1 if PIZZATP_A == 3
replace PIZZATP_A_R = 2 if PIZZATP_A == 2
replace PIZZATP_A_R = 3 if PIZZATP_A == 1

gen OVEGTP_A_R = .
replace OVEGTP_A_R = 0 if OVEGTP_A == 0
replace OVEGTP_A_R = 1 if OVEGTP_A == 3
replace OVEGTP_A_R = 2 if OVEGTP_A == 2
replace OVEGTP_A_R = 3 if OVEGTP_A == 1

label variable FRJUICTP_A_R "Number of times drank pure fruit juice"
label variable COFFEENOTP_A_R "Number of times drank coffee or tea with sugar"
label variable SALADTP_A_R "Number of times eat salad"
label variable FRIESTP_A_R "Number of times eat fried potatoes"
label variable BEANSTP_A_R "Number of times eat beans"
label variable PIZZATP_A_R "Number of times eat pizza"
label variable OVEGTP_A_R "Number of times eat other vegetables"

label values FRJUICTP_A_R COFFEENOTP_A_R SALADTP_A_R FRIESTP_A_R BEANSTP_A_R PIZZATP_A_R OVEGTP_A_R period2

// logit CHDEV_A_B FRJUICTP_A_R COFFEENOTP_A_R SALADTP_A_R FRIESTP_A_R BEANSTP_A_R PIZZATP_A_R OVEGTP_A_R
//
// logit ANGEV_A_B FRJUICTP_A_R COFFEENOTP_A_R SALADTP_A_R FRIESTP_A_R BEANSTP_A_R PIZZATP_A_R OVEGTP_A_R
//
// logit MIEV_A_B FRJUICTP_A_R COFFEENOTP_A_R SALADTP_A_R FRIESTP_A_R BEANSTP_A_R PIZZATP_A_R OVEGTP_A_R
//
// logit STREV_A_B FRJUICTP_A_R COFFEENOTP_A_R SALADTP_A_R FRIESTP_A_R BEANSTP_A_R PIZZATP_A_R OVEGTP_A_R

ologit BMICAT_A FRJUICTP_A_R COFFEENOTP_A_R SALADTP_A_R FRIESTP_A_R BEANSTP_A_R PIZZATP_A_R OVEGTP_A_R