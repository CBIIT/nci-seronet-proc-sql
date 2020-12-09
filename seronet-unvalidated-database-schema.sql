CREATE TABLE `Demographic_Data` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Age` int,
  `Race` varchar(255),
  `Ethnicity` varchar(255),
  `Gender` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Submission_MetaData` (`Research_Participant_ID`)
);

CREATE TABLE `Prior_Test_Result` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `SARS_CoV_2_PCR_Test_Result` varchar(255),
  `SARS_CoV_2_PCR_Test_Result_Provenance` varchar(255),
  `Date_of_SARS_CoV_2_PCR_sample_collection` date,
  `Date_of_Diagnosis` date,
  `SARS_CoV_2_Serology_IgG_Results` varchar(255),
  `SARS_CoV_2_Serology_IgG_Test_Result_Provenance` varchar(255),
  `Date_of_blood_collection_IgG` date,
  `Date_of_SARS_CoV_2_Serology_IgG_Test` date,
  `SARS_CoV_2_Serology_IgM_Results` varchar(255),
  `SARS_CoV_2_Serology_IgM_Test_Result_Provenance` varchar(255),
  `Date_of_blood_collection_IgM` date,
  `Date_of_SARS_CoV_2_Serology_IgM_test` date,
  `SARS_CoV_2_Serology_Result_Other` varchar(255),
  `SARS_CoV_2_Serology_Other_Test_Result_Provenance` varchar(255),
  `Date_of_blood_collection_Other` date,
  `Date_of_SARS_CoV_2_Other_test` date,
  `CMV_Serology_Test_Result` varchar(255),
  `CMV_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_CMV_Serology_Test` date,
  `CMV_Molecular_Test_Result` varchar(255),
  `CMV_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_CMV_Molecular_Test` date,
  `Current_CMV_infection` boolean,
  `Duration_of_CMV_infection` int,
  `HepB_sAg_Test_Result` varchar(255),
  `HepB_sAg_Test_Result_Provenance` varchar(255),
  `Date_of_HepB_sAg_Test` date,
  `HepB_Serology_Test_Result` varchar(255),
  `HepB_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_HepB_Serology_Test` date,
  `Current_HepB_infection` boolean,
  `Duration_of_HepB_infection` int,
  `EBV_Molecular_Test_Result` varchar(255),
  `EBV_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_EBV_Molecular_Test` date,
  `EBV_Serology_Test_Result` varchar(255),
  `EBV_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_EBV_Serology_Test` date,
  `Current_EBV_infection` boolean,
  `Duration_of_EBV_infection` int,
  `HIV_Molecular_Test_Result` varchar(255),
  `HIV_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_HIV_Molecular_Test` date,
  `HIV_Serology_Test_Result` varchar(255),
  `HIV_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_HIV_Serology_Test` date,
  `Current_HIV_infection` boolean,
  `Duration_of_HIV_infection` int,
  `On_HAART_Therapy` boolean,
  `Duration_of_HAART_Therapy` int,
  `Seasonal_Coronavirus_Molecular_Result` varchar(255),
  `Seasonal_Coronavirus_Molecular_Test_Result_Provenance` varchar(255),
  `Date_of_Seasonal_Coronavirus_Molecular_Test` date,
  `Seasonal_Coronavirus_Serology_Result` varchar(255),
  `Seasonal_Coronavirus_Serology_Test_Result_Provenance` varchar(255),
  `Date_of_Seasonal_Coronavirus_Serology_Test` date,
  `Current_Seasonal_Coronavirus_infection` boolean,
  `Duration_of_Seasonal_Coronavirus_infection` int,
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`)
);

CREATE TABLE `Prior_Covid_Outcome` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Is_Symptomatic` boolean,
  `Date_of_Symptom_Onset` date,
  `Symptoms_Resolved` varchar(25),
  `Date_of_Symptom_Resolution` date,
  `Covid_Disease_Severity` int,
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`)
);

CREATE TABLE `Covid_Symptom` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Fever` boolean,
  `Temperature_over_100` boolean,
  `Chills` boolean,
  `Rigors` boolean,
  `Muscle_ache` boolean,
  `Runny_nose` boolean,
  `Sore_throat` boolean,
  `New_Olfactory_and_Taste_Disorder` boolean,
  `Headache` boolean,
  `Fatigue` boolean,
  `Cough` boolean,
  `Wheezing` boolean,
  `Shortness_of_breath` boolean,
  `Difficulty_breathing` boolean,
  `Chest_pain` boolean,
  `Nausea_or_vomiting` boolean,
  `Abdominal_pain` boolean,
  `Diarrhea` boolean,
  `Other_Symptom` boolean,
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`)
);

CREATE TABLE `Comorbidity` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Disease_Severity` int,
  `Diabetes_Mellitus` boolean,
  `Hypertension` boolean,
  `Severe_Obesity` boolean,
  `Cardiovascular_Disease` boolean,
  `Chronic_Renal_Disease` boolean,
  `Chronic_Liver_Disease` boolean,
  `Chronic_Lung_Disease` boolean,
  `Immunosuppressive_conditions` boolean,
  `Autoimmune_condition` boolean,
  `Inflammatory_Disease` boolean,
  `Other_Comorbidity` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`)
);

CREATE TABLE `Biospecimen` (
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Research_Participant_ID` varchar(255),
  `Test_Agreement` varchar(255),
  `Shipping_ID` varchar(255),
  `Biospecimen_Group` varchar(255),
  `Biospecimen_Type` varchar(255),
  `Initial_Volume_of_Biospecimen` int,
  `Biospecimen_Collection_Company_Clinic` varchar(255),
  `Biospecimen_Collector_Initials` varchar(3),
  `Date_of_Biospecimen_Collection` Date,
  `Time_of_Biospecimen_Collection` timestamp,
  `Biospecimen_Processing_Company_Clinic` varchar(255),
  `Biospecimen_Processor_Initials` varchar(3),
  `Date_of_Biospecimen_Processing` Date,
  `Time_of_Biospecimen_Receipt` timestamp,
  `Storage_Start_Time_80_LN2_storage` timestamp,
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
  `Viability_Hemocytometer_Count` int,
  `Live_Cells_Automated_Count` int,
  `Total_Cells_Automated_Count` int,
  `Viability_Automated_Count` int,
  PRIMARY KEY (`Biospecimen_ID`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`)
);

CREATE TABLE `Collection_Tube` (
  `Collection_Tube_Type_Lot_Number` varchar(255) NOT NULL,
  `Biospecimen_ID` varchar(255),
  `Collection_Tube_Type` varchar(255),
  `Collection_Tube_Type_Catalog_Number` varchar(255),
  `Collection_Tube_Type_Expiration_Date` date,
  PRIMARY KEY (`Collection_Tube_Type_Lot_Number`, `Biospecimen_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)
);

