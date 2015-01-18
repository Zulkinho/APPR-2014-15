# 3. faza: Izdelava zemljevida
# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")
# Uvozimo zemljevid.
cat("Uvazam zemljevid sveta...\n")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_map_units.zip",
                        "svet", "ne_110m_admin_0_map_units.shp", mapa = "zemljevid",
                        encoding = "Windows-1252")
svet1<- svet[svet$continent %in% c("Europe", "Africa","South America","Asia","North America"),]

drzave <- table(nogometasi$DRZAVA)
names(drzave)[16] <- "Russian Federation"
names(drzave)[11] <- "Côte d'Ivoire"
imenadrzav<-names(drzave)
stevilo <- unique(drzave)
stevilo <- stevilo[order(stevilo)]
barve <- topo.colors(length(stevilo))[match(drzave, stevilo)]
names(barve) <- names(drzave)
barve.zemljevid <- barve[as.character(svet1$name_long)]
barve.zemljevid[is.na(barve.zemljevid)] <- "white"

mojsvet <- svet1[svet1$name_long %in% imenadrzav,]
koordinate <- coordinates(mojsvet)
imena.drzav <- as.character(mojsvet$name_long)
imena.drzav1 <- as.character(mojsvet1$name_long)

rownames(koordinate) <- imena.drzav
koordinate["Spain",2] <- koordinate["Spain",2]+1.5
koordinate["Brazil",1] <- koordinate["Brazil",1]+2.0
koordinate["Brazil",2] <- koordinate["Brazil",2]+2.0
koordinate["Nigeria",2] <- koordinate["Nigeria",2]+2.0
koordinate["Cameroon",2] <- koordinate["Cameroon",2]+1.3
koordinate["Cameroon",1] <- koordinate["Cameroon",1]-1.0
koordinate["Scotland",2] <- koordinate["Scotland",2]+2.3
koordinate["Northern Ireland",2] <- koordinate["Northern Ireland",2]+3.1
koordinate["Northern Ireland",1] <- koordinate["Northern Ireland",1]-2.0
koordinate["Ireland",2] <- koordinate["Ireland",2]+2.0
koordinate["Ireland",1] <- koordinate["Ireland",1]+0.2
koordinate["England",2] <- koordinate["England",2]+1.8
koordinate["England",1] <- koordinate["England",1]+0.5
koordinate["Wales",2] <- koordinate["Wales",2]+1.2
koordinate["Wales",1] <- koordinate["Wales",1]-2.3
koordinate["Sweden",1] <- koordinate["Sweden",1]-1.7
koordinate["Poland",2] <- koordinate["Poland",2]+2.0
koordinate["Germany",2] <- koordinate["Germany",2]+2.0
koordinate["Belarus",2] <- koordinate["Belarus",2]+2.0
koordinate["Ukraine",2] <- koordinate["Ukraine",2]+2.0
koordinate["Czech Republic",2] <- koordinate["Czech Republic",2]+1.9
koordinate["Czech Republic",1] <- koordinate["Czech Republic",1]+0.3
koordinate["Switzerland",2] <- koordinate["Switzerland",2]+1.9
koordinate["France",2] <- koordinate["France",2]+2.0
koordinate["Russian Federation",1] <- koordinate["Russian Federation",1]-56.0
koordinate["Russian Federation",2] <- koordinate["Russian Federation",2]-2.5
koordinate["Côte d'Ivoire",2] <- koordinate["Côte d'Ivoire",2]+1.7
koordinate["Netherlands",2] <- koordinate["Netherlands",2]+3.5
koordinate["Netherlands",1] <- koordinate["Netherlands",1]-1.8
koordinate["Denmark",2] <- koordinate["Denmark",2]+2.8
koordinate["Denmark",1] <- koordinate["Denmark",1]-2.8
koordinate["Togo",2] <- koordinate["Togo",2]-0.9
koordinate["Togo",1] <- koordinate["Togo",1]+0.9
koordinate["Belgium",2] <- koordinate["Belgium",2]+2.2
stadion<-data.frame("long" = c(-0.108611), "lat"= c(51.555))

pdf("slike/igralci.pdf", width=8.27, height=11.96)
plot(svet1, xlim=c(-69, 50), ylim=c(-33,73), col=barve.zemljevid, bg="lightblue")
text(koordinate,labels=imena.drzav,pos = 1, cex = 0.25,)
#text(koordinate["Wales",1],koordinate["Wales",2],labels="Wales",srt = 90, cex = 0.25)
points(coordinates(stadion), type = "p", pch = 1, cex = 0.1, col = "red")
legend("topleft", title = 'število igralcev po državah', text.font = 3,legend = stevilo, fill = topo.colors(length(stevilo)))
dev.off()
