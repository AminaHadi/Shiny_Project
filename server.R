
# Import data
trains_df <- read.csv("full_trains.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
 
  # Filters : select Year and/or departure station 
  output$annee <- renderUI({
    selectInput("liste_annee", "Année :",
                c("ALL",sort(unique(trains_df[,"year"]))),
    )
  })
  
  output$gare <- renderUI({
    selectInput("liste_gare", "Gare :",
                c("ALL",sort(unique(trains_df[,"departure_station"]))),
    )
  })
  
 # Total number of train 
  output$nb_train <- renderValueBox({
    data <- sum(trains_data()$total_num_trips)-sum(trains_data()[!is.na(trains_data()$num_of_canceled_trains),]$num_of_canceled_trains)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = "Nombre de trains", color = "black")
  })
  
  #Number of delated train at departure
  output$nb_late_depart <- renderValueBox({
    data <- sum(trains_data()[!is.na(trains_data()$num_late_at_departure),]$num_late_at_departure)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = "Nombre de train retardés au départ", color = "purple")
  })
  
  # Number of train delayed at arrival
  output$nb_late_arrivee <- renderValueBox({
    data <- sum(trains_data()[!is.na(trains_data()$num_arriving_late),]$num_arriving_late)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = "Nombre de train retardés à l'arrivée", color = "light-blue")
  })
  
  output$avg_late_arrivee <- renderValueBox({
    data <- mean(trains_data()[!is.na(trains_data()$num_arriving_late),]$num_arriving_late)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = "Nombre moyen de trains retardés à l'arrivée", color = "purple")
  })
  
  output$avg_late_depart <- renderValueBox({
    data <- mean(trains_data()[!is.na(trains_data()$num_late_at_departure),]$num_late_at_departure)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = "Nombre moyen de trains retardés au départ", color = "light-blue")
  })
  
  output$avg_late_tout_train_depart <- renderValueBox({
    data <- mean(trains_data()[!is.na(trains_data()$avg_delay_all_departing),]$avg_delay_all_departing)
    if(data == "NaN")
      data = "Unknown"
    else
      data = paste(round(data), "min")
    data %>%
      valueBox(subtitle = "Durée moyenne des retards au départ pour tous les trains",color = "purple")
    
  })
  
  output$avg_late_tout_train_arrivee <- renderValueBox({
    data <- mean(trains_data()[!is.na(trains_data()$avg_delay_all_arriving),]$avg_delay_all_arriving)
    if(data == "NaN")
      data = "Unknown"
    else
      data = paste(round(data), "min")
    data %>%
      valueBox(subtitle = "Durée moyenne des retards à l'arrivée pour tous les trains",color = "light-blue")
  })
  
  output$temps_avg_late_depart <- renderValueBox({
    data <- mean(trains_data()[!is.na(trains_data()$avg_delay_late_at_departure),]$avg_delay_late_at_departure)
    if(data == "NaN")
      data = "Unknown"
    else
      data = paste(round(data), "min")
    data %>%
      valueBox(subtitle = "Durée moyenne des retards (pour les trains en retard au départ)",color = "light-blue")
  })
  
  output$temps_avg_late_arrivee <- renderValueBox({
    data <- mean(trains_data()[!is.na(trains_data()$avg_delay_late_on_arrival),]$avg_delay_late_on_arrival)
    if(data == "NaN")
      data = "Unknown"
    else
      data = paste(round(data), "min")
    data %>%
      valueBox(subtitle = "Durée moyenne des retards (pour les trains en retard à l'arrivée)",color = "purple")
  })
  
  output$nb_total_train_annul <- renderValueBox({
    data <- sum(trains_data()[!is.na(trains_data()$num_of_canceled_trains),]$num_of_canceled_trains)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = "Nombre de train annulés",color = "black")
  })
  
  output$pourcentage_trains_annul <- renderValueBox({
    data <- sum(trains_data()[!is.na(trains_data()$num_of_canceled_trains),]$num_of_canceled_trains)*100
    data <- data / sum(trains_data()$total_num_trips)
    if(data == "NaN")
      data = "Unknown"
    else
      data = paste(round(data,1),"%")
    data %>%
      valueBox(subtitle = "Proportion des trains annulés",color = "black")
  })
  
  
  # Proportion of delay
  output$causes_retard<- renderPlot({
    external = mean(trains_data()[!is.na(trains_data()$delay_cause_external_cause),]$delay_cause_external_cause)
    rail = mean(trains_data()[!is.na(trains_data()$delay_cause_rail_infrastructure),]$delay_cause_rail_infrastructure)
    traffic = mean(trains_data()[!is.na(trains_data()$delay_cause_traffic_management),]$delay_cause_traffic_management)
    rolling = mean(trains_data()[!is.na(trains_data()$delay_cause_rolling_stock),]$delay_cause_rolling_stock)
    station = mean(trains_data()[!is.na(trains_data()$delay_cause_station_management),]$delay_cause_station_management)
    travelers = mean(trains_data()[!is.na(trains_data()$delay_cause_travelers),]$delay_cause_travelers)
    myPal <- brewer.pal(5, "Set1") 
    
    slices <- c(external, rail, traffic, rolling, station, travelers)
    labels_ <- c("External", "Rail Infrastructure", "Traffic management", "Rolling stock", "Station management", "Travelers")    
    camambert <- data.frame(value=slices, causes=labels_, row.names=NULL)
    
    colnames(camambert) <-c("value","causes")
    blank_theme <- theme_minimal()+
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.grid=element_blank(),
        panel.background = element_rect(fill = "transparent",
                                        colour = "transparent"),
        axis.ticks = element_blank(),
        plot.title=element_text(size=18, face="bold"),
        plot.background = element_rect(fill = "transparent",colour = "transparent")
      )
    
    
    
    ggplot(data = camambert, aes(x="", y=value))+
      geom_bar(width = 1, stat = "identity", aes(fill=causes)) + 
      coord_polar(theta = "y") +
      scale_fill_grey("Causes") + blank_theme +
      theme(axis.text.x=element_blank())+
      geom_label(aes(label = paste(round(value*100),"%"),group = causes),position = position_stack(vjust = 0.5) , show.legend = FALSE)
    
  }, bg="transparent")

  output$gare_arrivee <- renderUI({
    selectInput("liste_gare_dest", "Gare arrivée :",
                c("ALL",sort(unique(trains_df[,"arrival_station"]))),
    )
  })
  trains_data2 <- reactive({
    
    if(input$liste_annee=="ALL" & input$liste_gare=="ALL" & input$liste_gare_dest=="ALL"){
      trains_df <- trains_df
    }
    else if(input$liste_annee=="ALL"& input$liste_gare_dest=="ALL"){
      trains_df <- subset(trains_df,  departure_station == input$liste_gare )
    }
    else if(input$liste_gare=="ALL" & input$liste_gare_dest=="ALL"){
      trains_df <- subset(trains_df,  year == input$liste_annee )
    }
    else if(input$liste_gare=="ALL" & input$liste_annee=="ALL"){
      trains_df <- subset(trains_df,  arrival_station == input$liste_gare_dest)
    }
    else if(input$liste_gare=="ALL" ){
      trains_df <- subset(trains_df,  arrival_station == input$liste_gare_dest & year == input$liste_annee)
    }
    else if(input$liste_annee=="ALL" ){
      trains_df <- subset(trains_df,  arrival_station == input$liste_gare_dest & departure_station == input$liste_gare)
    }
    else if(input$liste_gare_dest=="ALL" ){
      trains_df <- subset(trains_df,  year == input$liste_annee & departure_station == input$liste_gare)
    }
    else{
      trains_df <- subset(trains_df,  year == input$liste_annee & departure_station == input$liste_gare & arrival_station == input$liste_gare_dest)
    }
    
  })
  
  output$nb_voyage <- renderValueBox({
    data <- sum(trains_data2()$total_num_trips)-sum(trains_data2()[!is.na(trains_data2()$num_of_canceled_trains),]$num_of_canceled_trains)
    if(data == "NaN")
      data = "Unknown"
    else
      data = round(data)
    data %>%
      valueBox(subtitle = paste("Nombre de train en direction de ",input$liste_gare_dest),color = "black")
  })
  
  
  trains_data <- reactive({
    if(input$liste_annee=="ALL" & input$liste_gare=="ALL"){
      trains_df <- trains_df
    }
    else if(input$liste_annee=="ALL"){
      trains_df <- subset(trains_df,  departure_station == input$liste_gare )
    }
    else if(input$liste_gare=="ALL"){
      trains_df <- subset(trains_df,  year == input$liste_annee )
    }
    else{
      trains_df <- subset(trains_df,  year == input$liste_annee & departure_station == input$liste_gare)
    }
    
    
  })

  
 
}

