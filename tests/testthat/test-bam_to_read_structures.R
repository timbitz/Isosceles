test_that("bam_to_read_structures works as expected", {

    # Preparing test data
    bam_file <- system.file(
        "extdata", "bulk_rnaseq.bam",
        package = "Isosceles"
    )

    # Testing if function throws the expected errors
    expect_error(bam_to_read_structures(bam_files = NULL),
                 regexp = "bam_files is not a character vector",
                 fixed = TRUE)
    expect_error(bam_to_read_structures(bam_files = character(0)),
                 regexp = "length(bam_files) not greater than 0",
                 fixed = TRUE)
    expect_error(bam_to_read_structures(bam_files = "jabberwocky"),
                 regexp = "Elements 1 of file.exists(bam_files) are not true",
                 fixed = TRUE)
    expect_error(bam_to_read_structures(bam_files = bam_file,
                                        chunk_size = NULL),
                 regexp = "chunk_size is not a count",
                 fixed = TRUE)
    expect_error(bam_to_read_structures(bam_files = bam_file,
                                        ncpu = NULL),
                 regexp = "ncpu is not a count",
                 fixed = TRUE)

    # Testing if function returns the expected output
    expect_message(bam_data <- bam_to_read_structures(bam_files = bam_file),
                   regexp = "read_id",
                   fixed = TRUE)
    expect_true(is.data.frame(bam_data))
    expect_identical(dim(bam_data), c(74L, 5L))
    expect_identical(length(bam_data$intron_positions),
                     length(unique(bam_data$intron_positions)))
    expect_identical(colnames(bam_data),
                     c("intron_positions", "read_count", "chromosome",
                       "start_positions", "end_positions"))
})