CREATE TABLE `Equipment` (
  `Equipment_ID` varchar(255) NOT NULL,
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Equipment_Type` varchar(255),
  `Equipment_Calibration_Due_Date` date,
  PRIMARY KEY (`Equipment_ID`, `Biospecimen_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)
);

CREATE TABLE `Reagent` (
  `Reagent_Lot_Number` varchar(255) NOT NULL,
  `Biospecimen_ID` varchar(255) NOT NULL,
  `Reagent_Name` varchar(255),
  `Reagent_Catalog_Number` varchar(255),
  `Reagent_Expiration_Date` date,
  PRIMARY KEY (`Reagent_Lot_Number`, `Biospecimen_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)
);

CREATE TABLE `Aliquot` (
  `Aliquot_ID` varchar(255) NOT NULL,
  `Biorepository_ID` varchar(255),
  `Biospecimen_ID` varchar(255),
  `Aliquot_Volume` int,
  `Aliquot_Units` varchar(255),
  `Aliquot_Initials` varchar(3),
  PRIMARY KEY (`Aliquot_ID`),
  FOREIGN KEY (`Biospecimen_ID`) REFERENCES `Biospecimen` (`Biospecimen_ID`)
);

CREATE TABLE `Aliquot_Tube` (
  `Aliquot_Tube_Type_Lot_Number` varchar(255) NOT NULL,
  `Aliquot_Tube_Type` varchar(255),
  `Aliquot_Tube_Type_Catalog_Number` varchar(255),
  `Aliquot_Tube_Type_Expiration_Date` date,
  `Aliquot_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`Aliquot_Tube_Type_Lot_Number`, `Aliquot_ID`),
  FOREIGN KEY (`Aliquot_ID`) REFERENCES `Aliquot` (`Aliquot_ID`)
);

CREATE TABLE `Biorepository_Aliquot` (
  `Biorepository_Aliquot_BarCode` varchar(255) NOT NULL,
  `Biorepository_ID` varchar(255),
  `Biorepository_Aliquot_Volume` int,
  `Biorepository_Aliquot_Volume_Units` varchar(255),
  `Biorepository_Aliquot_Destination` varchar(255),
  PRIMARY KEY (`Biorepository_Aliquot_BarCode`),
  FOREIGN KEY (`Biorepository_ID`) REFERENCES `Aliquot` (`Biorepository_ID`)
);

CREATE TABLE `Confirmatory_Test_Result` (
  `Research_Participant_ID` varchar(255) NOT NULL,
  `Assay_ID` varchar(255) NOT NULL,
  `Target_Antigen` varchar(255) NOT NULL,
  `Assay_Kit_Lot_Number` varchar(255),
  `Assay_Result` varchar(255),
  `Assay_Replicate` int,
  `Date_of_Test` date,
  `Test_Operator_Initials` varchar(255),
  PRIMARY KEY (`Research_Participant_ID`, `Assay_ID`, `Target_Antigen`),
  FOREIGN KEY (`Research_Participant_ID`) REFERENCES `Demographic_Data` (`Research_Participant_ID`),
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Target` (`Assay_ID`)
);

CREATE TABLE `Submission_MetaData` (
  `Submission_ID` varchar(255) NOT NULL,
  `Submission_Date` Date,
  `Submission_time` timestamp,
  `Submission_CBC` varchar(255),
  `Research_Participant_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`Submission_ID`)
);

CREATE TABLE `Assay_Metadata` (
  `Assay_ID` varchar(255) NOT NULL,
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
  PRIMARY KEY (`Assay_ID`)
);

CREATE TABLE `Assay_Target` (
  `Assay_ID` varchar(255) NOT NULL,
  `Target_Antigen` varchar(255) NOT NULL,
  `Target_Antigen_Sub_Region` varchar(255),
  `Assay_Antigen_Source` varchar(255),
  PRIMARY KEY (`Assay_ID`, `Target_Antigen`),
  FOREIGN KEY (`Assay_ID`) REFERENCES `Assay_Metadata` (`Assay_ID`)
);
