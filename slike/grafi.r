cairo_pdf("slike/grafi.pdf",family = "Arial")
barplot(UREJENAPODTABELA[1:19,'NASTOPI.PO.POZICIJAH'], names.arg = rownames(UREJENAPODTABELA),xlab="POZICIJA", ylab="ŠTEVILO NASTOPOV", main= 'ŠTEVILO NASTOPOV GLEDE NA POZICIJO', las=2, cex.names=0.75, col="red")
dev.off()

cairo_pdf("slike/grafi1.pdf",family = "Arial")
a<-rownames(NOGOMETASI)
barplot(NOGOMETASI[NOGOMETASI$ZADETKI>100,'ZADETKI'],names.arg = a[NOGOMETASI$ZADETKI>100], ylab="ŠTEVILO ZADETKOV", main= 'ŠTEVILO ZADETKOV IGRALCEV, KI SO ZADELI VEČ KOT 100-KRAT', las=2, cex.names=0.6, col="red")
dev.off()
