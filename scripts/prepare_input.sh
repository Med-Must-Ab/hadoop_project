#!/bin/bash

# Répertoires
HDFS_INPUT_DIR="/input/mapreduce"
HDFS_OUTPUT_DIR="/output/mapreduce"

# Fonction pour préparer les fichiers d'entrée
prepare_input() {
    echo "Préparation des fichiers d'entrée dans HDFS..."
    hadoop fs -mkdir -p ${HDFS_INPUT_DIR}
    
    # Ajouter des fichiers pour chaque exercice
    echo -e "192.168.0.1 -- [01/Dec/2023:10:00:00 +0000] \"GET / HTTP/1.1\" 200\n192.168.0.2 -- [01/Dec/2023:10:01:00 +0000] \"GET /about HTTP/1.1\" 200\n192.168.0.1 -- [01/Dec/2023:10:02:00 +0000] \"POST /login HTTP/1.1\" 200" | hadoop fs -put - ${HDFS_INPUT_DIR}/logs.txt
    echo -e "Region1,100\nRegion2,200\nRegion1,300\nRegion3,400" | hadoop fs -put - ${HDFS_INPUT_DIR}/sales.txt
    echo -e "Hadoop est génial.\nJ'adore Hadoop.\nHadoop MapReduce est puissant.\nHadoop !" | hadoop fs -put - ${HDFS_INPUT_DIR}/words.txt
    echo -e "Alice,Math,80\nAlice,Science,90\nBob,Math,70\nBob,Science,60" | hadoop fs -put - ${HDFS_INPUT_DIR}/grades.csv
    echo -e "Alice\nJoe\nBob\nAlice\nJoe\nCharlie\nJoe\nBob" | hadoop fs -put - ${HDFS_INPUT_DIR}/duplicates.txt
    
    echo "Fichiers d'entrée créés avec succès dans ${HDFS_INPUT_DIR}:"
    hadoop fs -ls ${HDFS_INPUT_DIR}
}

# Exécuter la fonction
prepare_input
