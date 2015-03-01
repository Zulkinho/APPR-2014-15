#uvozim tabelo ZADNJIH50 
ZADNJIH50<-read.csv2("podatki/zadnjih50.csv",
                     skip=0,
                     row.name=1,
                     header=TRUE,
                     na.strings = "-",
                     fileEncoding = "Windows-1252")


#razdelitev v 4 skupine glede na kariero v vseh pomenih, iščem kdo je bil najboljši
normaliziran <- scale(as.matrix(ZADNJIH50[c(4:5, 7:13)]))
matrikarazdalj<-dist(normaliziran)
razdelitev<- hclust(matrikarazdalj, method = "complete")

cairo_pdf("slike/najboljsi.pdf",family = "Arial")
plot(razdelitev, hang=-1, cex=0.6, main = "USPEŠNOST")
rect.hclust(razdelitev,k=4,border="red")
dev.off()
#iz grafa vidim kdo sta nogometaša, ki sta se v svoji karieri najbol izkazala ter na vseh področjih kot celoti
#to sta Henry in Bergkamp
#preverim če to res drži

p <- cutree(razdelitev, k=4)
barve=c("red", "green", "blue","yellow")
table(p)
barve

cairo_pdf("slike/najboljsi1.pdf",family = "Arial")
pairs(normaliziran, col = barve[p])
dev.off()
#graf prikazuje položaje osamelcev na pram ostalim
#vidim da sta to rdeča krogca

ZADNJIH50[p %in% c(1),]
#potrditev, da Henry in Bergkamp najbol izstopata, sta osamelca 


#sedaj nas pa zanima kdo je 3. po dosežkih v svoji karieri neglede na klub
# da ga najdemo uporabimo metodo enojnega povezovanja in graf razdelimo na 4 skupine

razdelitev1 <- hclust(matrikarazdalj, method = "single")

cairo_pdf("slike/najboljsi2.pdf",family = "Arial")
plot(razdelitev1, hang=-1, cex=0.6, main = "USPEŠNOST 1")
rect.hclust(razdelitev1,k=4,border="red")
dev.off()
#iz grafa vidim, da je to Robin van Persie, poleg pa graf še dodatno potrjuje katera dva sta najboljša

#tako lahko trdimo, da so trije najboljši igralci med zadnjimi pedesetimi Henry,Bergkamp in van Persie

##poglejmo sedaj še ward metodo za igralce v celotni karieri
razdelitev4 <- hclust(matrikarazdalj, method = "ward")
cairo_pdf("slike/najboljsi3.pdf",family = "Arial")
plot(razdelitev4, hang=-1, cex=0.6, main = "USPEŠNOST")
rect.hclust(razdelitev4,k=6,border="red")
dev.off()
skupine <- cutree(razdelitev4, k=6)
#skupine bom karakteriziral v poročilu

#poglejmo si sedaj kdo pa je bil najboljši za Arsenal
#normiliziral bom sedaj le dolžino kariere v Arsenalu, zadetke za Arsenal, ter nastope za Arsenal saj je to le bistvo projekta(analiza Arsenala)
norm <- scale(as.matrix(ZADNJIH50[c(7:8, 10)]))
matrikarazdalj1<-dist(norm)
razdelitev2 <- hclust(matrikarazdalj1, method = "single")

cairo_pdf("slike/najboljsiArsenal.pdf",family = "Arial")
plot(razdelitev2, hang=-1, cex=0.6, main = "USPEŠNOST V ARSENALU")
rect.hclust(razdelitev2,k=4,border="red")
dev.off()
#graf trdi da najbol izstopa Henry, Bergkamp za njim, 3. najboljši igralec pa naj bi spet bil van Persie  
#pogledam če to drži

p1<- cutree(razdelitev2, k=4)
table(p1)
barve

cairo_pdf("slike/najboljsiArsenal1.pdf",family = "Arial")
pairs(norm, col = barve[p1])
dev.off()
#vidimo, da najbolj odstopa rdeči, rumeni in modri krogec(so osamelci)
#iz grafov vidim, da modri krogec predstavlja Henrya, rdeči Bergkampa, rumeni pa van Persie-ja in stem potrjuje trditev o kvaliteti igralcev znotraj kluba

ZADNJIH50[p1 %in% c(1,3,4),]
#še ena potrditev kateri trije nogometaši so si izborili mesto med top 3

#poglejmo sedaj še ward metodo za igralce v Arsenalu
razdelitev3 <- hclust(matrikarazdalj1, method = "ward")
cairo_pdf("slike/najboljsiArsenal2.pdf",family = "Arial")
plot(razdelitev3, hang=-1, cex=0.6, main = "USPEŠNOST V ARSENALU")
rect.hclust(razdelitev3,k=6,border="red")
dev.off()
skupine1 <- cutree(razdelitev3, k=6)
#skupine bom karakteriziral v poročilu

