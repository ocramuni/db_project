###########################
# Addetti
# id, nome, cognome, email, indirizzo
addetti_df <- read.csv("dati/addetti.csv",header=TRUE)
addetti_df$id <- sample(1:150, 150, replace=F)

###########################
# Aree
# id, nome, apertura
v_aree <- readLines("dati/aree.txt")
aree_df <- data.frame(
  id=sample(1:10, 10, replace=F),
  nome=sample(v_aree, 10, replace=F),
  apertura=sample(seq(as.Date('2015/01/01'), as.Date('2021/12/31'), by="day"), 10, replace=T)
)

###########################
# Casa table population
# id, area_id, addetto_id
casa_df <- data.frame(
  id=sample(1:150, 150, replace=F),
  area_id=sample(1:10, 10, replace=T),
  addetto_id=sample(1:150, 150, replace=T)
)

###########################
# Gabbie
# id, giorno_pulizia, casa_id
gabbia_df <- data.frame(
  id=sample(1:2000, 2000, replace=F),
  giorno_pulizia=sample(weekdays(Sys.Date()+0:6),2000,replace=TRUE),
  casa_id=sample(1:150, 2000, replace=T)
)

###########################
# Generi
# id, nome, numero_esemplari, casa_id
v_generi <- readLines("dati/generi.txt")
generi_df <- data.frame(
  id=sample(1:150, 150, replace=F),
  nome=sample(v_generi, 150, replace=F),
  numero_esemplari=0,
  casa_id=sample(1:150, 150, replace=T)
)

###########################
# Esemplari
# id, nome, sesso, arrivo, nato, paese, gabbia_id, genere_id
esemplari_df <- read.csv("dati/esemplari.csv",header=TRUE)
esemplari_df$id <- sample(1:1500, 1500, replace=F)
esemplari_df$arrivo <- sample(seq(as.Date('2015/01/01'), as.Date('2021/12/31'), by="day"), 1500, replace=T)
esemplari_df$nato <- sample(seq(as.Date('2014/01/01'), as.Date('2020/12/31'), by="day"), 1500, replace=T)
esemplari_df$sesso <- sample(c("M","F"), 1500, replace=T)
esemplari_df$gabbia_id <- sample(1:2000, 1500, replace=F)
esemplari_df$genere_id <- sample(1:150, 1500, replace=T)

###########################
# Controlli
# data, peso, dieta, malattia, veterinario, esemplare_id
v_diete <- readLines("dati/diete.txt")
v_malattie <- readLines("dati/malattie.txt")
v_veterinari <- readLines("dati/veterinari.txt")
controlli_df <- data.frame(
  data=sample(seq(as.Date('2015/01/01'), as.Date('2021/12/31'), by="day"), 50000, replace=T),
  peso=sample(1:1000, 50000, replace=T),
  dieta=sample(v_diete, 50000, replace=T),
  malattia=sample(v_malattie, 50000, replace=T),
  veterinario=sample(v_veterinari, 50000, replace=T),
  esemplare_id=sample(1:1500, 5000, replace=T)
)
# Solo nel 10% dei controlli risulta una malattia 
controlli_df$malattia[sample(nrow(controlli_df),40000)]<-NA

