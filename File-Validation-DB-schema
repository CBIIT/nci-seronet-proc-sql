#drop table if exists `seronetdb-prevalidated`.`Seronet_CBC_ID`;
#CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Seronet_CBC_ID` (
#	`Org_ID` int primary key not null,
#    `Institution` varchar(255));

drop table if exists `seronetdb-prevalidated`.`Consumable`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Consumable` (
`Biospecimen_ID` varchar(255) not null,
`Consumable_Name` varchar(255) not null,
`Consumable_Catalog_Number` varchar(255),
`Consumable_Lot_Number` varchar(255),
`Consumable_Expiration_Date` date,
PRIMARY KEY (`Biospecimen_ID`,`Consumable_Name`),
FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`));

drop table if exists `seronetdb-prevalidated`.`Demographic_Data`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Demographic_Data` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Age` int,
  `Race` varchar(255),
  `Ethnicity` varchar(255),
  `Gender` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`));

drop table if exists `seronetdb-prevalidated`.`Prior_Test_Result`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Prior_Test_Result` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `SARS_CoV_2_PCR_Test_Result` varchar(255),
  `SARS_CoV_2_PCR_Test_Result_Provenance` varchar(255),
  `Date_of_SARS_CoV_2_PCR_sample_collection` date,
  `Date_of_SARS_CoV_2_PCR_Test_Diagnosis` date,
  `CMV_Serology_Test_Result` varchar(255),
  `CMV_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_CMV_Serology_Test` date,
  `CMV_Molecular_Test_Result` varchar(255),
  `CMV_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_CMV_Molecular_Test` date,
  `Current_CMV_infection` varchar(25),
  `Duration_of_CMV_infection` int,
  `HepB_sAg_Test_Result` varchar(255),
  `HepB_sAg_Test_Result_Provenance` varchar(255),
  `Date_of_HepB_sAg_Test` date,
  `HepB_Serology_Test_Result` varchar(255),
  `HepB_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_HepB_Serology_Test` date,
  `Current_HepB_infection` varchar(255),
  `Duration_of_HepB_infection` int,
  `EBV_Molecular_Test_Result` varchar(255),
  `EBV_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_EBV_Molecular_Test` date,
  `EBV_Serology_Test_Result` varchar(255),
  `EBV_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_EBV_Serology_Test` date,
  `Current_EBV_infection` varchar(255),
  `Duration_of_EBV_infection` int,
  `HIV_Molecular_Test_Result` varchar(255),
  `HIV_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_HIV_Molecular_Test` date,
  `HIV_Serology_Test_Result` varchar(255),
  `HIV_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_HIV_Serology_Test` date,
  `Current_HIV_infection` varchar(255),
  `Duration_of_HIV_infection` int,
  `On_HAART_Therapy` varchar(255),
  `Duration_of_HAART_Therapy` int,
  `Seasonal_Coronavirus_Molecular_Result` varchar(255),
  `Seasonal_Coronavirus_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_Seasonal_Coronavirus_Molecular_Test` date,
  `Seasonal_Coronavirus_Serology_Result` varchar(255),
  `Seasonal_Coronavirus_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_Seasonal_Coronavirus_Serology_Test` date,
  `Current_Seasonal_Coronavirus_infection` varchar(255),
  `Duration_of_Seasonal_Coronavirus_infection` int,
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`));

drop table if exists `seronetdb-prevalidated`.`Prior_Covid_Outcome`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Prior_Covid_Outcome` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Is_Symptomatic` varchar(25),
  `Date_of_Symptom_Onset` date,
  `Symptoms_Resolved` varchar(25),
  `Date_of_Symptom_Resolution` date,
  `Covid_Disease_Severity` int,
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`));

