function(input, output, session) {

 
  output$myMap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(provider = providers$CartoDB.DarkMatter)%>%
            setView(-90.4369, 28.9072,5)%>%
            addFullscreenControl()
  })
  
  measureselected <- reactiveVal("hab1")
  
  
  observeEvent(input$datameasure,{
    measureselected(input$datameasure)
    print(measureselected())
  })
  
  observeEvent(input$redraw,{
    withProgress(message = 'Generating visualization...', value = 0, {
      incProgress(0.1, detail = paste("Initializing"))
      incProgress(0.2, detail = paste("Preparing data"))
      tmp2<-eval(parse(text = paste0("data1$",names1[which(names==measureselected())])))
      cols = colour_values_rgb(.bincode(tmp2, b, FALSE, TRUE)/4, palette="ylorrd", include_alpha = FALSE) / 255
      incProgress(0.1, detail = paste("Drawing map"))
      leafletProxy("myMap")%>%
        clearGroup("weight")%>% 
        clearControls()%>%
        addGlPolygons(data = data1, color = cols,group = "weight")%>%
        addLegend(title = "Score",labels =c("0-0.25","0.25-0.5","0.5-0.75","0.75-1") , colors = c( "#FFFFCC", "#FEBF58","#F53B23" , "#800026"), opacity = 0.7,
                  position = "bottomright")
      incProgress(0.6, detail = paste("Finalizing"))
    })
  })
  
  updateSelectizeInput(session, 'datameasure', 
                       choices = list(Habitat = hab_measure,
                                      Water_Quality = wq_measure,
                                      LCMR = lcmr_measure,
                                      Resilliense = cl_measure,
                                      Economy = eco_measure), 
                       selected="hab1")
  
  
}
