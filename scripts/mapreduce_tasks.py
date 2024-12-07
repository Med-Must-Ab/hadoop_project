#!/usr/bin/env python3
import sys
from collections import defaultdict

def analyze_logs():
    """Exercice 1: Analyse des logs"""
    counts = defaultdict(int)
    for line in sys.stdin:
        ip = line.split()[0]
        counts[ip] += 1
    for ip, count in counts.items():
        print("{0}\t{1}".format(ip, count))

def group_sales_by_region():
    """Exercice 2: Regroupement des ventes par region"""
    totals = defaultdict(int)
    for line in sys.stdin:
        region, value = line.strip().split(",")
        totals[region] += int(value)
    for region, total in totals.items():
        print("{0}\t{1}".format(region, total))

def most_frequent_word():
    """Exercice 3: Trouver le mot le plus frequent"""
    import io
    word_counts = defaultdict(int)

    # Use io.TextIOWrapper to handle UTF-8 encoding for stdin
    input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
    for line in input_stream:
        words = line.strip().lower().split()
        for word in words:
            word = word.strip(".!?\",")
            word_counts[word] += 1
    max_word = max(word_counts.items(), key=lambda x: x[1])
    print("{0}\t{1}".format(max_word[0], max_word[1]))

def average_student_grades():
    """Exercice 4: Moyenne des notes des etudiants"""
    grades = defaultdict(list)
    for line in sys.stdin:
        student, subject, grade = line.strip().split(",")
        grades[student].append(int(grade))
    for student, grade_list in grades.items():
        average = sum(grade_list) / len(grade_list)
        print("{0}\t{1:.2f}".format(student, average))

def count_specific_word(target_word):
    """Exercice 5: Compter les occurrences d'un mot specifique"""
    import io
    target_word = target_word.lower()
    count = 0

    # Use io.TextIOWrapper to handle UTF-8 encoding for stdin
    input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
    for line in input_stream:
        words = line.strip().lower().split()
        for word in words:
            word = word.strip(".!?\",")
            if word == target_word:
                count += 1
    print("{0}\t{1}".format(target_word, count))

def detect_duplicates():
    """Exercice 6: D  tection des doublons"""
    counts = defaultdict(int)
    for line in sys.stdin:
        item = line.strip()
        counts[item] += 1
    for item, count in counts.items():
        if count > 1:
            print("{0}\t{1}".format(item, count))

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: mapreduce_tasks.py <task> [args...]")
        print("Available tasks: logs, sales, frequent, grades, word, duplicates")
        sys.exit(1)

    task = sys.argv[1]
    if task == "logs":
        analyze_logs()
    elif task == "sales":
        group_sales_by_region()
    elif task == "frequent":
        most_frequent_word()
    elif task == "grades":
        average_student_grades()
    elif task == "word":
        if len(sys.argv) < 3:
            print("Usage: mapreduce_tasks.py word <target_word>")
            sys.exit(1)
        count_specific_word(sys.argv[2])
    elif task == "duplicates":
        detect_duplicates()
    else:
        print("Unknown task: {0}".format(task))
        sys.exit(1)