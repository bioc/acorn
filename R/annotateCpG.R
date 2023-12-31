annotateCpG <- function(DNVobject = NULL, CpGannot = NULL) {

if(is.null(DNVobject) | is.null(CpGannot)){
    message("missing datasets")
    } else {

    snvs <- extractSNVs(DNVobject)
    snvs$matcher <- paste(snvs[,2], snvs[,3], sep="_")

    CpGannotFile <- CpGannot

    CpGannotFile <- as.data.frame(CpGannotFile)
    CpGannotFile$matcher1 <- paste(CpGannotFile$V1, CpGannotFile$V3, sep="_")
    CpGannotFile$prepMatcher <- CpGannotFile$V3-1
    CpGannotFile$matcher2 <- paste(CpGannotFile$V1, CpGannotFile$prepMatcher, sep="_")

    cpg1 <- snvs[which(snvs$matcher %in% CpGannotFile$matcher1),]
    cpg1$cpg <- "yes"

    cpg2 <- snvs[which(snvs$matcher %in% CpGannotFile$matcher2),]
    cpg2$cpg <- "yes"

    cpg <- rbind(cpg1, cpg2)

    notcpg <- snvs[!(snvs$matcher %in% cpg$matcher),]
    notcpg$cpg <- "no"

    annotated <- rbind(cpg, notcpg)
    message("The number of DNVs at CpG sites is: ", nrow(cpg), "\n", sep="")
    message("The total number of SNVs is: ", nrow(snvs), "\n", sep="")
    message("The percent of DNV that are SNVs at CpG sites is: ", (nrow(cpg)/nrow(snvs))*100, "\n", sep="")

    annotated
    }
}