#uvozim tabelo ARSENALSTATISTIKA, ki prikazuje statistiko Arsenala v zadnjih 10 sezona v Barclay Premier League 
#na osnovi te tabele bom naredil napoved 
ARSENALSTATISTIKA<-read.csv("podatki/arsenalstatistika.csv",
                            skip=0,
                            row.name=1,
                            header=TRUE,
                            na.strings = "-",
                            fileEncoding = "Windows-1252")

#napoved za dane zadetke do leta 2024
leta<-row.names(ARSENALSTATISTIKA)
leta<-as.numeric(leta)
danigoli<-ARSENALSTATISTIKA$DANI.ZADETKI 
#plot(leta, danigoli, xlab="Leto", ylab="Dani zadetki")

#funikcija za linearno rast
lin<-lm(danigoli~leta)
#abline(lin, col="red")

#preverimo če je število danih zadetkov kvadratna funkcija
kvad<-lm(danigoli~I(leta^2)+leta)
#curve(predict(kvad, data.frame(leta=x)),add=TRUE,col="blue")

#model Loess
loess<-loess(danigoli~leta)
#curve(predict(loess, data.frame(leta=x)),add=TRUE,col="magenta")

#model gam
library(mgcv)
gam<-gam(danigoli~s(leta))
#curve(predict(gam, data.frame(leta=x)),add=TRUE,col="green")

#pogledamo ostanke pri teh modelih
#ostanki<-sapply(list(lin, kvad, loess,gam), function(x) sum(x$residuals^2))
#ostanki
#vidimo,da je najmanjši ostanek pri metodi loess, vendar z njo ne bom delal napovedi, sledi gam s katero bom med drugim delal napoved 

#napoved za število danih zadetkov do leta 2024 po različnih modelih
cairo_pdf("slike/napoved.pdf",family = "Arial")
napoved<-function(x,model){predict(model,data.frame(leta=x))}
plot(leta,danigoli,xlim=c(2005,2024),ylim=c(35,100),
     xlab="Leto",ylab="Število danih zadetkov",
     main="Napoved za število danih zadetkov ob koncu prvenstva do leta 2024")
curve(napoved(x, lin), add=TRUE,col="red")
curve(napoved(x, kvad), add=TRUE, col="blue")
curve(napoved(x, gam), add=TRUE, col="green")
text(2006.5,37,paste0(round(lin$coefficients[1],2),round(lin$coefficients[2],2),"x"),cex=1.0)
text(2008.2,35,paste0(round(kvad$coefficients[1],2),round(kvad$coefficients[2],2),"x",round(kvad$coefficients[3],2),"x^2"),cex=1.0)
legend("topleft", c("Linerana metoda", "Kvadratna metoda","Gam metoda"),lty=c(1,1), col = c("red","blue","green"))
dev.off()

#napoved za prejete zadetke za naslednjih 10 sezon
prejetigoli<-ARSENALSTATISTIKA$PREJETI.ZADETKI 
#plot(leta, prejetigoli, xlab="Leto", ylab="Dani zadetki")

#funikcija za linearno rast
lin1<-lm(prejetigoli~leta)
#abline(lin1, col="red")

#preverimo če je število prejetih zadetkov kvadratna funkcija
kvad1<-lm(prejetigoli~I(leta^2)+leta)
#curve(predict(kvad1, data.frame(leta=x)),add=TRUE,col="blue")

#model Loess
loess1<-loess(prejetigoli~leta)
#curve(predict(loess1, data.frame(leta=x)),add=TRUE,col="magenta")

#model gam
library(mgcv)
gam1<-gam(prejetigoli~s(leta))
#curve(predict(gam1, data.frame(leta=x)),add=TRUE,col="green")

#pogledamo ostanke pri teh modelih
#ostanki1<-sapply(list(lin1,kvad1,loess1,gam1), function(x) sum(x$residuals^2))
#ostanki1

#napoved za število prejetih zadetkov do leta 2024 po različnih modelih
cairo_pdf("slike/napoved1.pdf",family = "Arial")
napoved<-function(x,model){predict(model,data.frame(leta=x))}
plot(leta,prejetigoli,xlim=c(2005,2024),ylim=c(20,60),
     xlab="Leto",ylab="Število prejetih zadetkov",
     main="Napoved za število prejetih zadetkov ob koncu prvenstva do leta 2024")
curve(napoved(x, lin1), add=TRUE,col="red")
curve(napoved(x, kvad1), add=TRUE, col="blue")
curve(napoved(x, gam1), add=TRUE, col="green")
text(2006.5,22,paste0(round(lin1$coefficients[1],2),round(lin1$coefficients[2],2),"x"),cex=1.0)
text(2008.2,20,paste0(round(kvad1$coefficients[1],2),round(kvad1$coefficients[2],2),"x",round(kvad1$coefficients[3],2),"x^2"),cex=1.0)
legend("topleft", c("Linerana metoda", "Kvadratna metoda","Gam metoda"),lty=c(1,1), col = c("red","blue","green"))
dev.off()


