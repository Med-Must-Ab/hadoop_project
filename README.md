# hadoop_project
 
Aperçu du Projet
Ce projet contient des scripts et des fichiers d'entrée pour tester les tâches HDFS et MapReduce. L'objectif est de fournir un moyen automatisé de configurer l'environnement, de charger les fichiers d'entrée dans HDFS et d'exécuter des jobs MapReduce pour analyser et traiter les données.

hadoop_project/
├── scripts/
│   ├── prepare_input.sh            # Prépare les fichiers d'entrée dans HDFS
│   ├── mapreduce_tasks.py          # Script Python pour les tâches MapReduce
│   ├── hdfs_tasks.sh               # Script d'utilitaires HDFS
├── input_files/ (crées par le script bash prepare_input.sh)
│   ├── logs.txt                    # Fichier de données des logs
│   ├── sales.txt                   # Fichier des ventes par région
│   ├── words.txt                   # Fichier de données de texte
│   ├── grades.csv                  # Fichier CSV contenant les notes des étudiants
│   ├── duplicates.txt              # Fichier contenant des doublons à détecter


Instructions d'installation

Copier depuis machine locale:

hadoop fs -put /chemin/local/vers/hadoop_project /opt/

Accéder au dossier du projet :

cd hadoop_project

Préparer les fichiers d'entrée dans HDFS pour mapreduce:

bash scripts/prepare_input.sh



1/ Exécuter le script utilitaire des tâches HDFS :

bash scripts/hdfs_tasks.sh




2/ Tâches MapReduce


Commandes Hadoop Streaming

pour le path Hadoop, changer le path convenablement vers le jar.

Commande pour trouver:
find / -name "hadoop-streaming*.jar"


Ex1: Analyse des logs

hadoop jar /opt/hadoop-2.7.4/share/hadoop/tools/lib/hadoop-streaming-2.7.4.jar \
    -input /input/mapreduce/logs.txt \
    -output /output/mapreduce/logs \
    -mapper "/usr/bin/python3 /opt/hadoop_project/scripts/mapreduce_tasks.py logs" \
    -reducer NONE

Ex2: Regroupement des ventes par région

hadoop jar /opt/hadoop-2.7.4/share/hadoop/tools/lib/hadoop-streaming-2.7.4.jar \
    -input /input/mapreduce/sales.txt \
    -output /output/mapreduce/sales \
    -mapper "/usr/bin/python3 /opt/hadoop_project/scripts/mapreduce_tasks.py sales" \
    -reducer NONE

Ex3: Trouver le mot le plus fréquent

hadoop jar /opt/hadoop-2.7.4/share/hadoop/tools/lib/hadoop-streaming-2.7.4.jar \
    -input /input/mapreduce/words.txt \
    -output /output/mapreduce/frequent \
    -mapper "/usr/bin/python3 /opt/hadoop_project/scripts/mapreduce_tasks.py frequent" \
    -reducer NONE

Ex4: Calcul de la moyenne des notes des étudiants

hadoop jar /opt/hadoop-2.7.4/share/hadoop/tools/lib/hadoop-streaming-2.7.4.jar \
    -input /input/mapreduce/grades.csv \
    -output /output/mapreduce/grades \
    -mapper "/usr/bin/python3 /opt/hadoop_project/scripts/mapreduce_tasks.py grades" \
    -reducer NONE

Ex5: Compter les occurrences d'un mot spécifique

hadoop jar /opt/hadoop-2.7.4/share/hadoop/tools/lib/hadoop-streaming-2.7.4.jar \
    -input /input/mapreduce/words.txt \
    -output /output/mapreduce/specific_word \
    -mapper "/usr/bin/python3 /opt/hadoop_project/scripts/mapreduce_tasks.py word Hadoop" \
    -reducer NONE

Ex6: Détecter les doublons

hadoop jar /opt/hadoop-2.7.4/share/hadoop/tools/lib/hadoop-streaming-2.7.4.jar \
    -input /input/mapreduce/duplicates.txt \
    -output /output/mapreduce/duplicates \
    -mapper "/usr/bin/python3 /opt/hadoop_project/scripts/mapreduce_tasks.py duplicates" \
    -reducer NONE