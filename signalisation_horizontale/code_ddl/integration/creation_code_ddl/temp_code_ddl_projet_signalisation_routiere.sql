/*
La table TA_SIGNALISATION_AGENT - du projet de signalisation routière -  regroupant les matricules et pnoms de tous les agents travaillant ou ayant travaillé sur la signalétique horizontale et verticale de la voirie.
*/

-- 1. Création de la table TA_SIGNALISATION_AGENT
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_AGENT(
    numero_agent NUMBER(38,0) NOT NULL,
    pnom VARCHAR2(100 BYTE),
    validite NUMBER(1,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_AGENT IS 'Table - du projet de signalisation routière -  regroupant les matricules et pnoms de tous les agents travaillant ou ayant travaillé sur la signalétique horizontale et verticale de la voirie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_AGENT.numero_agent IS 'Matricule des agents travaillant ou ayant travaillé sur la signalétique horizontale et verticale de la voirie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_AGENT.pnom IS 'Pnom des agents travaillant ou ayant travaiilé sur la signalétique horizontale et verticale de la voirie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_AGENT.validite IS 'Champ permettant d''indiquer si un agent travaille ou non sur la signalétique horizontale et verticale de la voirie : 0 : non ; 1 : oui.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_AGENT 
ADD CONSTRAINT TA_SIGNALISATION_AGENT_PK 
PRIMARY KEY("NUMERO_AGENT") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_AGENT_PNOM_IDX ON G_BASE_VOIE.TA_SIGNALISATION_AGENT(pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_AGENT_VALIDITE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_AGENT(validite)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_AGENT TO G_ADMIN_SIG;

/

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

/*
La table TA_SIGNALISATION_FAMILLE - du projet de signalisation routière - contenant toutes les familles regroupant les  libellés qualifiant la signalétique horizontale et verticale de la voirie.
*/

-- 1. Création de la table TA_SIGNALISATION_FAMILLE
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_FAMILLE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    valeur VARCHAR2(100 BYTE),
    description VARCHAR2(4000 BYTE)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_FAMILLE IS 'Table - du projet de signalisation routière - contenant toutes les familles regroupant les  libellés qualifiant la signalétique horizontale et verticale de la voirie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_FAMILLE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_FAMILLE.valeur IS 'Libellé de la famille.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_FAMILLE.description IS 'Description de la famille.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_FAMILLE 
ADD CONSTRAINT TA_SIGNALISATION_FAMILLE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_FAMILLE_VALEUR_IDX ON G_BASE_VOIE.TA_SIGNALISATION_FAMILLE(valeur)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_FAMILLE TO G_ADMIN_SIG;

/

/*
La table TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE - du projet de signalisation routière - permettant de regrouper les libellés de la signalétique voirie, horizontale et verticale, par famille.
*/

-- 1. Création de la table TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE(
    fid_famille NUMBER(38,0) NOT NULL,
    fid_libelle NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE IS 'Table de relation - du projet de signalisation routière - permettant de regrouper les libellés de la signalétique voirie, horizontale et verticale, par famille.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE.fid_famille IS 'Partie de la clé primaire de la table (1/2) et clé étrangère vers la table TA_VOIRIE_FAMILLE permettant d''associer une famille à ses libellés.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE.fid_libelle IS 'Partie de la clé primaire de la table (2/2) et clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer les libellés à leur famille.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE 
ADD CONSTRAINT TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE_PK 
PRIMARY KEY("FID_FAMILLE", "FID_LIBELLE") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE
ADD CONSTRAINT TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE_FID_FAMILLE_FK
FOREIGN KEY (fid_famille)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_FAMILLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE
ADD CONSTRAINT TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE_FID_LIBELLE_FK
FOREIGN KEY (fid_libelle)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

-- 4. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE_FID_FAMILLE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE(fid_famille)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE_FID_LIBELLE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE(fid_libelle)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_RELATION_FAMILLE_LIBELLE TO G_ADMIN_SIG;

/

/*
La table TA_SIGNALISATION_RELATION_LIBELLE - du projet de signalisation routière - permettant de catégoriser les libellés entre eux (dans le cadre des couleurs de marquage notamment).
*/

-- 1. Création de la table TA_SIGNALISATION_RELATION_LIBELLE
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE(
    fid_libelle_parent NUMBER(38,0) NOT NULL,
    fid_libelle_fils NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE IS 'Table de relation - du projet de signalisation routière - permettant de catégoriser les libellés entre eux (dans le cadre des couleurs de marquage notamment).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE.fid_libelle_parent IS 'Clé étrangère de la table TA_SIGNALISATION_LIBELLE permettant d''associer un ou plusieurs libelle parent à un ou plusieurs libelles fils.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE.fid_libelle_fils IS 'Clé étrangère de la table TA_SIGNALISATION_LIBELLE permettant d''associer un ou plusieurs libelle fils un ou plusieurs libelles parents.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE 
ADD CONSTRAINT TA_SIGNALISATION_RELATION_LIBELLE_PK 
PRIMARY KEY("FID_LIBELLE_PARENT", "FID_LIBELLE_FILS") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE
ADD CONSTRAINT TA_SIGNALISATION_RELATION_LIBELLE_FID_LIBELLE_PARENT_FK
FOREIGN KEY (fid_libelle_parent)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE
ADD CONSTRAINT TA_SIGNALISATION_RELATION_LIBELLE_FID_LIBELLE_FILS_FK
FOREIGN KEY (fid_libelle_fils)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

-- 4. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_RELATION_LIBELLE_FID_LIBELLE_PARENT_IDX ON G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE(fid_libelle_parent)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_RELATION_LIBELLE_FID_LIBELLE_FILS_IDX ON G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE(fid_libelle_fils)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_RELATION_LIBELLE TO G_ADMIN_SIG;

/

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

/*
La table TA_SIGNALISATION_MARQUAGE_SURFACIQUE - du projet de signalisation routière - contenant tous les marquages surfaciques de la voirie (zébra, protection piéton, etc), millésimés et catégorisés. Elle correspond à la table MEL_sh_surf_marque de l''export Imergis.
*/

-- 1. Création de la table TA_SIGNALISATION_MARQUAGE_SURFACIQUE
CREATE TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(
    geom SDO_GEOMETRY NOT NULL,
    objectid NUMBER(38,0),
    surface NUMBER(38,3) NOT NULL,
    date_livraison DATE NOT NULL,
    date_intervention DATE NOT NULL,
    date_modification DATE NOT NULL,
    fid_pnom_modification NUMBER(38,0) NOT NULL,
    fid_etat NUMBER(38,0) NOT NULL,
    fid_materiau NUMBER(38,0) NOT NULL,
    fid_modulation NUMBER(38,0) NOT NULL,
    fid_registre NUMBER(38,0) NOT NULL,
    fid_type NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE IS 'Table - du projet de signalisation routière - contenant tous les marquages surfaciques de la voirie (zébra, protection piéton, etc), millésimés et catégorisés. Elle correspond à la table MEL_sh_surf_marque de l''export Imergis.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.geom IS 'Champ géométrique de type multiligne ';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.objectid IS 'Clé primaire auto-incrémentée de la table - ancien champ id_place_pmr.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.surface IS 'Surface des marquages.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.date_livraison IS 'Date de livraison de la donnée par le prestataire (Immergis) - ancien champ date_creation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.date_intervention IS 'Date de début des travaux - ancien champ date_intervention.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.date_modification IS 'Date de la dernière modification de la donnée - ancien champ date_maj.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.fid_pnom_modification IS 'Clé étrangère vers la table TA_VOIRIE_AGENT permettant d''associer à chaque marquage le pnom de l''agent l''ayant modifié en dernier.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.fid_etat IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE contenant les libellés servant à qualifier les objets de la signalisation horizontale et verticale - ancien champ etat.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.fid_materiau IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant de connaître le type de matériau utilisé pour le marquage - ancien champ nature_materiau.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.fid_modulation IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer la modulation d''un marquage (distance entre deux éléments d''un même marquage) au marquage proprement dit - ancien champ modulation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.fid_registre IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer un marquage à son type de positionnement sur la chaussée (milieu de voie, bas-côté de la chaussée, etc) - ancien champ registre.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE.fid_type IS 'Clé étrangère vers la table TA_VOIRIE_LIBELLE permettant d''associer un marquage à son type de positionnement sur la chaussée (milieu de voie, bas-côté de la chaussée, etc) - ancien champ registre.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE 
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_PK 
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
    'TA_SIGNALISATION_MARQUAGE_SURFACIQUE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_SIDX
ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=MULTIPOLYGON, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_ETAT_FK
FOREIGN KEY (fid_etat)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_MATERIAU_FK
FOREIGN KEY (fid_materiau)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_MODULATION_FK
FOREIGN KEY (fid_modulation)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_REGISTRE_FK
FOREIGN KEY (fid_registre)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE
ADD CONSTRAINT TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_TYPE_FK
FOREIGN KEY (fid_type)
REFERENCES G_BASE_VOIE.TA_SIGNALISATION_LIBELLE(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_ETAT_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(fid_etat)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_MATERIAU_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(fid_materiau)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_MODULATION_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(fid_modulation)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_REGISTRE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(fid_registre)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SIGNALISATION_MARQUAGE_SURFACIQUE_FID_TYPE_IDX ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE(fid_type)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SIGNALISATION_MARQUAGE_SURFACIQUE TO G_ADMIN_SIG;

/
