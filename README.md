# Database

Per creare le tabelle e i trigger:
```
psql < create_db.sql
```

# Dati
Configurare il *search_path*:
```
echo 'set search_path to zoo' >> ~/.psqlrc
```
Aggiungere i dati:

```
psql -d zoo < dati/aree.sql 
psql -d zoo < dati/addetti.sql 
psql -d zoo < dati/casa.sql 
psql -d zoo < dati/generi.sql 
psql -d zoo < dati/gabbie.sql 
psql -d zoo < dati/esemplari.sql 
psql -d zoo < dati/controlli.sql 
```
