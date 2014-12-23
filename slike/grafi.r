pdf("slike/grafi.pdf",paper="a4")
barplot(PODTABELAPOPOZICIJAH[1:19,'NASTOPI.PO.POZICIJAH'], names.arg = imenapozicij,xlab="POZICIJA", ylab="ŠTEVILO NASTOPOV", main= 'ŠTEVILO NASTOPOV GLEDE NA POZICIJO', las=2, cex.names=0.75, col="red")
dev.off()

