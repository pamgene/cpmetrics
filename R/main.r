#' @import shiny
#' @import bnutil
#' @import dplyr
#' @export
shinyServerRun = function(input, output, session, context) {

  output$body = renderUI({
    mainPanel(
      h4("Pooled standard deviation"),
      verbatimTextOutput("status")
    )
  })

  getDataReactive = context$getData()

  observe({

    getData=getDataReactive$value
    if (is.null(getData)){
      return()
    }

    data = getData()

    if (!data$hasXAxis){
      context$error('An x axis must be defined.')
      stop('An x axis must be defined.')
    }

    output$status = renderText({

    df = data$data %>% rename(x = all_of(data$xAxisColumnName)) %>%
        select(rowSeq, colSeq, value, x) %>%
        group_by(rowSeq, colSeq) %>% dplyr::summarise(pooled.sd = psd(value,x))

    mdf = data.frame(labelDescription = c("rowSeq", "colSeq", "pooled.sd"),
                     groupingType = c("rowSeq", "colSeq", "QuantitationType"))

    result = AnnotatedData$new(data = df, metadata = mdf)
    context$setResult(result)
    return('Done')
    })
  })
}

#' @export
shinyServerShowResults = function(input, output, session, context){

}

