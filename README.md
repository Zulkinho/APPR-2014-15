# Analiza podatkov s programom R, 2014/15

Avtor: Jure Zukanovič

Mentor: asist. dr. Janoš Vidali

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Kot strasten navijač nogometnega kluba Arsenal F.C. sem za svojo temo analiziranja izbral Analiza igralcev nogometnega kluba Arsenal Football Club. Osnovna ideja je analiza vsakega igralca v zgodovini nogometnega kluba po različnih spremenljivkah treh tipov. Podatke iz spletne strani bom prenesel v program  Microsoft Office Excel Worksheet in tako oblikoval novo tabelo, ki se bo od originalne razlikovala še za dodano urejenostno spremenljivo, ki v originalni tabeli ni podana. Tabelo bom shranil v CSV obliki, tako da jo bom lahko uvozil v program  R. Za vsakega igralca, ki je kadarkoli zaigral za Arsenal F.C., bom podal: 
- državo iz katere igralec prihaja (imenska spremenljivka)
- njegovo standardno pozicijo v igri (imenska spremenljivka,ki bo podana v angleških,mednarodnih kraticah)
- letnice delovanja v omenjenem nogometnem klubu (številska spremenljivka, podana v obliki od-do)
- število nastopov za klub (številska spremenljivka)
- število zadetkov za klub (številska spremenljivka)
- status nogometaša v klubu (urejenostna spremenljivka, katero bom opredelil glede na število nastopov, ki jih je nogometaš dosegel v klubu. Nogometaše bom razdelil v tri skupine: "Zacetnik v Arsenalu"(do 150 nastopov), "Izkušenj Arsenalovec"(od 150-300 nastopov), "Arsenalova legenda"(od 300 nastopov)).
Države, katerih državljani so bili in so še nogometaši bom prikazal tudi na zemljevidu.

Cilj projekta je ugotovitev katerim nogometašem se je uspelo prebiti v klubsko zgodovino s svojim doprinosom v klubu, predvsem pa spoznavanje orodja analiziranja v programu R na nekem konkretnem, zame osebno zanimivem primeru. 

Povezava do podatkovne tabele o moji tematiki: 
http://en.wikipedia.org/wiki/List_of_Arsenal_F.C._players

## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
