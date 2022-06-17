CREATE DATABASE zoo;
\c zoo
CREATE SCHEMA zoo;
SET search_path TO zoo;

CREATE TABLE if not exists aree
(
  id INT NOT NULL,
  nome VARCHAR(25) NOT NULL,
  apertura DATE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE if not exists addetti
(
  id INT NOT NULL,
  nome VARCHAR(25) NOT NULL,
  cognome VARCHAR(25) NOT NULL,
  email VARCHAR(40) NOT NULL,
  indirizzo VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

-- case è un nome riservato
CREATE TABLE if not exists casa
(
  id INT NOT NULL,
  area_id INT NOT NULL,
  addetto_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (area_id) REFERENCES aree(id),
  FOREIGN KEY (addetto_id) REFERENCES addetti(id)
);

CREATE TABLE if not exists gabbie
(
  id INT NOT NULL,
  giorno_pulizia VARCHAR(10) NOT NULL,
  casa_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (casa_id) REFERENCES casa(id)
);

-- numero_esemplari non può essere negativo
CREATE TABLE if not exists generi
(
  id INT NOT NULL,
  nome VARCHAR(35) NOT NULL,
  numero_esemplari INT NOT NULL,
  casa_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (casa_id) REFERENCES casa(id),
  CHECK (numero_esemplari >= 0)
);

CREATE TABLE if not exists esemplari
(
  id INT NOT NULL,
  nome VARCHAR(35) NOT NULL,
  sesso CHAR(1) NOT NULL,
  arrivo DATE NOT NULL,
  nato DATE NOT NULL,
  paese VARCHAR(35) NOT NULL,
  gabbia_id INT NOT NULL,
  genere_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (gabbia_id) REFERENCES gabbie(id),
  FOREIGN KEY (genere_id) REFERENCES generi(id)
);

CREATE TABLE if not exists controlli
(
  data DATE NOT NULL,
  peso FLOAT NOT NULL,
  dieta VARCHAR(35) NOT NULL,
  malattia VARCHAR(35),
  veterinario VARCHAR(35) NOT NULL,
  esemplare_id INT NOT NULL,
  PRIMARY KEY (data, esemplare_id),
  FOREIGN KEY (esemplare_id) REFERENCES esemplari(id) ON DELETE CASCADE  
);

CREATE OR REPLACE FUNCTION incrementa_numero_esemplari()
RETURNS TRIGGER AS
$$
  BEGIN
    UPDATE generi SET numero_esemplari = numero_esemplari + 1 where id = new.genere_id;
  RETURN new;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER esemplari_insert_trigger AFTER INSERT
  ON esemplari FOR EACH ROW EXECUTE PROCEDURE incrementa_numero_esemplari();

CREATE OR REPLACE FUNCTION decrementa_numero_esemplari()
RETURNS TRIGGER AS
$$
  BEGIN
    UPDATE generi SET numero_esemplari = numero_esemplari - 1 where id = old.genere_id;
  RETURN old;
  END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER esemplari_delete_trigger AFTER DELETE
  ON esemplari FOR EACH ROW EXECUTE PROCEDURE decrementa_numero_esemplari();




