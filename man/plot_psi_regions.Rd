% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_psi_regions.R
\name{plot_psi_regions}
\alias{plot_psi_regions}
\title{Plot PSI regions}
\usage{
plot_psi_regions(
  se_psi,
  se_transcript,
  gene_id,
  max_transcripts = Inf,
  max_intron_length = NULL,
  region_colors = NULL
)
}
\arguments{
\item{se_psi}{A PSI SummarizedExperiment object returned by the
\code{\link{transcript_to_psi}} function.}

\item{se_transcript}{A transcript-level SummarizedExperiment object returned
by the \code{\link{tcc_to_transcript}} function.}

\item{gene_id}{A string containing the identifier of the gene to plot.}

\item{max_transcripts}{An integer scalar specifying the maximum number of
transcripts with the highest relative expression to plot.}

\item{max_intron_length}{An integer scalar specifying the maximum intron
length after shrinking. If set to NULL, no shrinking is performed.}

\item{region_colors}{A named character vector of colors for the PSI region
types.}
}
\value{
A plot object.
}
\description{
Creates a plot showing PSI regions and transcript structures for the given
gene. Individual transcript structures are colored by their relative
expression, calculated from the overall TPM values and expressed in
percentages. For better visualization, introns can be shrinked using the
max_intron_length argument.
}
