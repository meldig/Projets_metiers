/*
La table TA_SIGNALISATION_LIBELLE - du projet de signalisation routière - regroupant tous les libellés permettant de qualifier les objets de la signalétique horizontale et verticale de la voirie.
*/

-- 1. Création de la table TA_SIGNALISATION_LIBELLE
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    valeur VARCHAR2(100 BYTE),
    description VARCHAR2(4000 BYTE)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_LIBELLE IS 'Table - du projet de signalisation routière - regroupant tous les libellés permettant de qualifier les objets de la signalétique horizontale et verticale de la voirie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_LIBELLE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_LIBELLE.valeur IS 'Libellé permettant de catégoriser un objet de la signalétique horizontale et verticale de la voirie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_LIBELLE.description IS 'Description du libellé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_LIBELLE 
ADD CONSTRAINT TA_SIGNALISATION_LIBELLE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_LIBELLE_VALEUR_IDX ON G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(valeur)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_LIBELLE TO G_ADMIN_SIG;

/
