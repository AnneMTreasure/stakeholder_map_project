#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

# ----- load libraries -----
library(tidyverse)
library(googlesheets4)
library(shiny)
library(leaflet)
library(DT)
library(tableHTML)

# usecairo = T from package Cairo for better quality of figures in shiny app
options(shiny.usecairo=T)

# ----- load functions -----
#source('functions/my_map_activ.R')

# ----- authorisations -----
# this works locally
gs4_auth(email = "*@talarify.co.za", path = "~/stakeholder_map/.secret/GSHEET_ACCESS")

# for GitHub Action (adapted from https://github.com/jdtrat/tokencodr-google-demo)
#source("functions/func_auth_google.R")

# Authenticate Google Service Account
#auth_google(email = "*@talarify.co.za",
#            service = "GSHEET_ACCESS",
#            token_path = ".secret/GSHEET_ACCESS")

# ----- Read in Google Sheet data -----
ss = "https://docs.google.com/spreadsheets/d/1dflPxRV-JEoOinBnf24hIm1tqSDCjtwLaGZWSR0VipA/edit#gid=369134759"

kumu <- read_sheet(ss, sheet = "kumu") # don't need to read this sheet in for manipulation. Its ready for Kumu. Need to start a new Kumu project, and link this spreadsheet to it

locations <- read_sheet(ss, sheet = "Organisation_locations")
project <- read_sheet(ss, sheet = "project")
person <- read_sheet(ss, sheet = "person")
dataset <- read_sheet(ss, sheet = "dataset")
tool <- read_sheet(ss, sheet = "tool")
publication <- read_sheet(ss, sheet = "publication")
training <- read_sheet(ss, sheet = "training")
archives <- read_sheet(ss, sheet = "archives")
learning_material <- read_sheet(ss, sheet = "learning_material")
unclassified <- read_sheet(ss, sheet = "unclassified")


#### ----- Define UI for application that draws plot -----
ui <- (fluidPage(
    titlePanel(title = "Digital Humanities and Computational Social Sciences landscape in South Africa"),
    p("The South African Centre for Digital Language Resources (SADiLaR) is a national centre supported by the Department of Science and Innovation (DSI) as part of the South African Research Infrastructure Roadmap (SARIR). SADiLaR has an enabling function, with a focus on all official languages of South Africa, supporting research and development in the domains of language technologies and language-related studies in the humanities and social sciences. Furthermore the centre has a mandate to develop digital humanities capacity in South Africa."),
    tabsetPanel(
        # ----- input for 1st panel (activities map) -----
        tabPanel('Activities Map',
                     mainPanel(
                         #            h4('DH and CSS landscape in South Africa'),
                         p("This map shows data on Digital Humanities (DH) and Computational Social Sciences (CSS) activities and initiatives in South Africa."),
                         h4('Add some text here'),
                         p("if we want text here"),
                     ) # end mainPanel
        ), # end tabPanel 1
        
        # ----- input for 2nd panel (project table) -----
        tabPanel('Projects',
                 DT::dataTableOutput("mytable_project")
        ), # end tabPanel 2
        
        # ----- input for 3rd panel (person table) -----
        tabPanel('People',
                 DT::dataTableOutput("mytable_person")
        ), # end tabPanel 3
        
        # ----- input for 4th panel (dataset table) -----  
        tabPanel('Datasets',
                 DT::dataTableOutput("mytable_dataset")
        ), # end tabPanel 4
        
        # ----- input for 5th panel (tool table) -----
        tabPanel('Tools',
                 DT::dataTableOutput("mytable_tool")
        ), # end tabPanel 5
        
        # ----- input for 6th panel (publication table) -----
        tabPanel('Publications',
                 DT::dataTableOutput("mytable_publication")
        ), # end tabPanel 6
        
        # ----- input for 7th panel (training table) -----
        tabPanel('Training',
                 DT::dataTableOutput("mytable_training")
        ), # end tabPanel 7
        
        # ----- input for 8th panel (learning_material table) -----
        tabPanel('Learning materials',
                 DT::dataTableOutput("mytable_learning_material")
        ), # end tabPanel 8
        
        # ----- input for 9th panel (archives table) -----
        tabPanel('Archives',
                 DT::dataTableOutput("mytable_archives")
        ), # end tabPanel 9
        
        # ----- input for 10th panel (unclassified table) -----
        tabPanel('Unclassified records',
                 DT::dataTableOutput("mytable_unclassified")
        ), # end tabPanel 10
        
    ) # end tabsetPanel
) # end fluidpage
)

# Define server logic required to draw a the leaflet map, other plots, and show tables
server <- function(input, output){
    # ----- output (map) for 1st panel (map) ----- ## TO COME, table for now
    output$mymap = DT::renderDataTable({
        locations
    }) # end output map
    
    # ----- output (table) for 2nd panel (projects table) -----
    output$mytable_project = DT::renderDataTable({
        project
    })
    
    # ----- output (table) for 3nd panel (people table) -----
    output$mytable_person = DT::renderDataTable({
        person
    })
    
    # ----- output (table) for 4th panel (dataset table) -----
    output$mytable_dataset = DT::renderDataTable({
        dataset
    })    
    
    # ----- output (table) for 5th panel (tool table) -----
    output$mytable_tool = DT::renderDataTable({
        tool
    })
    
    # ----- output (table) for 6th panel (publication table) -----
    output$mytable_publication = DT::renderDataTable({
        publication
    })
    
    # ----- output (table) for 7th panel (training table) -----
    output$mytable_training = DT::renderDataTable({
        training
    })
    
    # ----- output (table) for 8th panel (learning_material table) -----
    output$mytable_learning_material = DT::renderDataTable({
        learning_material
    })
    
    # ----- output (table) for 9th panel (archives table) -----
    output$mytable_archives = DT::renderDataTable({
        archives
    })
    
    # ----- output (table) for 10th panel (unclassified table) -----
    output$mytable_unclassified = DT::renderDataTable({
        unclassified
    })
} # end server

# Run the application
shinyApp(ui, server)
