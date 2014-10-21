# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozitabelaigralcev <- function() {
  return(read.csv("podatki/tabelanogometasev.csv",skip = 0, header=TRUE,
                   col.names=c('IME NOGOMETASA','DRŽAVA','POZICIJA','LETNICE.DELOVANJA','NASTOPI','ZADETKI'),na.strings = "-",
                   fileEncoding = "Windows-1250"))
}

# Zapišimo podatke v razpredelnico nogometasi.
cat("Uvažam podatke o nogometaših...\n")
nogometasi <- uvozitabelaigralcev()
View(nogometasi)
attach(nogometasi)
kategorije<-c('Začetnik v Arsenalu','Izkušenj Arsenalovec','Arsenalova legenda')
STATUSS<-character(nrow(nogometasi))
STATUSS[NASTOPI <150]<-'Začetnik v Arsenalu'
STATUSS[NASTOPI >=150 & NASTOPI<300]<-'Izkušenj Arsenalovec'
STATUSS[NASTOPI >=300]<-'Arsenalova legenda'
STATUS<-factor(STATUSS,levels=kategorije,ordered=TRUE)
detach(nogometasi)
dodatenstolpec<-data.frame(STATUS)
NOGOMETASI<-merge(nogometasi,dodatenstolpec, by = 0,all=TRUE)
NOGOMETASI<- NOGOMETASI[-1]
rownames(NOGOMETASI) <- NULL

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