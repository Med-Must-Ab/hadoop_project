#!/bin/bash

# Variables globales
HDFS_INPUT_DIR="/input/files"    # Répertoire d'entrée dans HDFS
HDFS_OUTPUT_DIR="/output/files" # Répertoire de sortie dans HDFS
KEYWORD="hello"                 # Mot-clé pour le filtrage (Ex1)
OUTPUT_FILE="output.txt"        # Nom du fichier de sortie

# Fonction pour créer les fichiers d'entrée (Ex1 Prérequis)
create_input_files() {
  echo "Création des fichiers d'entrée dans HDFS..."
  hadoop fs -mkdir -p ${HDFS_INPUT_DIR}
  echo -e "hello monsieur\npas de monsieur ici !\nok hello toto" | hadoop fs -put - ${HDFS_INPUT_DIR}/toto.txt
  echo -e "hello madame\nComment ça va ?" | hadoop fs -put - ${HDFS_INPUT_DIR}/tati.txt
  echo "Fichiers créés avec succès dans ${HDFS_INPUT_DIR}:"
  hadoop fs -ls ${HDFS_INPUT_DIR}
}

# Exercice 1 : Filtrage des données
filter_data() {
  echo "Filtrage des données contenant le mot-clé '${KEYWORD}'..."
  hadoop fs -cat ${HDFS_INPUT_DIR}/*.txt | grep "${KEYWORD}" > ${OUTPUT_FILE}
  hadoop fs -mkdir -p ${HDFS_OUTPUT_DIR}
  hadoop fs -put -f ${OUTPUT_FILE} ${HDFS_OUTPUT_DIR}/
  echo "Résultats enregistrés dans ${HDFS_OUTPUT_DIR}/${OUTPUT_FILE}:"
  hadoop fs -cat ${HDFS_OUTPUT_DIR}/${OUTPUT_FILE}
}

# Exercice 2 : Fusionner plusieurs fichiers
merge_files() {
  echo "Fusion des fichiers dans ${HDFS_INPUT_DIR}..."
  local merged_file="merged_output.txt"
  hadoop fs -getmerge ${HDFS_INPUT_DIR} ${merged_file}
  hadoop fs -mkdir -p ${HDFS_OUTPUT_DIR}
  hadoop fs -put -f ${merged_file} ${HDFS_OUTPUT_DIR}/
  echo "Fichier fusionné disponible dans ${HDFS_OUTPUT_DIR}/${merged_file}:"
  hadoop fs -cat ${HDFS_OUTPUT_DIR}/${merged_file}
}

# Exercice 3 : Compter les lignes d'un fichier
count_lines() {
  local file_to_count=$1
  if [ -z "${file_to_count}" ]; then
    echo "Veuillez fournir un fichier HDFS à compter, exemple : /input/files/toto.txt"
    return
  fi
  echo "Comptage des lignes dans le fichier ${file_to_count}..."
  local line_count=$(hadoop fs -cat ${file_to_count} | wc -l)
  echo "Le fichier ${file_to_count} contient ${line_count} lignes."
}

# Exercice 4 : Compresser un fichier
compress_file() {
  local file_to_compress=$1
  if [ -z "${file_to_compress}" ]; then
    echo "Veuillez fournir un fichier HDFS à compresser, exemple : /input/files/toto.txt"
    return
  fi
  echo "Compression du fichier ${file_to_compress}..."
  local local_file=$(basename ${file_to_compress})
  hadoop fs -get ${file_to_compress} ./${local_file}
  gzip ./${local_file}
  hadoop fs -mkdir -p /compressed/
  hadoop fs -put -f ./${local_file}.gz /compressed/
  echo "Fichier compressé disponible dans /compressed/${local_file}.gz"
  hadoop fs -ls /compressed/
}

# Menu principal
echo "=== Script HDFS Tasks ==="
echo "1. Créer les fichiers d'entrée (Préparation)"
echo "2. Filtrage des données (Ex1)"
echo "3. Fusionner plusieurs fichiers (Ex2)"
echo "4. Compter les lignes d'un fichier (Ex3)"
echo "5. Compresser un fichier (Ex4)"
echo "Choisissez une option (1-5) ou 'q' pour quitter:"
read option

case $option in
  1)
    create_input_files
    ;;
  2)
    filter_data
    ;;
  3)
    merge_files
    ;;
  4)
    echo "Entrez le chemin du fichier HDFS à compter (Ex: /input/files/toto.txt):"
    read file_to_count
    count_lines ${file_to_count}
    ;;
  5)
    echo "Entrez le chemin du fichier HDFS à compresser (Ex: /input/files/toto.txt):"
    read file_to_compress
    compress_file ${file_to_compress}
    ;;
  q)
    echo "Quitter..."
    ;;
  *)
    echo "Option invalide."
    ;;
esac
