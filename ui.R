library(shinydashboard)
library(shiny)
library(dplyr)
library(tm)
library(stringr)
library(tidyr)
library(leaflet)
library(plotrix)
library(ggplot2)
library(wordcloud)


#title <- tags$a(href='https://www.google.com',
#                tags$img(src="SNCF_Design01_Logo_formes2.jpg", with=70, height=50),
#                'Projet')

ui <- dashboardPage(skin = "black",
                    dashboardHeader(title = "Projet"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Trains", tabName = "train", icon = icon("dashboard")
                        )
                     
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "train",
                                
                                fluidRow(
                                  box(
                                    uiOutput("annee", width = 6)
                                  ),
                                  box(
                                    
                                    uiOutput("gare", width = 6)
                                  ),
                                ),
                                tabsetPanel(
                                  tabPanel("Overview", 
                                           fluidRow(
                                             valueBoxOutput("nb_train", width = 12), 
                                             valueBoxOutput("nb_late_depart", width = 6),
                                             valueBoxOutput("nb_late_arrivee", width = 6),
                                           ),
                                           fluidRow(
                                             valueBoxOutput("avg_late_depart", width = 6),
                                             valueBoxOutput("avg_late_arrivee", width = 6),
                                             valueBoxOutput("avg_late_tout_train_depart", width = 6),
                                             valueBoxOutput("avg_late_tout_train_arrivee", width = 6)
                                           ),
                                           fluidRow(
                                             
                                             valueBoxOutput("temps_avg_late_depart", width = 6),
                                             valueBoxOutput("temps_avg_late_arrivee", width = 6),
                                           ),
                                           fluidRow(
                                             valueBoxOutput("nb_total_train_annul", width = 6),
                                             valueBoxOutput("pourcentage_trains_annul", width = 6),
                                           )
                                  ),
                                  tabPanel("Répartition des motifs de retard",
                                           fluidRow(  
                                             box(
                                               plotOutput("causes_retard"),
                                               width = 10, status = "info", solidHeader = TRUE,
                                               title = "Répartition des motifs de retard"
                                             )
                                           )
                                           
                                  ),
                                  tabPanel("Nombre de voyages",
                                           fluidRow(
                                             box(
                                               uiOutput("gare_arrivee", width = 6)
                                             ),
                                             fluidRow(
                                               valueBoxOutput("nb_voyage", width = 6)
                                             )
                                           )
                                  )
                                )
                        )
 


                      )
                    )
)