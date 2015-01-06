# 3. faza: Izdelava zemljevida

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid sveta...\n")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_map_units.zip",
                        "svet", "ne_110m_admin_0_map_units.shp", mapa = "zemljevid",
                        encoding = "Windows-1252")

svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Brazil",]

pdf("slike/igralci.pdf", width=8.27, height=11.69)
plot(svet, xlim=c(-50, 34), ylim=c(-33,73), col="white", bg="lightblue")
dev.off()

# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Scotland",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "England",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Northern Ireland",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Wales",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Ireland",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Sweden",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Denmark",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Netherlands",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Denmark",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Denmark",]
# svet <- svet[svet$continent %in% c("Europe", "Africa") | svet$name_long == "Denmark",]


# # Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
# preuredi <- function(podatki, zemljevid) {
#   nove.obcine <- c()
#   manjkajo <- ! nove.obcine %in% rownames(podatki)
#   M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
#   names(M) <- names(podatki)
#   row.names(M) <- nove.obcine[manjkajo]
#   podatki <- rbind(podatki, M)
#   
#   out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$OB_UIME)[rank(zemljevid$OB_UIME)]), ]
#   if (ncol(podatki) == 1) {
#     out <- data.frame(out)
#     names(out) <- names(podatki)
#     rownames(out) <- rownames(podatki)
#   }
#   return(out)
# }
# 
# # Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
# druzine <- preuredi(druzine, obcine)
# 
# # Izračunamo povprečno velikost družine.
# druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
# min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
# max.povprecje <- max(druzine$povprecje, na.rm=TRUE)
# 
# # Narišimo zemljevid v PDF.
# cat("Rišem zemljevid...\n")
# pdf("slike/povprecna_druzina.pdf", width=6, height=4)
# 
# n = 100
# barve = topo.colors(n)[1+(n-1)*(druzine$povprecje-min.povprecje)/(max.povprecje-min.povprecje)]
# plot(obcine, col = barve)
# 
# dev.off()