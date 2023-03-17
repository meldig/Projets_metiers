/*
La table TA_SIGNALISATION_MARQUAGE_LINEAIRE - du projet de signalisation routière - contenant tous les marquages linéaires de la voirie, millésimés et catégorisés. Elle correspond aux tables MEL_sh_longitudinale et MEL_SH_MARQ_SECURITE de l''export Imergis. La distinction entre les entités se ces tables se fait sur le champ fid_type.
*/

-- 1. Création de la table TA_SIGNALISATION_MARQUAGE_LINEAIRE
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(
    geom SDO_GEOMETRY NOT NULL,
    objectid NUMBER(38,0),
    largeur NUMBER(38,3) NOT NULL,
    date_livraison DATE NOT NULL,
    date_intervention DATE NOT NULL,
    date_modification DATE NOT NULL,
    fid_pnom_modification NUMBER(38,0) NOT NULL,
    fid_troncon NUMBER(38,0) NOT NULL,
    fid_etat NUMBER(38,0) NOT NULL,
    fid_materiau NUMBER(38,0) NOT NULL,
    fid_modulation NUMBER(38,0) NOT NULL,
    fid_registre NUMBER(38,0) NOT NULL,
    fid_type NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE IS 'Table - du projet de signalisation routière - contenant tous les marquages linéaires de la voirie, millésimés et catégorisés. Elle correspond aux tables MEL_sh_longitudinale et MEL_SH_MARQ_SECURITE de l''export Imergis. La distinction entre les entités se ces tables se fait sur le champ fid_type.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.geom IS 'Champ géométrique de type multiligne ';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.objectid IS 'Clé primaire auto-incrémentée de la table - ancien champ id_place_pmr.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.largeur IS 'Largeur du marquage - ancien champ largeur.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.date_livraison IS 'Date de livraison de la donnée par le prestataire (Immergis) - ancien champ date_creation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.date_intervention IS 'Date de début des travaux - ancien champ date_intervention.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.date_modification IS 'Date de la dernière modification de la donnée - ancien champ date_maj.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_pnom_modification IS 'Clé étrangère vers la table TA_VOIRIE_AGENT permettant d''associer à chaque marquage le pnom de l''agent l''ayant modifié en dernier.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_troncon IS 'Clé étrangère vers la table G_BASE_VOIE.TA_TRONCON permettant d''associer un marquage à un tronçon de voirie - ancien champ num_troncon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_etat IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE contenant les libellés servant à qualifier les objets de la signalisation horizontale et verticale - ancien champ etat.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_materiau IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant de connaître le type de matériau utilisé pour le marquage - ancien champ nature_materiau.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_modulation IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer la modulation d''un marquage (distance entre deux éléments d''un même marquage) au marquage proprement dit - ancien champ modulation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_registre IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer un marquage à son type de positionnement sur la chaussée (milieu de voie, bas-côté de la chaussée, etc) - ancien champ registre.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE.fid_type IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer un marquage à son type de positionnement sur la chaussée (milieu de voie, bas-côté de la chaussée, etc) - ancien champ registre.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE 
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_PK 
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
    'TA_SIGNALISATION_MARQUAGE_LINEAIRE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_SIDX
ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=MULTILINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_AGENT(numero_agent);
/*
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_TRONCON_FK
FOREIGN KEY (fid_troncon)
REFERENCES SIREO_LEC.OUT_DOMANIALITE(cnumtrc);
*/
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_ETAT_FK
FOREIGN KEY (fid_etat)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_MATERIAU_FK
FOREIGN KEY (fid_materiau)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_MODULATION_FK
FOREIGN KEY (fid_modulation)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_REGISTRE_FK
FOREIGN KEY (fid_registre)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_TYPE_FK
FOREIGN KEY (fid_type)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_TRONCON_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_troncon)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_ETAT_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_etat)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_MATERIAU_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_materiau)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_MODULATION_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_modulation)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_REGISTRE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_registre)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_LINEAIRE_FID_TYPE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE(fid_type)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_LINEAIRE TO G_ADMIN_SIG;

/
