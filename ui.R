


navbarPage("Visualization for each individual data",
           tabPanel("Interactive Map",
                    div(class="outer",
                        tags$head(
                          # Include our custom CSS
                          useShinyjs(),
                          includeCSS("styles.css")
                        ),
                    leafglOutput("myMap", width="100%", height="100%"),
                    
                    
                    jqui_draggable(
                      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                  draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                  width = 360, height = "auto",
                                  
                                  h3("Data measure visualization"),
                                  hr(),
                                  selectizeInput("datameasure","Data measure available",choices = NULL),
                                  hr(),
                                  actionButton("redraw","Visualize"),
                                  br(),
                                  br(),
                                  p("Please be advised that, based on the size of entire region, the data measure may take up to 20 seconds to load")
                                  
                    ),
                      options = list(cancel = ".selectize-control"))
                    )
           )
)
