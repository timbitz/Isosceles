% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/export_gtf.R
\name{export_gtf}
\alias{export_gtf}
\title{Export data to a GTF file}
\usage{
export_gtf(se, file)
}
\arguments{
\item{se}{A transcript-level SummarizedExperiment object returned by the
\code{\link{tcc_to_transcript}} function.}

\item{file}{A string specifying the output file path.}
}
\value{
Nothing is returned.
}
\description{
Exports transcripts from a SummarizedExperiment to a GTF file.
}
