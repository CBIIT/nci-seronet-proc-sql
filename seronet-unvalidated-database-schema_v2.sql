CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`CBC` (
  `CBC_ID` varchar(255) PRIMARY KEY,
  `CBC_Name` varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.Participant (
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Submission_CBC` varchar(255),
  `Age` int,
  `Race` varchar(255),
  `Ethnicity` varchar(255),
  `Gender` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- the rows in table `Clinical_Test`(Test_Name):
-- SARS_CoV_2_PCR_Test
-- SARS_CoV_2_Serology_IgG
-- SARS_CoV_2_Serology_IgM
-- CMV_Serology
-- CMV_Molecular
-- HepB_sAg
-- HepB_Serology
-- EBV_Molecular
-- EBV_Serology
-- HIV_Molecular
-- HIV_Serology
-- Seasonal_CoV_Molecular
-- Seasonal_CoV_Serology
-- need an "Other" test? Put a new row in this table.

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Clinical_Test` (
    `Test_Name` varchar(255) PRIMARY KEY,
    `NCIT_Code` varchar(255),
    `caDSR_Code` varchar(255)
);

-- the rows in table Infection (Infectious_Agent):
-- CMV
-- HepB
-- EBV
-- HIV
-- Seasonal_CoV
-- SARS_CoV_2

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Infection` (
    `Infectious_Agent` varchar(255) PRIMARY KEY,
    `NCIT_Code` varchar(255),
    `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Prior_Infection_Reported` (
    `Participant_Prior_Infection_ID` int AUTO_INCREMENT PRIMARY KEY,
    `Research_Participant_ID` varchar(255) NOT NULL,
    `Infectious_Agent` varchar(255) NOT NULL,
    `Submission_CBC` varchar(255) NOT NULL,
    `Date_of_Diagnosis` date,
    `Duration_of_Infection` int,
    `Date_of_Report` date,
    `Current_Infection` bool,
    `Duration_of_HAART_Therapy` int,
    `On_HAART_Therapy` bool,
    FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Infectious_Agent`) REFERENCES `Infection` (`Infectious_Agent`)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- the rows in table Biospecimen_Type (Biospecimen_Type)
-- Serum
-- Plasma
-- Venous_Whole_Blood
-- Dried_Blood_Spot
-- Nasal_Swab
-- Bronchoalveolar_Lavage
-- Sputum
-- other, add a row

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Biospecimen_Type` (
  `Biospecimen_Type` varchar(255) PRIMARY KEY,
  `NCIT_Code` varchar(255),
  `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Prior_Test_Result` (
  `Participant_Prior_Test_Result_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Test_Name` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255) NOT NULL,
  `Test_Result` varchar(255) NOT NULL, -- vocab
  `Test_Result_Provenance` varchar(255), -- vocab
  `Date_of_Sample_Collection` date NOT NULL,
  `Date_Test_Performed` date NOT NULL,
  `Sample_Type` varchar(255) NOT NULL,
  --  `Date_of_SARS_CoV_2_PCR_Test_Diagnosis` date, -- not here
  -- `Current_CMV_infection` varchar(25), -- not here
  -- `Duration_of_CMV_infection` int, -- not here
  -- `Current_HepB_infection` varchar(255) , -- not here
  -- `Duration_of_HepB_infection` int, -- not here
  -- `Current_EBV_infection` varchar(255) , -- not here
  -- `Duration_of_EBV_infection` int, -- not here
  -- `Current_HIV_infection` varchar(255) , -- not here
  -- `Duration_of_HIV_infection` int, -- not here
  -- `On_HAART_Therapy` varchar(255) , -- not here
  -- `Duration_of_HAART_Therapy` int, -- not here
  -- `Current_Seasonal_Coronavirus_infection` varchar(255) , -- not here
  -- `Duration_of_Seasonal_Coronavirus_infection` int, -- not here
  -- PRIMARY KEY (`Research_Participant_ID`), -- is not the primary key, one participant may have many tests
  FOREIGN KEY (`Test_Name`) REFERENCES `Clinical_Test` (`Test_Name`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Sample_Type`) REFERENCES `Biospecimen_Type` (`Biospecimen_Type`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Prior_Covid_Outcome` (
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Submission_CBC` varchar(255) ,
  `Is_Symptomatic` TINYINT(1),
  `Date_of_Symptom_Onset` date, -- associate with the symptom in symptom linking table
  `Symptoms_Resolved` TINYINT(1),
  `Date_of_Symptom_Resolution` date,
  `Covid_Disease_Severity` int, -- vocab table
  -- PRIMARY KEY (`Research_Participant_ID`), -- is not primary key (multiple outcomes for a single patient possible
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- rows in table `Symptom` (Symptom_Name):
-- Fever
-- Temperature
-- Chills
-- Rigors
-- Muscle
-- Runny
-- Sore_throat
-- New_Olfactory_and_Taste_Disorder
-- Headache
-- Fatigue
-- Cough
-- Wheezing
-- Shortness_of_breath
-- Difficulty_breathing
-- Chest_pain
-- Nausea_or_vomiting
-- Abdominal_pain
-- Diarrhea
-- Need an 'other' symptom? Make a new row in this table.

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Symptom` (
   `Symptom_Name` varchar(255) PRIMARY KEY,
   `NCIT_Code` varchar(255),
   `caDSR_Code` varchar(255)
   );

-- work in the link between individual symptomology and the outcome report
-- 
CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Covid_Symptom_Reported` (
  `Participant_Covid_Symptom_Reported_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Symptom_Name` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255)  NOT NULL,
  `Symptom_is_Present` TINYINT(1), -- if NULL, no data or NA

  -- PRIMARY KEY (`Research_Participant_ID`), -- this is a linking (many-to-many) table, each row is a unique entity
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Symptom_Name`) REFERENCES `Symptom` (`Symptom_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- the rows in table Comorbidity (Comorbidity_Name)
-- Diabetes_Mellitus
-- Hypertension
-- Severe_Obesity
-- Cardiovascular_Disease
-- Chronic_Renal_Disease
-- Chronic_Liver_Disease
-- Chronic_Lung_Disease
-- Immunosuppressive_conditions
-- Autoimmune_condition
-- Inflammatory_Disease
-- need an "Other" comorbidity? Put a new row in this table.

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Comorbidity` (
  `Comorbidity_Name` varchar(255) PRIMARY KEY,
  `NCIT_Code` varchar(255),
  `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Comorbidity_Reported` (
  `Participant_Comorbidity_Reported_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Submission_CBC` varchar(255),
  `Comorbidity_Name` varchar(255) NOT NULL,
  `Cormobidity_is_Present` bool,
-- PRIMARY KEY (`Research_Participant_ID`), -- not the primary key of this table
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Tube` (
  `Tube_ID` int AUTO_INCREMENT,
  `Tube_Type_Lot_Number` varchar(255)  NOT NULL,
  `Tube_Type_Catalog_Number` varchar(255)  NOT NULL,
  `Tube_Type` varchar(255),
  `Tube_Lot_Expiration_Date` date,
  PRIMARY KEY (`Tube_ID`,`Tube_Type_Lot_Number`, `Tube_Type_Catalog_Number`)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Biospecimen` (
  `Biospecimen_ID` varchar(255)  PRIMARY KEY,
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Test_Agreement` varchar(255), -- ?
  `Submission_CBC` varchar(255),
  `Shipping_ID` varchar(255),
  `Tube_ID` int,
  `Collection_Tube_Lot_Number` varchar(255),
  `Collection_Tube_Catalog_Number` varchar(255),
  `Biospecimen_Group` varchar(255),
  `Biospecimen_Type` varchar(255),
  `Initial_Volume_of_Biospecimen` int,
  `Biospecimen_Collection_Company_Clinic` varchar(255),
  `Biospecimen_Collector_Initials` varchar(10),
  `Date_of_Biospecimen_Collection` date,
  `Time_of_Biospecimen_Collection` time,
  `Biospecimen_Processing_Company_Clinic` varchar(255) ,
  `Biospecimen_Processor_Initials` varchar(3),
  `Date_of_Biospecimen_Processing` date,
  `Time_of_Biospecimen_Receipt` time, 
  `Storage_Start_Time_80_LN2_storage` time,
  `Storage_Time_at_2_8` float,
  `Storage_Start_Time_at_2_8` timestamp,
  `Storage_Start_Time_at_2_8_Initials` varchar(3),
  `Storage_End_Time_at_2_8` timestamp,
  `Storage_End_Time_at_2_8_Initials` varchar(3),
  `Centrifugation_Time` float,
  `RT_Serum_Clotting_Time` float,
  `Final_Concentration_of_Biospecimen` int,
  `Live_Cells_Hemocytometer_Count` int,
  `Total_Cells_Hemocytometer_Count` int,
  `Viability_Hemocytometer_Count` float,
  `Live_Cells_Automated_Count` int,
  `Total_Cells_Automated_Count` int,
  `Viability_Automated_Count` float,
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES CBC (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE

);

-- CREATE TABLE IF NOT EXISTS `Collection_Tube_Lot` (
--   Collection_Tube_Lot_Biospecimen_ID int AUTO_INCREMENT,
--   `Collection_Tube_Type_Lot_Number` varchar(255)  NOT NULL,
--   `Biospecimen_ID` varchar(255) ,
--   `Collection_Tube_Type` varchar(255) ,
--   `Collection_Tube_Type_Catalog_Number` varchar(255) ,
--   `Collection_Tube_Type_Expiration_Date` date,
--   PRIMARY KEY (`Collection_Tube_Type_Lot_Number`, `Biospecimen_ID`),
--   FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)
-- );

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Equipment` (
  `Equipment_ID` varchar(255)  PRIMARY KEY,
  `Equipment_Type` varchar(255),
  `Equipment_Calibration_Due_Date` date
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Biospecimen_Equipment` (
   `Biospecimen_Equipment_ID` int PRIMARY KEY AUTO_INCREMENT,
   `Biospecimen_ID` varchar(255) NOT NULL,
   `Equipment_ID` varchar(255) NOT NULL,
   FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (`Equipment_ID`) REFERENCES `Equipment` (`Equipment_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Reagent` (
  `Reagent_Name_Lot_ID` int AUTO_INCREMENT,
  `Reagent_Lot_Number` varchar(255),
  `Reagent_Name` varchar(255) NOT NULL,
  `Reagent_Catalog_Number` varchar(255),
  `Reagent_Expiration_Date` date,
  PRIMARY KEY (`Reagent_Name_Lot_ID`,`Reagent_Name`, `Reagent_Lot_Number`)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Reagent_Biospecimen` (
  `Reagent_Biospecimen_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Reagent_Name_Lot_ID` int NOT NULL,
  `Reagent_Name` varchar(255) NOT NULL,
  `Reagent_Lot_Number` varchar(255),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Reagent_Name_Lot_ID`) REFERENCES `Reagent` (`Reagent_Name_Lot_ID`) ON DELETE CASCADE ON UPDATE CASCADE
-- FOREIGN KEY (Reagent_Lot_Number) REFERENCES Reagent (Reagent_Lot_Number)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Consumable` (
  `Consumable_Name_Lot_ID` int AUTO_INCREMENT,
  `Consumable_Name` varchar(255) not null,
  `Consumable_Catalog_Number` varchar(255),
  `Consumable_Lot_Number` varchar(255),
  `Consumable_Expiration_Date` date,
  PRIMARY KEY (`Consumable_Name_Lot_ID`,`Consumable_Name`, `Consumable_Lot_Number`));

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Consumable_Biospecimen` (
  `Consumable_Biospecimen_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Biospecimen_ID` varchar(255) not null,
  `Consumable_Name_Lot_ID` int NOT NULL,
  `Consumable_Name` varchar(255) not null,
  `Consumable_Lot_Number` varchar(255),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Consumable_Name_Lot_ID`) REFERENCES `Consumable` (`Consumable_Name_Lot_ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Aliquot` (   -- adding shipping infomation (ID, Date, Reciept)
  `Aliquot_ID` varchar(255) PRIMARY KEY,
  `Biorepository_ID` varchar(255), -- ??
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255) NOT NULL,
  `Aliquot_Tube_Lot_Number` varchar(255),
  `Aliquot_Tube_Catalog_Number` varchar(255),
  `Aliquot_Volume` int NOT NULL,
  `Aliquot_Units` varchar(255)  NOT NULL,
  `Aliquot_Initials` varchar(3),
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,  
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`) ON DELETE CASCADE ON UPDATE CASCADE
-- FOREIGN KEY (Aliquot_Tube_Lot_Number) REFERENCES Tube (Tube_Lot_Number),
-- FOREIGN KEY (Aliquot_Tube_Catalog_Number) REFERENCES Tube (Tube_Catalog_Number)  
);
-- Assay table has two issues that need to be resolved. 
-- (1) Assay_ID can not be the primary key because one Assay_ID can has serval Target_Biospecimen_Type. I suggest we add Target_Biospecimen_Type in and make a new composition primary key, but we also need to consider that Target_Biospecimen_Type is also a foreign key.
-- (2) Assay table has columns(like Assay_Target, Assay_Target_Sub_Region, Assay_Antigen_Source) that are coming from another csv files, assay_target.csv. 
CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay` (
  `Assay_ID` varchar(255)  PRIMARY KEY,
  -- `Submission_CBC` varchar(255)  NOT NULL, -- table describes an assay, cbc submits an assay _result_
  `Technology_Type` varchar(255), -- vocab table?
  `Assay_Name` varchar(255)  UNIQUE NOT NULL,
  `Assay_Manufacturer` varchar(255)  NOT NULL,
  `EUA_Status` varchar(255), -- vocab table
  `Assay_Multiplicity` varchar(255), -- ??
  `Target_Organism` varchar(255) NOT NULL, -- vocab
  `Target_Biospecimen_Type` varchar(255) NOT NULL,
  `Assay_Control_Type` varchar(255), -- vocab
  `Postive_Control` varchar(255), -- vocab
  `Negative_Control` varchar(255), -- vocab
  `Calibration_Type` varchar(255), -- vocab
  `Calibrator_High_or_Positive` varchar(255), -- bool?
  `Calibrator_Low_or_Negative` varchar(255), -- bool?
  `Measurand_Antibody_Type` varchar(255), -- vocab
  `Assay_Result_Type` varchar(255), -- vocab
  `Assay_Result_Unit` varchar(255), -- vocab
  `Positive_Cut_Off_Threshold` varchar(255), -- string value??
  `Negative_Cut_Off_Ceiling` varchar(255), -- string value??
  `Cut_Off_Unit` varchar(255), -- vocab
  `N_true_positive` int,
  `N_true_negative` int,
  `N_false_positive` int,
  `N_false_negative` int,
  `Peformance_Statistics_Source` varchar(255), -- vocab
  `Assay_Target` varchar(255) NOT NULL, -- vocab
  `Assay_Target_Sub_Region` varchar(255), -- vocab
  `Assay_Antigen_Source` varchar(255),
  FOREIGN KEY (`Target_Biospecimen_Type`) REFERENCES `Biospecimen_Type` (`Biospecimen_Type`) ON DELETE CASCADE ON UPDATE CASCADE
  -- FOREIGN KEY (Submission_CBC) REFERENCES CBC (CBC_ID)
);

-- this table looks like more metadata specific to the assay (not an assay
-- run) - so merge it with Assay_Metadata:

-- CREATE TABLE IF NOT EXISTS `Assay_Target` (
--   `Assay_ID` varchar(255)  NOT NULL,
--   PRIMARY KEY (`Assay_ID`, `Assay_Target`),
--   FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`)
-- );

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Confirmatory_Assay_Result` (
  `Participant_Confirmatory_Test_Result_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255),
  `Assay_ID` varchar(255) NOT NULL,
  -- `Assay_Target` varchar(255)  NOT NULL, -- in the assay record now
  `Assay_Kit_Lot_Number` varchar(255),
  `Assay_Result` varchar(255),
  `Assay_Replicate` int, -- ??
  `Date_of_Assay_Run` date,
  `Assay_Operator_Initials` varchar(255),
  -- PRIMARY KEY (`Research_Participant_ID`, `Assay_ID`, `Assay_Target`), -- not the primary key; a participant may have a number of results based on the same asay
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay` (`Assay_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Submission` (
  `Submission_ID` varchar(255) PRIMARY KEY,
  `Submission_Time` datetime,
  `Submission_CBC` varchar(255),
  -- `Research_Participant_ID` varchar(255) , -- guaranteed that one submission won't contain many participants' data? Doubt it.
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
  -- FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Confirmatory_Clinical_Test` (
`Confirmatory_Clinical_Test_ID` int PRIMARY KEY AUTO_INCREMENT,
`Research_Participant_ID` varchar(255) NOT NULL,
`Assay_ID` varchar(255) NOT NULL,
`Test_Operator_Initials` varchar(255),
`Assay_Kit_Lot_Number` varchar(255),
`Date_of_Test` date,
`Time_of_Test` time,
`Assay_Target` varchar(255),
`Assay_Target_Sub_Region` varchar(255),
`Measurand_Antibody` varchar(255),
`Assay_Replicate` int(11),
`Sample_Type` varchar(255),
`Sample_Dilution` int(11),
`Interpretation` varchar(255),
`Derived_Result` float,
`Derived_Result_Units` varchar(255),
`Raw_Result` float,
`Raw_Result_Units` varchar(255),
`Positive_Control_Reading` float,
`Negative_Control_Reading` float,
FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`) ON DELETE CASCADE ON UPDATE CASCADE
-- FOREIGN KEY (Assay_ID) REFERENCES Assay (Assay_ID) ON DELETE CASCADE ON UPDATE CASCADE

);
