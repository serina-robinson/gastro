theme.publication <- function(taxa.vec) {
  #palette(colorRampPalette(rainbow(9))(length(levels(as.factor(taxa.vec)))))
  palette(colorRampPalette(brewer.pal(8,"Spectral"))(length(levels(as.factor(taxa.vec)))))
  (theme_foundation(base_size=12)
   + theme(plot.title = element_text(face = "bold",
                                     size = rel(1.2), hjust = 0.5),
           text = element_text(),
           panel.background = element_rect(colour = NA),
           plot.background = element_rect(colour = NA),
           panel.border = element_rect(colour = NA),
           axis.title = element_text(face = "bold",size = rel(1)),
           axis.title.y = element_text(face="bold",size=16),
           axis.title.x = element_blank(),
           axis.text.y = element_text(size=12), 
           axis.text.x = element_blank(),
           axis.line.x = element_blank(),
           axis.ticks.x = element_line(size=5,colour=as.factor(taxa.vec)),
           axis.ticks.length = unit(1, "cm"),
           axis.ticks.y = element_blank(),
           panel.grid.major = element_blank(),
           panel.grid.minor = element_blank(),
           legend.position = "right",
           legend.direction = "vertical",
           legend.key.size= unit(1, "cm"),
           legend.margin = unit(1, "cm"),
           plot.margin=unit(c(1,10,1,30),"mm"),
           strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
           strip.text = element_text(size=6)
   ))
}




