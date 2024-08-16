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

* make sure collect cache is clean
collect clear

* make age-disease table

quietly:table (age_group)(CHDEV_A), statistic(frequency) statistic(percent, across(CHDEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_age)
quietly:table (age_group)(ANGEV_A), statistic(frequency) statistic(percent, across(ANGEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_age) append
quietly:table (age_group)(MIEV_A), statistic(frequency) statistic(percent, across(MIEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_age) append
quietly:table (age_group)(STREV_A), statistic(frequency) statistic(percent, across(STREV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_age) append

* make sex-disease table

quietly:table (SEX_A) (CHDEV_A), statistic(frequency) statistic(percent, across(CHDEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_sex)
quietly:table (SEX_A) (ANGEV_A), statistic(frequency) statistic(percent, across(ANGEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_sex) append
quietly:table (SEX_A) (MIEV_A), statistic(frequency) statistic(percent, across(MIEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_sex) append
quietly:table (SEX_A) (STREV_A), statistic(frequency) statistic(percent, across(STREV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_sex) append

* make race-disease table

quietly:table (RACEALLP_A) (CHDEV_A), statistic(frequency) statistic(percent, across(CHDEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_race) 
quietly:table (RACEALLP_A) (ANGEV_A), statistic(frequency) statistic(percent, across(ANGEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_race) append
quietly:table (RACEALLP_A) (MIEV_A), statistic(frequency) statistic(percent, across(MIEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_race) append
quietly:table (RACEALLP_A) (STREV_A), statistic(frequency) statistic(percent, across(STREV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_race) append

* make residence-disease table
quietly:table (HOUTENURE_A)(CHDEV_A), statistic(frequency) statistic(percent, across(CHDEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_residence) 
quietly:table (HOUTENURE_A)(ANGEV_A), statistic(frequency) statistic(percent, across(ANGEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_residence) append
quietly:table (HOUTENURE_A)(MIEV_A), statistic(frequency) statistic(percent, across(MIEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_residence) append
quietly:table (HOUTENURE_A)(STREV_A), statistic(frequency) statistic(percent, across(STREV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_residence) append

* make region-disease table
quietly:table (REGION)(CHDEV_A), statistic(frequency) statistic(percent, across(CHDEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_region) 
quietly:table (REGION)(ANGEV_A), statistic(frequency) statistic(percent, across(ANGEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_region) append
quietly:table (REGION)(MIEV_A), statistic(frequency) statistic(percent, across(MIEV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_region) append
quietly:table (REGION)(STREV_A), statistic(frequency) statistic(percent, across(STREV_A)) nototals  nformat(%9.0fc frequency)  sformat("(%s%%)" percent) style(table-1) name(table_region) append

* combine these tables
collect combine table_combined = table_age table_sex table_race table_residence table_region, layout(right) style(right)

* print it out on the terminal
collect layout (age_group#result SEX_A#result RACEALLP_A#result HOUTENURE_A#result REGION#result) (CHDEV_A ANGEV_A MIEV_A STREV_A) (table_combined)
