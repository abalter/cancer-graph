
displayTable = function(
    df,
    caption=NULL,
    search=list(regex = TRUE, caseInsensitive = TRUE)
)
{
  num_rows = nrow(df)
  df %>%
    datatable(
      extensions = c('ColReorder', 'Scroller'),
      options = list(
        colReorder=T,
        scroller=T,
        scrollY="500px",
        sScrollX=T,
        searchHighlight = TRUE,
        search = search,

        pageLength = num_rows
      ),
      caption = htmltools::tags$caption(
        style = '
        caption-side: top;
        text-align: center;
        color:black;
        font-size:150% ;',
        caption),
      # caption = caption,
      rownames = F
    ) %>%
    formatStyle(columns = colnames(.), fontSize = '50%')
}
