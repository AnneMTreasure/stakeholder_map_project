
## stakeholder map project script to:
# - set authorisations to read from a Google spreadsheet (linked to Google Form)
# - read in sheets for different record types
# - 

library(tidyverse)
library(googlesheets4)

###### authorisations
# this works locally
gs4_auth(email = "*@talarify.co.za", path = "~/stakeholder_map/.secret/GSHEET_ACCESS")

# for GitHub Action (adapted from https://github.com/jdtrat/tokencodr-google-demo)
#source("functions/func_auth_google.R")

# Authenticate Google Service Account
#auth_google(email = "*@talarify.co.za",
#            service = "GSHEET_ACCESS",
#            token_path = ".secret/GSHEET_ACCESS")

# Read in Google Sheet data
ss = "https://docs.google.com/spreadsheets/d/1dflPxRV-JEoOinBnf24hIm1tqSDCjtwLaGZWSR0VipA/edit#gid=369134759"

kumu <- read_sheet(ss, sheet = "kumu") # don't need to read this sheet in for manipulation. Its ready for Kumu. Need to start a new Kumu project, and link this spreadsheet to it
project <- read_sheet(ss, sheet = "project")
person <- read_sheet(ss, sheet = "person")
dataset <- read_sheet(ss, sheet = "dataset")
tool <- read_sheet(ss, sheet = "tool")
publication <- read_sheet(ss, sheet = "publication")
training <- read_sheet(ss, sheet = "training")
archives <- read_sheet(ss, sheet = "archives")
learning_material <- read_sheet(ss, sheet = "learning_material")
unclassified <- read_sheet(ss, sheet = "unclassified")

###### 





