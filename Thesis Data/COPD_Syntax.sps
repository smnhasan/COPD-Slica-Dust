* Encoding: UTF-8.
USE ALL.
RECODE Age (LOWEST thru 40=0) (41 thru HIGHEST=1) INTO Age_Cat.
VALUE LABELS Age_Cat 0 "<=40" 1 ">40".
EXECUTE.

VALUE LABELS Sex 1 "Male" 2 "Female".

VALUE LABELS Average_income 1 "5-10K" 2 "10-15K" 3 "15-20K".

DATASET ACTIVATE DataSet1.
RECODE BMI (Lowest thru 25=1) (25.1 thru Highest=2) INTO BMI_cat.
VALUE LABELS BMI_cat 1 "Underweight" 2 "Normal" .
EXECUTE.

VALUE LABELS Smoking 1 "Yes" 2 "No".

VALUE LABELS Pack_Year_cat  1 "<=10 Packs per year" 2 ">10 Packs per year".

VALUE LABELS Biomass_fuel_cook 1 "Yes" 2 "No".

VALUE LABELS Length_Service 1 "5-10 Years" 2 "10-15 Years" 3 ">15 Years".

VALUE LABELS Cough 1 "Yes" 2 "No".

VALUE LABELS Sputum_Production 1 "Yes" 2 "No".

VALUE LABELS Pattern 1 "Obstruction(NR)" 2 "Obstruction(R)" 3 "Restriction" 4 "Normal".

VALUE LABELS GOLDSeverityGrade 1 "Mild (FEV1 >80%)" 2 "Moderate (FEV1 50-79%)" 3 "Severe (FEV1 30-49%)" 4 "Very Severe (FEV1 <30%)".

RECODE GOLDSeverityGrade (1 thru 2=0) (3 thru 4=1) (ELSE=SYSMIS) INTO Gold_Severity_Bin.
VALUE LABELS Gold_Severity_Bin 0 "Mild/Moderate" 1 "Severe/Very Severe".
EXECUTE.

CROSSTABS
  /TABLES=Age_Cat BY Pattern
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=Sex BY Pattern
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.


USE ALL.
COMPUTE filter_$=(Smoking = 1).
VARIABLE LABELS filter_$ 'Smoking = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

CROSSTABS
  /TABLES=Age_Cat BY Pattern
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=Sex BY Pattern
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

USE ALL.
COMPUTE filter_$=(Pattern = 1).
VARIABLE LABELS filter_$ 'Pattern = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

CROSSTABS
  /TABLES=Age_Cat BY GOLDSeverityGrade
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=Sex BY GOLDSeverityGrade
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.