drop table if exists `seronetdb-prevalidated`.`Covid_Symptom`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Covid_Symptom` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Fever` varchar(25),
  `Temperature_over_100` varchar(25),
  `Chills` varchar(25),
  `Rigors` varchar(25),
  `Muscle_ache` varchar(25),
  `Runny_nose` varchar(25),
  `Sore_throat` varchar(25),
  `New_Olfactory_and_Taste_Disorder` varchar(25),
  `Headache` varchar(25),
  `Fatigue` varchar(25),
  `Cough` varchar(25),
  `Wheezing` varchar(25),
  `Shortness_of_breath` varchar(25),
  `Difficulty_breathing` varchar(25),
  `Chest_pain` varchar(25),
  `Nausea_or_vomiting` varchar(25),
  `Abdominal_pain` varchar(25),
  `Diarrhea` varchar(25),
  `Other_Symptom` varchar(25),
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`));

drop table if exists `seronetdb-prevalidated`.`Comorbidity`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Comorbidity` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Diabetes_Mellitus` varchar(25),
  `Hypertension` varchar(25),
  `Severe_Obesity` varchar(25),
  `Cardiovascular_Disease` varchar(25),
  `Chronic_Renal_Disease` varchar(25),
  `Chronic_Liver_Disease` varchar(25),
  `Chronic_Lung_Disease` varchar(25),
  `Immunosuppressive_conditions` varchar(25),
  `Autoimmune_condition` varchar(25),
  `Inflammatory_Disease` varchar(25),
  `Other_Comorbidity` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`));

drop table if exists `seronetdb-prevalidated`.`Biospecimen`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Biospecimen` (
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Research_Participant_ID` varchar(255),
  `Test_Agreement` varchar(255),
  `Submission_CBC` varchar(255),
  `Shipping_ID` varchar(255),
  `Biospecimen_Group` varchar(255),
  `Biospecimen_Type` varchar(255),
  `Initial_Volume_of_Biospecimen` float,
  `Biospecimen_Collection_Company_Clinic` varchar(255),
  `Biospecimen_Collector_Initials` varchar(3),
  `Date_of_Biospecimen_Collection` Date,
  `Time_of_Biospecimen_Collection` time,
  `Biospecimen_Processing_Company_Clinic` varchar(255),
  `Biospecimen_Processor_Initials` varchar(3),
  `Date_of_Biospecimen_Processing` Date,
  `Time_of_Biospecimen_Receipt` time,
  `Storage_Start_Time_80_LN2_storage` datetime,
  `Storage_Time_at_2_8` float,
  `Storage_Start_Time_at_2_8` datetime,
  `Storage_Start_Time_at_2_8_Initials` varchar(3),
  `Storage_End_Time_at_2_8` datetime,
  `Storage_End_Time_at_2_8_Initials` varchar(3),
  `Centrifugation_Time` float,
  `RT_Serum_Clotting_Time` float,
  `Final_Concentration_of_Biospecimen` float,
  `Live_Cells_Hemocytometer_Count` float,
  `Total_Cells_Hemocytometer_Count` float,
  `Viability_Hemocytometer_Count` float,
  `Live_Cells_Automated_Count` float,
  `Total_Cells_Automated_Count` float,
  `Viability_Automated_Count` float,
  PRIMARY KEY (`Biospecimen_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`));

drop table if exists `seronetdb-prevalidated`.`Collection_Tube`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Collection_Tube` (
  `Collection_Tube_Type_Lot_Number` varchar(255) NOT NULL,
  `Biospecimen_ID` varchar(255),
  `Collection_Tube_Type` varchar(255),
  `Collection_Tube_Type_Catalog_Number` varchar(255),
  `Collection_Tube_Type_Expiration_Date` date,
  PRIMARY KEY (`Collection_Tube_Type_Lot_Number`, `Biospecimen_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`));

drop table if exists `seronetdb-prevalidated`.`Equipment`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Equipment` (
  `Equipment_ID` varchar(255) NOT NULL,
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Equipment_Type` varchar(255),
  `Equipment_Calibration_Due_Date` date,
  PRIMARY KEY (`Equipment_ID`, `Biospecimen_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`));

drop table if exists `seronetdb-prevalidated`.`Reagent`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Reagent` (
  `Reagent_Lot_Number` varchar(255) NOT NULL,
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Reagent_Name` varchar(255),
  `Reagent_Catalog_Number` varchar(255),
  `Reagent_Expiration_Date` date,
  PRIMARY KEY (`Reagent_Lot_Number`, `Biospecimen_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`));

drop table if exists `seronetdb-prevalidated`.`Aliquot`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Aliquot` (
  `Aliquot_ID` varchar(255) NOT NULL,
  `Biorepository_ID` varchar(255),
  `Biospecimen_ID` varchar(255),
  `Submission_CBC` varchar(255),
  `Aliquot_Volume` int,
  `Aliquot_Units` varchar(255),
  `Aliquot_Initials` varchar(3),
  PRIMARY KEY (`Aliquot_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`));

drop table if exists `seronetdb-prevalidated`.`Aliquot_Tube`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Aliquot_Tube` (
  `Aliquot_Tube_Type_Lot_Number` varchar(255) NOT NULL,
  `Aliquot_Tube_Type` varchar(255),
  `Aliquot_Tube_Type_Catalog_Number` varchar(255),
  `Aliquot_Tube_Type_Expiration_Date` date,
  `Aliquot_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`Aliquot_Tube_Type_Lot_Number`, `Aliquot_ID`),
  FOREIGN KEY (`Aliquot_ID`) REFERENCES `Aliquot` (`Aliquot_ID`));

