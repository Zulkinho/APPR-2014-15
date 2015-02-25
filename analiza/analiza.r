#uvozim tabelo ZADNJIH50 
ZADNJIH50<-read.csv2("podatki/zadnjih50.csv",
                     skip=0,
                     row.name=1,
                     header=TRUE,
                     na.strings = "-",
                     fileEncoding = "Windows-1252")


#razdelitev v 4 skupine glede na kariero v vseh pomenih, iščemo kdo je bil najboljši
normaliziran <- scale(as.matrix(ZADNJIH50[c(4:5, 7:13)]))
matrikarazdalj<-dist(normaliziran)
razdelitev<- hclust(matrikarazdalj, method = "complete")

pdf("slike/najboljsi.pdf")
plot(razdelitev, hang=-1, cex=0.6, main = "USPEŠNOST")
rect.hclust(razdelitev,k=4,border="red")
dev.off()
#iz grafa vidimo kdo sta nogometaša, ki sta se v svoji karieri najbol izkazala ter na vseh področjih kot celoti dosegla najboljše rezultate
#to sta Henry in Bergkamp
#preverimo če to res drži

p <- cutree(razdelitev, k=4)
barve=c("red", "green", "blue","yellow")
table(p)
barve

pdf("slike/najboljsi1.pdf")
pairs(normaliziran, col = barve[p])
dev.off()
#graf prikazuje položaje osamelcev na pram ostalim
#vidimo da sta to rdeča krogca

ZADNJIH50[p %in% c(1),]
#potrditev, da Henry in Bergkamp najbol izstopata, sta osamelca 


#sedaj nas pa zanima kdo je 3. po dosežkih v svoji karieri neglede na klub
# da ga najdemo uporabimo metodo enojnega povezovanja in graf razdelimo na 4 skupine

razdelitev1 <- hclust(matrikarazdalj, method = "single")

pdf("slike/najboljsi2.pdf")
plot(razdelitev1, hang=-1, cex=0.6, main = "USPEŠNOST 1")
rect.hclust(razdelitev1,k=4,border="red")
dev.off()
#iz grafa vidimo, da je to Robin van Persie, poleg pa graf še dodatno potrjuje katera dva sta najboljša

#tako lahko trdimo, da so trije najboljši igralci med zadnjimi pedesetimi Henry,Bergkamp in van Persie

#poglejmo si sedaj kdo pa je bil najboljši za Arsenal
#normiliziral bom sedaj le dolžino kariere v Arsenalu, zadetke za Arsenal, ter nastope za Arsenal saj je to le bistvo projekta(analiza Arsenala)
norm <- scale(as.matrix(ZADNJIH50[c(7:8, 10)]))
matrikarazdalj1<-dist(norm)
razdelitev2 <- hclust(matrikarazdalj1, method = "single")

pdf("slike/najboljsiArsenal.pdf")
plot(razdelitev2, hang=-1, cex=0.6, main = "USPEŠNPST ARSENAL")
rect.hclust(razdelitev2,k=4,border="red")
dev.off()
#graf trdi da najbol izstopa Henry, Bergkamp za njim, 3. najboljši igralec pa naj bi spet bil van Persie  
#poglejmo če to drži

p1<- cutree(razdelitev2, k=4)
table(p1)
barve

pdf("slike/najboljsiArsenal1.pdf")
pairs(norm, col = barve[p1])
dev.off()
#vidimo, da najbolj odstopa rdeči, rumeni in modri krogec(so osamelci)
#iz grafov vidimo, da modri krogec predstavlja Henrya, rdeči Bergkampa, rumeni pa van Persie-ja in stem potrjuje trditev o kvaliteti igralcev znotraj kluba

ZADNJIH50[p1 %in% c(1,3,4),]
#še ena potrditev kateri trije nogometaši so si izborili mesto med top 3


#uvozim tabelo ARSENALSTATISTIKA, ki prikazuje statistiko Arsenala v zadnjih 10 sezona v Barclay Premier League 
#na osnovi te tabele bom naredil napoved 
ARSENALSTATISTIKA<-read.csv("podatki/arsenalstatistika.csv",
                     skip=0,
                     row.name=1,
                     header=TRUE,
                     na.strings = "-",
                     fileEncoding = "Windows-1252")


leta<-row.names(ARSENALSTATISTIKA)
leta<-as.numeric(leta)
tocke<-ARSENALSTATISTIKA$TOCKE  
#plot(leta, govedo, xlab="Leto", ylab="Točke")

#funikcija za linearno rast
lin<-lm(tocke~leta)
#abline(lin, col="red")

#preverimo če je število točk kvadratna funkcija
kvad<-lm(tocke~I(leta^2)+leta)
#curve(predict(kvad, data.frame(leta=x)),add=TRUE,col="blue")

#model Loess
loess<-loess(tocke~leta)
#curve(predict(loess, data.frame(leta=x)),add=TRUE,col="green")

<<<<<<< HEAD
=======
#model Loess
loess<-loess(tocke~leta)
#curve(predict(loess, data.frame(leta=x)),add=TRUE,col="green")

>>>>>>> f0a9658dfcadc334747b4ecde3a91f526e040a4f
#model gam
library(mgcv)
gam<-gam(tocke~s(leta))
#curve(predict(loess, data.frame(leta=x)),add=TRUE,col="green")
#vidimo da se gam ujema z linearno medoto zato le te ne upostevamo več saj bo napoved enako kot pri linearni metodi

#pogledamo ostanke pri teh modelih
#ostanki<-sapply(list(lin, kvad, loess,gam), function(x) sum(x$residuals^2))
#ostanki
#ostanki gam in lin so enaki

#napoved za število točk do leta 2024 po različnih modelih
pdf("slike/napoved.pdf")
napoved<-function(x,model){predict(model,data.frame(leta=x))}
plot(leta,tocke,xlim=c(2005,2024),ylim=c(60,114),
     xlab="Leto",ylab="Število točk ob koncu prvenstva",
     main="Napoved za število točk ob koncu prvenstva do leta 2024")
curve(napoved(x, lin), add=TRUE,col="red")
curve(napoved(x, kvad), add=TRUE, col="blue")
<<<<<<< HEAD
curve(napoved(x, loess), add=TRUE, col="green")
=======
>>>>>>> f0a9658dfcadc334747b4ecde3a91f526e040a4f
legend("topright", c("Linerana metoda", "Kvadratna metoda"),lty=c(1,1), col = c("red","blue"))
dev.off()


# # 4. faza: Analiza podatkov
# 
# # Uvozimo funkcijo za uvoz spletne strani.
# source("lib/xml.r")
# 
# # Preberemo spletno stran v razpredelnico.
# cat("Uvažam spletno stran...\n")
# tabela <- preuredi(uvozi.obcine(), obcine)
# 
# # Narišemo graf v datoteko PDF.
# cat("Rišem graf...\n")
# pdf("slike/naselja.pdf", width=6, height=4)
# plot(tabela[[1]], tabela[[4]],
#      main = "Število naselij glede na površino občine",
#      xlab = "Površina (km^2)",
#      ylab = "Št. naselij")
# dev.off()