
# a script to explain the steps to authorise reading from a Google Sheet
# including local use (using .json key from a Google Service Account etc)
# and local use encrypting this .json file and creating a .secret folder

library(tidyverse)
library(googlesheets4)

#### set up authorisations to read from the Google sheet ####
# To demonstrate, a dummy google spreadsheet:


###### === LOCALLY WITH .JSON IN R PROJECT FOLDER === ######

# 1 # set up a Google Service Account (see https://cloud.google.com/iam/docs/creating-managing-service-accounts)
# 2 # create a key and download the .json - put this into your R project folder
# 3 # copy the email address from the .json; add this email as an editor to your Google sheets in the 'Share' settings
# 4 # point 'gs4_auth()' to the .json from step 3:

gs4_auth(email = "*@talarify.co.za", path = "~/stakeholder_map_project_2/stakeholder-map-gsheets-access-b505f81e6844.json")

form_data <-
  read_sheet(
    "https://docs.google.com/spreadsheets/d/1dflPxRV-JEoOinBnf24hIm1tqSDCjtwLaGZWSR0VipA/edit#gid=1982636034"
  )

# fine for local use, but problem with having the json file visible
# locally, can make this a secret:

renv::deactivate() # not sure if needed, want to make sure below is not using renviron

###### === LOCALLY WITH .JSON ENCRYPTED AND ADDED TO .SECRET === ######
# for GitHub Action (adapted from https://github.com/jdtrat/tokencodr-google-demo)

library(tokencodr)
create_env_pw("GSHEET_ACCESS")
## copy the password in the console. Then, paste this to the .Renviron file:
usethis::edit_r_environ()
# end .Renviron with a new line, save and close
# restart R

# now, encrypt the token. This places the encrypted .json file into a secret folder in the specified destination:
encrypt_token(service = "GSHEET_ACCESS",
              input = "stakeholder-map-gsheets-access-b505f81e6844.json",
              destination = "~/src/stakeholder_map_project_2/") # can check in terminal the .secret folder is there

gs4_auth(email = "*@talarify.co.za", path = "~/stakeholder_map_projcet_2/.secret/GSHEET_ACCESS")

form_data <-
  read_sheet(
    "https://docs.google.com/spreadsheets/d/1dflPxRV-JEoOinBnf24hIm1tqSDCjtwLaGZWSR0VipA/edit#gid=1982636034"
  )


###### === for GitHub Action === ######
# for GitHub Action (adapted from https://github.com/jdtrat/tokencodr-google-demo)
# having encrypted the json file above and placing it in a .secret
# 
# FOLLOW STEPS IN BLOG


