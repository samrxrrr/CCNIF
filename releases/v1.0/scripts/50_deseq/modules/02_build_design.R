build_design <- function(driver_gene, mutation, clinical){

    if(!(driver_gene %in% colnames(mutation))){
        stop(paste("Driver gene not found:", driver_gene))
    }

    status <- mutation[, driver_gene]

    design <- data.frame(
        patient_id = rownames(mutation),
        mutation_status = ifelse(status == 1, "Mutant", "WildType"),
        stringsAsFactors = FALSE
    )

    design <- merge(
        design,
        clinical,
        by = "patient_id",
        sort = FALSE
    )

    design$mutation_status <- factor(
        design$mutation_status,
        levels = c("WildType", "Mutant")
    )

    design
}
