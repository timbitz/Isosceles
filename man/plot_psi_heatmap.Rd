% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_psi_heatmap.R
\name{plot_psi_heatmap}
\alias{plot_psi_heatmap}
\title{Plot a PSI heatmap}
\usage{
plot_psi_heatmap(
  se_psi,
  gene_id,
  heatmap_colors = viridis::cividis(100),
  region_colors = NULL,
  ...
)
}
\arguments{
\item{se_psi}{A PSI SummarizedExperiment object returned by the
\code{\link{transcript_to_psi}} function.}

\item{gene_id}{A string containing the identifier of the gene to plot.}

\item{heatmap_colors}{A character vector containing the color palette used
in the heatmap.}

\item{region_colors}{A named character vector of colors for the region type
annotations.}

\item{\dots}{Additional parameters for the plot, passed to the
\code{\link{pheatmap}} function.}
}
\value{
A plot object.
}
\description{
Creates a heatmap of PSI (Percent Spliced In) values for the regions of a
given gene across samples or cells.
}
