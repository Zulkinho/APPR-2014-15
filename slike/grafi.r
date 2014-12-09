pdf("slike/grafi.pdf",paper="a4")
barplot(PODTABELAPOPOZICIJAH[1:19,5], names.arg = imenapozicij,xlab="POZICIJA", ylab="ŠTEVILO NASTOPOV", main= 'ŠTEVILO NASTOPOV GLEDE NA POZICIJO', col="red")
dev.off()


pdf("slike/grafi1.pdf",paper="a4")
barplot(NOGOMETASI[1:209,6], names.arg = 1:209,xlab="NOGOMETAŠ", ylab="ŠTEVILO ZADETKOV",legend = c('št. pomeni zaporedno št. vrstice'), main= 'ŠTEVILO ZADETKOV VSAKEGA NOGOMETAŠA', col="red")
dev.off()