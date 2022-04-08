
# STAKEHOLDER MAP PROJECT: script to:
# - set authorisations to read from a Google spreadsheet (linked to Google Form)
# - import data from this Google spreadsheet, manipulate and write to new spreadsheets for Shiny

###### ---------- LOAD PACKAGES ---------- ######
library(tidyverse)
library(googlesheets4)

###### ---------- AUTHORISATIONS ---------- ######
# this works locally
gs4_auth(email = "*@talarify.co.za", path = "~/stakeholder_map/.secret/MY_GOOGLE")

# for GitHub Action (adapted from https://github.com/jdtrat/tokencodr-google-demo)
#source("R/func_auth_google.R")

# Authenticate Google Service Account (adapted from https://github.com/jdtrat/tokencodr-google-demo)
#auth_google(email = "*@talarify.co.za",
#            service = "MY_GOOGLE",
#            token_path = ".secret/MY_GOOGLE")


###### ---------- READ DATA FROM GOOGLE SHEET ---------- ######
form_data <- read_sheet("https://docs.google.com/spreadsheets/d/1-2rF3VNdkXzFKPjUwMexedyVFxsamjO-8yAi7AVierY/edit?resourcekey#gid=1694945086")


###### ---------- Record type: PROJECT ---------- ######
project <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Project") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "2")))) %>%
  unite("Tags", 11:12, sep = ", ", remove = FALSE)

names(project) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "Label",
    "Description",
    "Tags",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "language_primary",
    "status",
    "year_start",
    "year_end",
    "Funders",
    "URL",
    "Email",
    "project_outputs"
  )

# fix punctuation for subject area & methods
project$subject_area <- gsub(";, ", ";", project$subject_area)
project$methods <- gsub(";, ", ";", project$methods)

###### ---------- Record type: PERSON ---------- ######
person <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Person") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "3")))) %>%
  unite("Tags", 12:13, sep = ", ", remove = FALSE) %>%
  unite("Label", 6:8, sep = " ", remove = FALSE)

names(person) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "Label",
    "title",
    "first_names",
    "surname",
    "Email",
    "Description",
    "keywords",
    "Tags",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "job_title",
    "career_stage",
    "orcid",
    "URL",
    "linkedin_url",
    "researchgate_url",
    "twitter"
  )

# fix punctuation for subject area & methods
person$subject_area <- gsub(";, ", ";", person$subject_area)
person$methods <- gsub(";, ", ";", person$methods)


###### ---------- Record type: DATASET ---------- ######
dataset <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Dataset") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "4"))))

names(dataset) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "contact_email",
    "Label",
    "Description",
    "keywords",
    "Subjects",
    "methods",
    "status",
    "publisher",
    "repository",
    "publication_year",
    "language_primary",
    "language_other",
    "identifier",
    "licence",
    "paywall",
    "machine_readable",
    "URL",
    "dataset_format"
  )

# fix punctuation for subject area & methods
dataset$subject_area <- gsub(";, ", ";", dataset$subject_area)
dataset$methods <- gsub(";, ", ";", dataset$methods)


###### ---------- Record type: TOOL ---------- ######
tool <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Tool") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "5"))))

names(tool) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "contact_email",
    "Label",
    "Description",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "language_primary",
    "language_other",
    "year_created",
    "year_updated",
    "analysis_type",
    "tool_run",
    "usage",
    "TaDiRAH_methods",
    "licence",
    "status",
    "TaDiRAH_goals",
    "Funders",
    "URL"
  )

# fix punctuation for subject area & methods
tool$subject_area <- gsub(";, ", ";", tool$subject_area)
tool$methods <- gsub(";, ", ";", tool$methods)


###### ---------- Record type: PUBLICATION ---------- ######
publication <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Publication") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "6"))))

names(publication) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "publication_type",
    "title",
    "abstract",
    "authors",
    "Subjects",
    "methods",
    "language_primary",
    "language_other",
    "status",
    "publisher",
    "volume_no",
    "start_page_no",
    "end_page_no",
    "publication_year",
    "conference_name",
    "conference_start_date",
    "identifier",
    "licence",
    "paywall",
    "URL",
    "zotero_library"
  )

# fix punctuation for subject area & methods
publication$subject_area <- gsub(";, ", ";", publication$subject_area)
publication$methods <- gsub(";, ", ";", publication$methods)


###### ---------- Record type: TRAINING ---------- ######
training <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Training") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "7", "8", "9"))))

names(training) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "contact_email",
    "training_type",
    "Label",
    "Description",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "year",
    "length",
    "frequency",
    "language_primary",
    "language_other",
    "URL",
    "inperson_or_online",
    "inperson_organisation_venue",
    "inperson_organisation_venue_other",
    "online_type"
  )

# fix punctuation for subject area & methods
training$subject_area <- gsub(";, ", ";", training$subject_area)
training$methods <- gsub(";, ", ";", training$methods)


###### ---------- Record type: ARCHIVES ---------- ######
archives <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Archives") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "10"))))

names(archives) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "contact_email",
    "Label",
    "Description",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "year",
    "language_primary",
    "language_other",
    "URL"
  )

# fix punctuation for subject area & methods
archives$subject_area <- gsub(";, ", ";", archives$subject_area)
archives$methods <- gsub(";, ", ";", archives$methods)


###### ---------- Record type: LEARNING MATERIAL ---------- ######
learning_material <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Learning Material") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "11"))))

names(learning_material) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "contact_email",
    "Label",
    "Description",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "learning_material_type",
    "year_created",
    "year_updated",
    "target_audience",
    "language_primary",
    "language_other",
    "available_online",
    "material_URL",
    "licence"
  )

# fix punctuation for subject area & methods
learning_material$subject_area <- gsub(";, ", ";", learning_material$subject_area)
learning_material$methods <- gsub(";, ", ";", learning_material$methods)

###### ---------- Record type: UNCLASSIFIED ---------- ######
unclassified <- form_data %>%
  filter(`1._What is the type of record you are submitting?` == "Unclassified") %>%
  select(c("Timestamp", "Email Address", starts_with(c("1.", "12"))))

names(unclassified) <-
  c(
    "Timestamp",
    "email_collected",
    "data_submitter_name",
    "data_submitter_email",
    "Type",
    "contact_first_names",
    "contact_surname",
    "contact_title",
    "contact_email",
    "Label",
    "Description",
    "Subjects",
    "methods",
    "Organisation",
    "Organisation_other",
    "year_collected",
    "language_primary",
    "language_other",
    "URL"
  )

# fix punctuation for subject area & methods
unclassified$subject_area <- gsub(";, ", ";", unclassified$subject_area)
unclassified$methods <- gsub(";, ", ";", unclassified$methods)


###### ---------- DATA SHEETS FOR Shiny ---------- ######
##### write to Google spreadsheet ##### 

ss = "https://docs.google.com/spreadsheets/d/1fUf6SbWQttVVCUAZ2jH9z24qua1BqO05Qv2lLNllsCU/edit#gid=0"

sheet_write(project, ss = ss, sheet = "project")
sheet_write(person, ss = ss, sheet = "person")
sheet_write(dataset, ss = ss, sheet = "dataset")
sheet_write(tool, ss = ss, sheet = "tool")
sheet_write(publication, ss = ss, sheet = "publication")
sheet_write(training, ss = ss, sheet = "training")
sheet_write(archives, ss = ss, sheet = "archives")
sheet_write(learning_material, ss = ss, sheet = "learning_material")
sheet_write(unclassified, ss = ss, sheet = "unclassified")