drop table if exists `seronetdb-prevalidated`.`Assay_Metadata`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Assay_Metadata` (
  `Assay_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Technology_Type` varchar(255),
  `Assay_Name` varchar(255),
  `Assay_Manufacturer` varchar(255),
  `EUA_Status` varchar(255),
  `Assay_Multiplicity` varchar(255),
  `Target_Organism` varchar(255),
  `Target_biospecimen_is_Serum` boolean,
  `Target_biospecimen_is_Plasma` boolean,
  `Target_biospecimen_is_Venous_Whole_Blood` boolean,
  `Target_biospecimen_is_Dried_Blood_Spot` boolean,
  `Target_biospecimen_is_Nasal_Swab` boolean,
  `Target_biospecimen_is_Bronchoalveolar_Lavage` boolean,
  `Target_biospecimen_is_Sputum` boolean,
  `Assay_Control_Type` varchar(255),
  `Postive_Control` varchar(255),
  `Negative_Control` varchar(255),
  `Calibration_Type` varchar(255),
  `Calibrator_High_or_Positive` varchar(255),
  `Calibrator_Low_or_Negative` varchar(255),
  `Measurand_Antibody_Type` varchar(255),
  `Assay_Result_Type` varchar(255),
  `Assay_Result_Unit` varchar(255),
  `Positive_Cut_Off_Threshold` varchar(255),
  `Negative_Cut_Off_Ceiling` varchar(255),
  `Cut_Off_Unit` varchar(255),
  `N_true_positive` int,
  `N_true_negative` int,
  `N_false_positive` int,
  `N_false_negative` int,
  `Peformance_Statistics_Source` varchar(255),
  PRIMARY KEY (`Assay_ID`));

drop table if exists `seronetdb-prevalidated`.`Assay_Target`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Assay_Target` (
  `Assay_ID` varchar(255) NOT NULL,
  `Assay_Target` varchar(255) NOT NULL,
  `Assay_Target_Sub_Region` varchar(255),
  `Assay_Antigen_Source` varchar(255),
  PRIMARY KEY (`Assay_ID`, `Assay_Target`),
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`));

drop table if exists `seronetdb-prevalidated`.`Confirmatory_Test_Result`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Confirmatory_Test_Result` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Assay_ID` varchar(255) NOT NULL,
  `Assay_Target` varchar(255) NOT NULL,
  `Assay_Kit_Lot_Number` varchar(255),
  `Assay_Result` varchar(255),
  `Assay_Replicate` int,
  `Date_of_Test` date,
  `Test_Operator_Initials` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`, `Assay_ID`, `Assay_Target`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`),
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Target` (`Assay_ID`));

drop table if exists `seronetdb-prevalidated`.`Submission_MetaData`;
CREATE TABLE IF NOT EXISTS `seronetdb-prevalidated`.`Submission_MetaData` (
  `Submission_ID` int not null  Auto_Increment,
  `Submission_time` datetime,
  `Submission_CBC` varchar(255),
  `Research_Participant_ID` varchar(255),
   PRIMARY KEY (`Submission_ID`),
   FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`))
   AUTO_INCREMENT = 100;
