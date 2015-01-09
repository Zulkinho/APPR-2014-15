# 2. faza: Uvoz podatkov


# Funkcija, ki uvozi podatke iz datoteke tabelanogometasev.csv
uvozitabelaigralcev <- function() {
  return(read.csv("podatki/tabelanogometasev.csv",
                  skip=0,
                  header=TRUE,
                  row.names = 1,
                  na.strings = "-",
                   fileEncoding = "Windows-1252"))
}

# Zapisimo podatke v razpredelnico nogometasi.
cat("Uvažam podatke o nogometaših...\n")
nogometasi <- uvozitabelaigralcev()

attach(nogometasi)
kategorije<-c('Začetnik v Arsenalu','Izkušen Arsenalovec','Arsenalova legenda')
STATUSS<-character(nrow(nogometasi))
STATUSS[NASTOPI <150]<-'Začetnik v Arsenalu'
STATUSS[NASTOPI >=150 & NASTOPI<300]<-'Izkušen Arsenalovec'
STATUSS[NASTOPI >=300]<-'Arsenalova legenda'
STATUS<-factor(STATUSS,levels=kategorije,ordered=TRUE)
detach(nogometasi)
NOGOMETASI<-data.frame(nogometasi, STATUS)
rm("STATUS")

#dodatna tabela
attach(NOGOMETASI)
pozicija<-c(table(POZICIJA))
imenapozicij<-names(pozicija)

prevodi<-character(0)
prevodi[imenapozicij="CB"]='Osrednji branilec'
prevodi[imenapozicij="CB/LB"]='Osrednji branilec/Levi bočni branilec'
prevodi[imenapozicij="CB/MF"]='Osrednji branilec/Vezist'
prevodi[imenapozicij="FW"]='Napadelec'
prevodi[imenapozicij="FW/MF"]='Napadelec/Vezist'
prevodi[imenapozicij="FW/RW"]='Napadelec/Desni bočni napadalec'
prevodi[imenapozicij="GK"]='Vratar'
prevodi[imenapozicij="LB"]='Levi bočni branilec'
prevodi[imenapozicij="LB/MF"]='Levi bočni branilec/Vezist'
prevodi[imenapozicij="LW"]='Levi bočni napadalec'
prevodi[imenapozicij="LW/MF"]='Levi bočni napadalec/Vezist'
prevodi[imenapozicij="MF"]='Vezist'
prevodi[imenapozicij="RB"]='Desni bočni branilec'
prevodi[imenapozicij="RB/LB"]='Desni bočni branilec/Levi bočni branilec'
prevodi[imenapozicij="RB/MF"]='Desni bočni branilec/Vezist'
prevodi[imenapozicij="RW"]='Desni bočni napadalec'
prevodi[imenapozicij="RW/FW"]='Desni bočni napadalec/Napadelec'
prevodi[imenapozicij="RW/LW"]='Desni bočni napadalec/Levi bočni napadalec'
prevodi[imenapozicij="RW/MF"]='Desni bočni napadalec/Vezist'

daljšizapis<-character(0)
daljšizapis[imenapozicij="CB"]='Centre back'
daljšizapis[imenapozicij="CB/LB"]='Centre back/Left back'
daljšizapis[imenapozicij="CB/MF"]='Centre back/Midfielder'
daljšizapis[imenapozicij="FW"]='Forward'
daljšizapis[imenapozicij="FW/MF"]='Forward/Midfielder'
daljšizapis[imenapozicij="FW/RW"]='Forward/Right winger'
daljšizapis[imenapozicij="GK"]='Goalkeeper'
daljšizapis[imenapozicij="LB"]='Left back'
daljšizapis[imenapozicij="LB/MF"]='Left back/Midfielder'
daljšizapis[imenapozicij="LW"]='Left winger'
daljšizapis[imenapozicij="LW/MF"]='Left winger/Midfielder'
daljšizapis[imenapozicij="MF"]='Midfielder'
daljšizapis[imenapozicij="RB"]='Right back'
daljšizapis[imenapozicij="RB/LB"]='Right back/Left back'
daljšizapis[imenapozicij="RB/MF"]='Right back/Midfielder'
daljšizapis[imenapozicij="RW"]='Right winger'
daljšizapis[imenapozicij="RW/FW"]='Right winger/Forward'
daljšizapis[imenapozicij="RW/LW"]='Right winger/Left winger'
daljšizapis[imenapozicij="RW/MF"]='Right winger/Midfielder'

golipopozicijah<-sapply(imenapozicij, function(x) sum(NOGOMETASI[NOGOMETASI["POZICIJA"] == x, "ZADETKI"]))
nastopipopozicijah<- sapply(imenapozicij, function(x) sum(NOGOMETASI[NOGOMETASI["POZICIJA"] == x, "NASTOPI"]))
povprecjegolovnapozicijo<-golipopozicijah/nastopipopozicijah
detach(NOGOMETASI)
PODTABELAPOPOZICIJAH<-data.frame(POPOLNO.IME=daljšizapis,PREVOD=prevodi,STEVILO.IGRALCEV=pozicija,NASTOPI.PO.POZICIJAH=nastopipopozicijah, ZADETKI.PO.POZICIJAH=golipopozicijah,POVRECJE.ZADETKOV.NA.STEVILO.NASTOPOV=povprecjegolovnapozicijo)


# Uvoz s spletne strani Wiki

library(XML)

stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1",
                                     gsub("^(.*?)\\[.*$", "\\1",
                                          xmlValue(y)))))
}

uvozi.arsenal <- function() {
  url.arsenal <- "http://en.wikipedia.org/wiki/List_of_Arsenal_F.C._players"
  doc.arsenal <- htmlTreeParse(url.arsenal, useInternalNodes=TRUE)
  
  for (t in getNodeSet(doc.arsenal, "//span[@style='display:none']|//span[@class='sortkey']")) {
    xmlValue(t) <- ""
  } 
  
  tabele <- getNodeSet(doc.arsenal, "//table")
  
  vrstice <- getNodeSet(tabele[[2]], "./tr")
  
  seznam <- lapply(vrstice[2:length(vrstice)], stripByPath, "./td")
  
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  
  colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[1]], ".//th"))
  
  zacetek <- as.numeric(gsub("^([0-9]{4}).*", "\\1", matrika[,4]))

  konec <- as.numeric(gsub(".*[^0-9]([0-9]*)$", "\\1", matrika[,4]))
  
  return(data.frame(matrika[,2:4], First.year = zacetek, Last.year = konec,
                    apply(matrika[,5:6], 2, as.numeric), row.names=matrika[,1]))
}
# Zapišimo podatke v razpredelnico arsenal in spletne strani
cat("Uvažam tabelo iz spletne strani")
arsenal<-uvozi.arsenal()

attach(arsenal)
kategorija<-c('Beginner','Grown up','Legend')
statuss<-character(nrow(arsenal))
statuss[Appearances <150]<-'Beginner'
statuss[Appearances >=150 & Appearances<300]<-'Grown up'
statuss[Appearances >=300]<-'Legend'
Status<-factor(statuss,levels=kategorija,ordered=TRUE)
detach(arsenal)
ARSENAL<-data.frame(arsenal,Status)

UREJENAPODTABELA<-read.csv("podatki/podtabela.csv",
         skip=0,
         row.name=1,
         header=TRUE,
         na.strings = "-",
         fileEncoding = "Windows-1252")


