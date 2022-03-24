CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`CBC` (
  `CBC_ID` varchar(255) PRIMARY KEY,
  `CBC_Name` varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Submission` (
  `Submission_Index` int,
  `Submission_CBC_Name` varchar(255),
  `Submission_CBC_ID` varchar(255),
  `Submission_Time` datetime,
  `Submission_File_Name` varchar(255),
  `Submission_S3_Path` varchar(255),
  `Date_Submission_Validated` datetime,
  `Submission_Intent` varchar(255),
  primary key(`Submission_Index`, `Submission_S3_Path`), 
  FOREIGN KEY (`Submission_CBC_ID`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.Participant (
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Submission_CBC` varchar(255),
  `Submission_Index` int,
  `Age` float,
  `Race` varchar(255),
  `Ethnicity` varchar(255),
  `Gender` varchar(255),
  `Participant_Comments` varchar(1000),
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_Index`) REFERENCES `Submission` (`Submission_Index`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Clinical_Test` (
    `Test_Name` varchar(255) PRIMARY KEY,
    `NCIT_Code` varchar(255),
    `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Infection` (
    `Infectious_Agent` varchar(255) PRIMARY KEY,
    `NCIT_Code` varchar(255),
    `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Prior_SARS_CoV2_PCR` (
	`Research_Participant_ID` varchar(255) primary key,
	`Submission_CBC` varchar(255) NOT NULL,
    `Test_Result` varchar(255) NOT NULL, -- vocab
	`Test_Result_Provenance` varchar(255), -- vocab
-- 	`Date_of_Sample_Collection` date,
--  `Date_of_Diagnosis` date
    `Post_Sample_Collection_Duration` int, -- varchar(255),
	`Sample_Collection_Year` int, -- varchar(255),
	`Post_Test_Diagnosis_Duration` int, -- varchar(255),
	`Test_Diagnosis_Year` int, -- varchar(255)
    `Participant_Prior_SARS_CoV2_PCR_Comments` varchar(1000)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Prior_Infection_Reported` (
    `Research_Participant_ID` varchar(50) NOT NULL,
    `Infectious_Agent` varchar(255) NOT NULL,
    `Submission_CBC` varchar(255) NOT NULL,
 --   `Date_of_Diagnosis` date,  	-- only applicable to SARS-CoV-2
    `Current_Infection` varchar(255),
    `Duration_of_Infection` int,
    `Duration_of_Infection_Unit` varchar(255),
    -- `Date_of_Report` date,
    primary key( `Research_Participant_ID`, `Infectious_Agent`),
    FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Infectious_Agent`) REFERENCES `Infection` (`Infectious_Agent`)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Biospecimen_Type` (
  `Biospecimen_Type` varchar(255) PRIMARY KEY,
  `NCIT_Code` varchar(255),
  `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Prior_Test_Result` (  -- non SARS-CoV-2 priors
  `Research_Participant_ID` varchar(50) NOT NULL,
  `Test_Name` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255) NOT NULL,
  `Test_Result` varchar(255) NOT NULL, -- vocab
  `Test_Result_Provenance` varchar(255), -- vocab
  `Post_Test_Duration` varchar(255), -- vocab
  `Post_Duration_Unit` varchar(255), -- vocab
  `Test_Year` varchar(255), -- vocab
  primary key(`Research_Participant_ID`,  `Test_Name`),
  -- `Date_of_Sample_Collection` date, -- only applicable to SARS CoV-2
  -- `Date_Test_Performed` date,  -- date of test
  FOREIGN KEY (`Test_Name`) REFERENCES `Clinical_Test` (`Test_Name`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Prior_Covid_Outcome` (
  `Research_Participant_ID` varchar(255)  NOT NULL,
  `Submission_CBC` varchar(255) ,
  `Is_Symptomatic` varchar(255),   -- TINYINT(1), can be unknown or N/A
--   `Date_of_Symptom_Onset` date, -- associate with the symptom in symptom linking table
--   `Date_of_Symptom_Resolution` date,
  `Post_Symptom_Onset_Duration` varchar(255),
  `Symptom_Onset_Year` varchar(255),
  `Symptoms_Resolved` varchar(255),   -- TINYINT(1), can be unknown or N/A
  `Post_Symptom_Resolution_Duration` varchar(255),
  `Symptom_Resolution_Year` varchar(255),
  `Covid_Disease_Severity` int, -- vocab table
  `Duration_of_HAART_Therapy` int,
  `On_HAART_Therapy` varchar(255),   -- TINYINT(1), can be unknown or N/A
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Symptom` (
   `Symptom_Name` varchar(255) PRIMARY KEY,
   `NCIT_Code` varchar(255),
   `caDSR_Code` varchar(255)
   );

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Covid_Symptom_Reported` (
-- Participant_Covid_Symptom_Reported_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Research_Participant_ID` varchar(50)  NOT NULL,
  `Symptom_Name` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255)  NOT NULL,
  `Symptom_is_Present` TINYINT(1), -- if NULL, no data or NA
  PRIMARY KEY (`Research_Participant_ID`, `Symptom_Name`), -- this is a linking (many-to-many) table, each row is a unique entity
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Symptom_Name`) REFERENCES `Symptom` (`Symptom_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Comorbidity` (
  `Comorbidity_Name` varchar(255) PRIMARY KEY,
  `NCIT_Code` varchar(255),
  `caDSR_Code` varchar(255)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Participant_Comorbidity_Reported` (
--  `Participant_Comorbidity_Reported_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Research_Participant_ID` varchar(50)  NOT NULL,
  `Submission_CBC` varchar(255),
  `Comorbidity_Name` varchar(255) NOT NULL,
  `Cormobidity_is_Present` varchar(255),   -- TINYINT(1), can be unknown
  primary key(`Research_Participant_ID`, `Comorbidity_Name`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Tube` (
  `Tube_ID` int AUTO_INCREMENT,
  `Tube_Used_For` varchar(255) NOT NULL,
  `Tube_Type_Lot_Number` varchar(255),
  `Tube_Type_Catalog_Number` varchar(255),
  `Tube_Type` varchar(255),
  `Tube_Lot_Expiration_Date` date,
  PRIMARY KEY (`Tube_ID`)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Biospecimen` ( 
  `Biospecimen_ID` varchar(255)  PRIMARY KEY,
  `Research_Participant_ID` varchar(255)  NOT NULL,
--  `Test_Agreement` varchar(255), -- ?
  `Submission_CBC` varchar(255),
 -- `Shipping_ID` varchar(255),
  `Biospecimen_Tube_ID` int,
--  `Collection_Tube_Lot_Number` varchar(255),
--  `Collection_Tube_Catalog_Number` varchar(255),
  `Biospecimen_Group` varchar(255),
  `Biospecimen_Type` varchar(255),
--   `Initial_Volume_of_Biospecimen` int,
  `Initial_Volume_of_Biospecimen (mL)` float,
  `Biospecimen_Collection_Company_Clinic` varchar(255),
  `Biospecimen_Collector_Initials` varchar(10),
  `Biospecimen_Collection_Year` int(4),
 --  `Date_of_Biospecimen_Collection` date,
 --  `Time_of_Biospecimen_Collection` time,
  `Biospecimen_Processing_Company_Clinic` varchar(255) ,
  `Biospecimen_Processor_Initials` varchar(3),
--  `Date_of_Biospecimen_Processing` date,    -- PHI
--  `Time_of_Biospecimen_Receipt` time,    -- PHI 
  `Biospecimen_Processing_Batch_ID` varchar(255),
--  `Storage_Start_Time_80_LN2_storage` time,
--  `Storage_Time_at_2_8` float,
  `Storage_Time_at_2_8_Degrees_Celsius` float,
--  `Storage_Start_Time_at_2_8` timestamp,   -- PHI
  `Storage_Start_Time_at_2-8_Initials` varchar(3),
--  `Storage_End_Time_at_2_8` timestamp, -- PHI
  `Storage_End_Time_at_2-8_Initials` varchar(3),
--  `Centrifugation_Time` float,
--  `RT_Serum_Clotting_Time` float,
  `Biospecimen_Collection_to_Receipt_Duration` float,
  `Biospecimen_Receipt_to_Storage_Duration` float,
  `Centrifugation_Time (min)` float,	
  `RT_Serum_Clotting_Time (min)` float,
--  `Final_Concentration_of_Biospecimen` int,
  `Live_Cells_Hemocytometer_Count` int,
  `Total_Cells_Hemocytometer_Count` int,
  `Viability_Hemocytometer_Count` float,
  `Live_Cells_Automated_Count` int,
  `Total_Cells_Automated_Count` int,
  `Viability_Automated_Count` float,
  `Biospecimen_Comments` varchar(1000),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Submission_CBC`) REFERENCES CBC (`CBC_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Biospecimen_Tube_ID`) REFERENCES `Tube` (`Tube_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Biospecimen_Type`) REFERENCES `Biospecimen_Type` (`Biospecimen_Type`)  ON DELETE CASCADE ON UPDATE CASCADE
  
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Equipment` (
  `Equipment_Index` int PRIMARY KEY AUTO_INCREMENT,
  `Equipment_ID` varchar(255),
  `Equipment_Type` varchar(255),
  `Equipment_Calibration_Due_Date` date,
  `Equipment_Comments` varchar(1000)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Biospecimen_Equipment` (
   `Biospecimen_Equipment_ID` int PRIMARY KEY AUTO_INCREMENT,
   `Biospecimen_ID` varchar(255) NOT NULL,
   `Equipment_Index` int NOT NULL,
   FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (`Equipment_Index`) REFERENCES `Equipment` (`Equipment_Index`)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Reagent` (
  `Reagent_Name_Index` int AUTO_INCREMENT,
  `Reagent_Lot_Number` varchar(255),
  `Reagent_Name` varchar(255) NOT NULL,
  `Reagent_Catalog_Number` varchar(255),
  `Reagent_Expiration_Date` date,
  `Reagent_Comments` varchar(1000),
  PRIMARY KEY (`Reagent_Name_Index`)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Reagent_Biospecimen` (
  `Reagent_Biospecimen_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Reagent_Name_Index` int NOT NULL,
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Reagent_Name_Index`) REFERENCES `Reagent` (`Reagent_Name_Index`) ON DELETE CASCADE ON UPDATE CASCADE
-- FOREIGN KEY (Reagent_Lot_Number) REFERENCES Reagent (Reagent_Lot_Number)
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Consumable` (
  `Consumable_Name_Index` int AUTO_INCREMENT,
  `Consumable_Name` varchar(255) not null,
  `Consumable_Catalog_Number` varchar(255),
  `Consumable_Lot_Number` varchar(255),
  `Consumable_Expiration_Date` date,
  `Consumable_Comments` varchar(1000),
  PRIMARY KEY (`Consumable_Name_Index`));

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Consumable_Biospecimen` (
  `Consumable_Biospecimen_ID` int PRIMARY KEY AUTO_INCREMENT,
  `Biospecimen_ID` varchar(255) not null,
  `Consumable_Name_Index` int NOT NULL,
#  `Consumable_Name` varchar(255) not null,
#  `Consumable_Lot_Number` varchar(255),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Consumable_Name_Index`) REFERENCES `Consumable` (`Consumable_Name_Index`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Aliquot` (
  `Aliquot_ID` varchar(255) PRIMARY KEY,
--  `Biorepository_ID` varchar(255), -- ??
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Submission_CBC` varchar(255) NOT NULL,
--  `Shipment_ID` int,
  `Aliquot_Tube_ID` int,
--  `Aliquot_Tube_Catalog_Number` varchar(255),
--  `Aliquot_Concentration` float,
  `Aliquot_Concentration (cells/mL)` float,
  `Aliquot_Volume` float NOT NULL,
  `Aliquot_Units` varchar(255)  NOT NULL,
  `Aliquot_Initials` varchar(3),
  `Aliquot_Comments` varchar(1000),
  FOREIGN KEY (`Submission_CBC`) REFERENCES `CBC` (`CBC_ID`) ON DELETE CASCADE ON UPDATE CASCADE,  
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Aliquot_Tube_ID`) REFERENCES `Tube` (`Tube_ID`) 
);
 
CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay_Metadata` (
  `Assay_ID` varchar(255),
  `Technology_Type` varchar(255), -- vocab table?
  `Assay_Name` varchar(255)  NOT NULL, -- removed unique, added in target bio type as key 		
  `Assay_Manufacturer` varchar(255)  NOT NULL,
  `EUA_Status` varchar(255), -- vocab table
  `Assay_Multiplicity` varchar(255), -- ??
  `Developer/Substrate` varchar(255),
  `Developer/Substrate Manufacturer` varchar(255),
  `Platform` varchar(255),
  `Platform Manufacturer` varchar(255),
  `Analysis Method` varchar(255),
  `Analysis Software` varchar(255),
  `Assay_Target_Organism` varchar(255) NOT NULL, -- vocab
  primary key (`Assay_ID`,  `Assay_Target_Organism`)
  );
  
CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay_Calibration`(
  `Assay_ID` varchar(255),
  `Calibration_Type` varchar(255), -- vocab
  `Calibrator_High_or_Positive` varchar(255), -- bool?
  `Calibrator_Low_or_Negative` varchar(255), -- bool?
  `Standard Source` varchar(255),
  `Standard Concentration Upper` varchar(255),
  `Standard Concentration Lower` varchar(255),
  `Standard Concentration Units` varchar(255),
  `Standard Curve Diluent` varchar(255),
  `Standard Curve Dilution Value` varchar(255),
  `Number of Standard Diltions` varchar(255),
  `N_true_positive` int,
  `N_true_negative` int,
  `N_false_positive` int,
  `N_false_negative` int,
  `Peformance_Statistics_Source` varchar(255), -- vocab
  `Number of Samples Per Plate` int,
  `Number of Sample Diltuions` int,
  `Sample Dilution Value` varchar(255),
  `Testing Format` varchar(255),
  `Starting Sample Diltuion` varchar(255),
  primary key (`Assay_ID`),
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`) ON DELETE CASCADE ON UPDATE CASCADE
  );
  
CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay_Target`(
  `Assay_ID` varchar(255),
  `Assay_Target_Organism` varchar(255) NOT NULL, -- vocab
  `Assay_Target` varchar(255) NOT NULL, -- vocab
  `Assay_Target_Sub_Region` varchar(255), -- vocab
  `Measurand_Antibody_Type` varchar(255), -- vocab
  `Assay_Result_Type` varchar(255), -- vocab
  `Assay_Result_Unit` varchar(255), -- vocab
  `Positive_Cut_Off_Threshold` varchar(255), -- string value??
  `Negative_Cut_Off_Ceiling` varchar(255), -- string value??
  `Cut_Off_Unit` varchar(255), -- vocab
  `Low_Positive_Lower_Limit` float,
  `Low_Positive_Upper_Limit` float,
  `Medium_Positive_Lower_Limit` float,
  `Medium_Positive_Upper_Limit` float,
  `High_Positive_Lower_Limit` float,
  `High_Positive_Upper_Limit` float,
  `Assay_Antigen_Source` varchar(255),
  `Assay_Antigen_Method_Of_Production` varchar(255),
  `Plasmid_Description` varchar(255),
  primary key (`Assay_ID`, `Assay_Target_Organism`, `Assay_Target`),
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`) ON DELETE CASCADE ON UPDATE CASCADE
  --  FOREIGN KEY (`Target_Organism`) REFERENCES `Assay_Metadata` (`Target_Organism`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay_Bio_Target` (
	`Assay_Bio_Target_Index` int PRIMARY KEY AUTO_INCREMENT,
	`Assay_ID` varchar(255),
    `Target_Biospecimen_Type` varchar(255),
    `Is_Present` varchar(255),  -- Yes
	FOREIGN KEY (`Target_Biospecimen_Type`) REFERENCES `Biospecimen_Type` (`Biospecimen_Type`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay_Quality_Controls` (
	`Assay_QC_Index` int PRIMARY KEY AUTO_INCREMENT,
	`Assay_ID` varchar(255),
    `Quality_Control_Name` varchar(255),
    `Quality_Control_Source` varchar(255),
    `Quality_Control` varchar(255),
    `Quality_Control_Type` varchar(255),    
	FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Assay_Organism_Conversion` (
	`Assay_Organism_Index` int PRIMARY KEY AUTO_INCREMENT,
    `CBC_Name` varchar(255),
	`Assay_ID` varchar(255),
    `Assay_Target_Organism` varchar(255),
    `Assay_Target` varchar(255),
    `Target_Organism_Conversion` varchar(255),
	FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`) ON DELETE CASCADE ON UPDATE CASCADE
    );

Create Table IF NOT EXISTS `seronetdb-Validated`.`Shipping_Manifest` (
  `Submission_CBC` varchar(255),
  `Submission_Index` int,
  `Study ID` varchar(255),
  `Material Type` varchar(255),
  `Current Label` varchar(255) PRIMARY KEY,
  `Volume` float,
  `Volume Unit` varchar(255),
  `Volume Estimate` varchar(255),
  `Vial Type` varchar(255),
  `Vial Warnings` varchar(255),
  `Vial Modifiers` varchar(255),
  FOREIGN KEY (`Submission_Index`) REFERENCES `Submission` (`Submission_Index`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Current Label`) REFERENCES `Aliquot` (`Aliquot_ID`) ON DELETE CASCADE ON UPDATE CASCADE

  );
--   primary key (`Study ID`, `Material Type`, `Current Label`));#,
#   FOREIGN KEY (`Current Label`) REFERENCES `Aliquot` (`Aliquot_ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Confirmatory_Clinical_Test` (
-- `Confirmatory_Clinical_Test_ID` int PRIMARY KEY AUTO_INCREMENT,
`Research_Participant_ID` varchar(255) NOT NULL,
`Assay_ID` varchar(255) NOT NULL,
`Instrument_ID` varchar(255),
`Test_Operator_Initials` varchar(255),
`Assay_Kit_Lot_Number` varchar(255),
-- `Date_of_Test` date,
-- `Time_of_Test` time,
`Test_Batch_ID` varchar(255),
`Biospecimen_Collection_to_Test_Duration` int,
`Assay_Target_Organism` varchar(255),
`Assay_Target` varchar(255),
`Assay_Target_Sub_Region` varchar(255),
`Measurand_Antibody` varchar(255),
`Assay_Replicate` int,
`Sample_Type` varchar(255),
`Sample_Dilution` int,
`Interpretation` varchar(255),
`Derived_Result` varchar(255),
`Derived_Result_Units` varchar(255),
`Raw_Result` float,
`Raw_Result_Units` varchar(255),
`Positive_Control_Reading` float,
`Negative_Control_Reading` float,
`Confirmatory_Clinical_Test_Comments` varchar(1000),
Primary Key(`Research_Participant_ID`(20), `Assay_ID`, `Assay_Target_Organism`(50), `Assay_Target`),
FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Participant` (`Research_Participant_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`Assay_ID`) REFERENCES Assay_Metadata (Assay_ID) ON DELETE CASCADE ON UPDATE CASCADE
-- FOREIGN KEY (`Assay_Target`) REFERENCES `Assay_Target` (`Assay_Target`) ON DELETE CASCADE ON UPDATE CASCADE
);

Create table if not Exists `seronetdb-Validated`.`BSI_Parent_Aliquots` (
-- 	`Shipment_ID` varchar(255),
	`CBC_Biospecimen_Aliquot_ID` varchar(255),
	`Biorepository_ID` varchar(255) primary key,
    `Material Type` varchar(255),
	`Vial Status` varchar(255),
	`Vial Warnings` varchar(255),
    `Consented_For_Research_Use` varchar(255),
FOREIGN KEY (`Material Type`) REFERENCES `Biospecimen_Type` (`Biospecimen_Type`) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`CBC_Biospecimen_Aliquot_ID`) REFERENCES `Aliquot` (`Aliquot_ID`) ON DELETE CASCADE ON UPDATE CASCADE);

Create table if not Exists `seronetdb-Validated`.`BSI_Child_Aliquots` (
-- 	`Shipment_ID` varchar(255),
-- 	`CBC_Biospecimen_Aliquot_ID` varchar(255),
	`Biorepository_ID` varchar(255),
	`Subaliquot_ID` varchar(255) primary key,
	`Current Label` varchar(255),
	`Vial Status` varchar(255),
	`Vial Warnings` varchar(255),
FOREIGN KEY (`Biorepository_ID`) REFERENCES `BSI_Parent_Aliquots` (`Biorepository_ID`) ON DELETE CASCADE ON UPDATE CASCADE);
-- FOREIGN KEY (`CBC_Biospecimen_Aliquot_ID`) REFERENCES `Aliquot` (`Aliquot_ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Serology_Confirmatory_Test` (
`Reporting_Laboratory_ID` int,
`Subaliquot_ID` varchar(255) NOT NULL,
`BSI_Parent_ID` varchar(255) NOT NULL,
`Assay_ID` varchar(255) NOT NULL,
`Instrument_ID` varchar(255),
`Test_Operator_Initials` varchar(255),
`Assay_Kit_Lot_Number` varchar(255),
`Assay_Target_Organism` varchar(255),
`Assay_Target` varchar(255),
`Assay_Target_Sub_Region` varchar(255),
`Measurand_Antibody` varchar(255),
`Assay_Replicate` int,
`Sample_Type` varchar(255),
`Sample_Dilution` int,
`Interpretation` varchar(255),
`Derived_Result` float,
`Derived_Result_Units` varchar(255),
`Raw_Result` float,
`Raw_Result_Units` varchar(255),
`Positive_Control_Reading` float,
`Negative_Control_Reading` float,
`Confirmatory_Clinical_Test_Comments` varchar(1000),
primary key (`Subaliquot_ID`, `Assay_ID`, `Assay_Target`),
FOREIGN KEY (`Assay_ID`) REFERENCES Assay_Metadata (Assay_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`BSI_Parent_ID`) REFERENCES BSI_Parent_Aliquots (`Biorepository_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Secondary_Confirm_IDs` (
`File_Name` varchar (255),   -- Name of shipping manifest
`Barcode_ID` varchar (255),   -- Child ID
`BSI ID` varchar(255),
`Container Type` varchar(255),
`Material Type` varchar(255),
`Volume (mL)` varchar(255),
`Collection Date` varchar(255),
`Destination` varchar(255),
primary key (`File_Name`, `Barcode_ID`, `BSI ID`));#,
#FOREIGN KEY (`BSI ID`) REFERENCES `BSI_Parent_Aliquots` (`Biorepository_ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Secondary_Confirmatory_Test` (
`Reporting_Laboratory_ID` int,
`Subaliquot_ID` varchar(255) NOT NULL,
`BSI_Parent_ID` varchar(255) NOT NULL,
`Assay_ID` varchar(255) NOT NULL,
`Instrument_ID` varchar(255),
`Test_Operator_Initials` varchar(255),
`Assay_Kit_Lot_Number` varchar(255),
`Assay_Target_Organism` varchar(255),
`Assay_Target` varchar(255),
`Assay_Target_Sub_Region` varchar(255),
`Measurand_Antibody` varchar(255),
`Assay_Replicate` int,
`Sample_Type` varchar(255),
`Duration_In_Fridge` float,
`Duration_In_Fridge_Units` varchar(255),
`Sample_Dilution` int,
`Duration_Of_Test` float,
`Duration_Of_Test_Units` varchar(255),
`Interpretation` varchar(255),
`Derived_Result` float,
`Derived_Result_Units` varchar(255),
`Raw_Result` float,
`Raw_Result_Units` varchar(255),
`Positive_Control_Reading` float,
`Negative_Control_Reading` float,
`Confirmatory_Clinical_Test_Comments` varchar(1000),
primary key (`Subaliquot_ID`, `Assay_ID`, `Assay_Target`),
FOREIGN KEY (`Assay_ID`) REFERENCES Assay_Metadata (Assay_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`BSI_Parent_ID`) REFERENCES BSI_Parent_Aliquots (`Biorepository_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`Updated_Submissions`(
  `Submission_CBC_Name` varchar(255),
  `Submission_Time` datetime,
  `Submission_File_Name` varchar(255),
  `Submission_S3_Path` varchar(255) primary key,
  `Date_Submission_Updated` datetime,
  `Update_Status` varchar(255)
);
CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`CDC_Confrimation_Results`(
	`Patient ID` varchar(255),
    `BSI_Parent_ID` varchar(255) NOT NULL,
    `Measurand_Antibody` varchar(255),
    `Assay_Units` varchar(255),
	`SARS-CoV-2 Nucleocapsid` float,
	`SARS-CoV-2 S1 RBD` float,
	`SARS-CoV-2 Spike` float,
    primary key(`Patient ID`, `Measurand_Antibody`),
	FOREIGN KEY (`BSI_Parent_ID`) REFERENCES BSI_Parent_Aliquots (`Biorepository_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `seronetdb-Validated`.`CDC_Confrimation_Cutoffs`(
	`Sub Region` varchar(255) primary key,
	`Antibody` varchar(255),  -- IgG, IgM
	`Cut_off` float
);

Create Table if not Exists  `seronetdb-Validated`.`Deidentifed_Conversion_Table`(
	`ID_Type` varchar(50),
    `ID_Value` varchar(50),
    `MD5_Value` varchar(50)
);
