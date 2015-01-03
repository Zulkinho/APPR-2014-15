pdf("slike/grafi.pdf",paper="a4")
barplot(UREJENAPODTABELA[1:19,'NASTOPI.PO.POZICIJAH'], names.arg = rownames(UREJENAPODTABELA),xlab="POZICIJA", ylab="ŠTEVILO NASTOPOV", main= 'ŠTEVILO NASTOPOV GLEDE NA POZICIJO', las=2, cex.names=0.75, col="red")
dev.off()

pdf("slike/grafi1.pdf",paper="a4")
barplot(NOGOMETASI[ZADETKI>100,'ZADETKI'],xlab="IGRALEC", ylab="ŠTEVILO ZADETKOV", main= 'ŠTEVILO ZADETKOV IGRALCEV, KI SO ZADELI VEČ KOT 100-KRAT', las=2, cex.names=0.75, col="red")
dev.off()
