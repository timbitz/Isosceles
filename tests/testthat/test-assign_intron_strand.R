test_that("assign_intron_strand works as expected", {

    # Preparing test data
    bam_file <- system.file(
        "extdata", "bulk_rnaseq.bam",
        package = "Isosceles"
    )
    gtf_file <- system.file(
        "extdata", "bulk_rnaseq.gtf",
        package = "Isosceles"
    )
    genome_fasta_file <- system.file(
        "extdata", "bulk_rnaseq.fa",
        package = "Isosceles"
    )
    anno_data <- prepare_reference_annotations(gtf_file)
    bam_data <- bam_to_read_structures(bam_file)
    intron_granges <- bam_data$intron_positions %>%
        strsplit(",") %>%
        unlist() %>%
        unique() %>%
        methods::as("GRanges") %>%
        GenomicRanges::sort()

    # Testing if function throws the expected errors
    expect_error(assign_intron_strand(intron_granges = NULL),
                 regexp = "methods::is(object = intron_granges, class2 =",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = NULL),
                 regexp = "anno_data is not a list",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = list()),
                 regexp = "anno_data does not have all of these name(s): 'intron_df'",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = list(intron_df = 1)),
                 regexp = "anno_data$intron_df is not a data frame",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = anno_data,
                                      genome_fasta_file = NULL),
                 regexp = "genome_fasta_file is not a string",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = anno_data,
                                      genome_fasta_file = "jabberwocky"),
                 regexp = "Path 'jabberwocky' does not exist",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = anno_data,
                                      genome_fasta_file = genome_fasta_file,
                                      min_intron_length = NULL),
                 regexp = "min_intron_length is not a count",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = anno_data,
                                      genome_fasta_file = genome_fasta_file,
                                      max_intron_length = NULL),
                 regexp = "max_intron_length is not a count",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = anno_data,
                                      genome_fasta_file = genome_fasta_file,
                                      known_intron_motifs = NULL),
                 regexp = "known_intron_motifs is not a character vector",
                 fixed = TRUE)
    expect_error(assign_intron_strand(intron_granges = intron_granges,
                                      anno_data = anno_data,
                                      genome_fasta_file = genome_fasta_file,
                                      rescue_annotated_introns = NULL),
                 regexp = "rescue_annotated_introns is not a flag",
                 fixed = TRUE)

    # Testing if function returns the expected output (case 1)
    expect_silent(
        intron_granges_stranded <- assign_intron_strand(
            intron_granges = intron_granges, anno_data = anno_data,
            genome_fasta_file = genome_fasta_file, min_intron_length = 30,
            rescue_annotated_introns = FALSE
        )
    )
    expect_identical(BiocGenerics::unstrand(intron_granges_stranded),
                     intron_granges)
    expect_identical(
        names(table(BiocGenerics::strand(intron_granges_stranded))),
        c("+", "-", "*")
    )
    expect_identical(
        as.numeric(table(BiocGenerics::strand(intron_granges_stranded))),
        c(36, 46, 4)
    )

    # Testing if function returns the expected output (case 2)
    expect_silent(
        intron_granges_stranded <- assign_intron_strand(
            intron_granges = intron_granges, anno_data = anno_data,
            genome_fasta_file = genome_fasta_file, min_intron_length = 100,
            rescue_annotated_introns = FALSE
        )
    )
    expect_identical(BiocGenerics::unstrand(intron_granges_stranded),
                     intron_granges)
    expect_identical(
        names(table(BiocGenerics::strand(intron_granges_stranded))),
        c("+", "-", "*")
    )
    expect_identical(
        as.numeric(table(BiocGenerics::strand(intron_granges_stranded))),
        c(36, 45, 5)
    )

    # Testing if function returns the expected output (case 3)
    expect_silent(
        intron_granges_stranded <- assign_intron_strand(
            intron_granges = intron_granges, anno_data = anno_data,
            genome_fasta_file = genome_fasta_file, min_intron_length = 100,
            rescue_annotated_introns = TRUE
        )
    )
    expect_identical(BiocGenerics::unstrand(intron_granges_stranded),
                     intron_granges)
    expect_identical(
        names(table(BiocGenerics::strand(intron_granges_stranded))),
        c("+", "-", "*")
    )
    expect_identical(
        as.numeric(table(BiocGenerics::strand(intron_granges_stranded))),
        c(36, 45, 5)
    )

    # Testing if function returns the expected output (case 4)
    expect_silent(
        intron_granges_stranded <- assign_intron_strand(
            intron_granges = intron_granges, anno_data = anno_data,
            genome_fasta_file = genome_fasta_file,
            min_intron_length = 100, max_intron_length = 1000,
            rescue_annotated_introns = TRUE
        )
    )
    expect_identical(BiocGenerics::unstrand(intron_granges_stranded),
                     intron_granges)
    expect_identical(
        names(table(BiocGenerics::strand(intron_granges_stranded))),
        c("+", "-", "*")
    )
    expect_identical(
        as.numeric(table(BiocGenerics::strand(intron_granges_stranded))),
        c(17, 31, 38)
    )
})
