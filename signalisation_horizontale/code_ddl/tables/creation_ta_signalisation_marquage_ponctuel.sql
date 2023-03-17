/*
La table TA_SIGNALISATION_MARQUAGE_PONCTUEL - du projet de signalisation routière - permettant de catégoriser les libellés entre eux (dans le cadre des couleurs de marquage notamment).
*/

-- 1. Création de la table TA_SIGNALISATION_MARQUAGE_PONCTUEL
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(
    geom SDO_GEOMETRY NOT NULL,
    objectid NUMBER(38,0),
    date_livraison DATE NOT NULL,
    date_intervention DATE NOT NULL,
    date_modification DATE NOT NULL,
    fid_pnom_modification NUMBER(38,0) NOT NULL,
    fid_etat NUMBER(38,0) NOT NULL,
    fid_materiau NUMBER(38,0) NOT NULL,
    fid_registre NUMBER(38,0) NOT NULL,
    fid_type NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL IS 'Table - du projet de signalisation routière - contenant tous les marquages ponctuels de la voirie (place pour personne à mobilité réduite, logos vélos, sas cyclable, zizag bus), millésimés et catégorisés. Elle correspond aux tables MEL_sh_place_pmr, MEL_sh_sas_cyclable, ponctuelle de l''export Imergis. La distinction entre les entités se ces tables se fait sur le champ fid_type.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.geom IS 'Champ géométrique de type multiligne ';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.objectid IS 'Clé primaire auto-incrémentée de la table - ancien champ id_place_pmr.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.date_livraison IS 'Date de livraison de la donnée par le prestataire (Immergis) - ancien champ date_creation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.date_intervention IS 'Date de début des travaux - ancien champ date_intervention.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.date_modification IS 'Date de la dernière modification de la donnée - ancien champ date_maj.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.fid_pnom_modification IS 'Clé étrangère vers la table TA_VOIRIE_AGENT permettant d''associer à chaque marquage le pnom de l''agent l''ayant modifié en dernier.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.fid_etat IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE contenant les libellés servant à qualifier les objets de la signalisation horizontale et verticale - ancien champ etat.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.fid_materiau IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant de connaître le type de matériau utilisé pour le marquage - ancien champ nature_materiau.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.fid_registre IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer un marquage à son type de positionnement sur la chaussée (milieu de voie, bas-côté de la chaussée, etc) - ancien champ registre.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL.fid_type IS 'Clé étrangère vers la table TA_SIGNALISATION_LIBELLE permettant de distinguer les types de marquages ponctuels.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL 
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_PONCTUEL_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SIGNALISATION_MARQUAGE_PONCTUEL',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SIGNALISATION_MARQUAGE_PONCTUEL_SIDX
ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=MULTIPOINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_ETAT_FK
FOREIGN KEY (fid_etat)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_MATERIAU_FK
FOREIGN KEY (fid_materiau)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_REGISTRE_FK
FOREIGN KEY (fid_registre)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_TYPE_FK
FOREIGN KEY (fid_type)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_ETAT_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(fid_etat)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_MATERIAU_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(fid_materiau)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_REGISTRE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(fid_registre)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_PONCTUEL_FID_TYPE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL(fid_type)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_PONCTUEL TO G_ADMIN_SIG;

/
