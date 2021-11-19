#!/bin/bash
# Erstellt ein python local env 
# installiert alle dependencies

echo 'Wie heißt die Dependencies Datei? (ohne .txt):'
read dep
# Benutzer Eingabe der Quelldatei
echo 'Welche Datei soll ausgeführt werden? (ohne .py):'
read simulation

# Automatische Erstellung des localen Venvis:
echo 'Genutze Python Version:'
python3 --version
python3 -m venv .venv       # erstellt locales venv
echo 'Virtuelle Umgebung geschaffen!'
echo 'Aktiviere Umgebung.'
source .venv/bin/activate
echo 'Umgebung aktiviert!'

# Benutzer Eingabe der Dependencies:
pip3 install -r $dep.txt
echo 'Alle Dependencies installiert!'

# Folder Struktur erstellen
# schauen ob results existiert oder nicht
if [[ ! -d "results" ]]
then 
    echo "Results Struktur wird erstellt."
    mkdir results
fi

# Folder für gespeicherte Modelle
if [[ ! -d "saved_models" ]]
then 
    echo "Ordner für fertig trainierte Modelle erstellt."
    mkdir saved_models
fi

# Alles in einen extra Folder für die Simulation in results stecken.
current_time=$(date "+%F_%H:%M:%S")
mkdir results/$current_time
cp $dep.txt results/$current_time/$current_time.$dep.txt
cp $simulation.py results/$current_time/$current_time.$simulation.py

# Benutzer Eingabe der Quelldatei
# Ausgabe des Zeitpunktes wo die Berechnung durch ist:
python3 $simulation.py > log_file.log
cp log_file.log results/$current_time/$current_time.log_file.log    # log der simulation
cp -R saved_models/ results/$current_time/$current_time.saved_models  # gespeicherte modelle
rm log_file.log    # entfernen generic log
# rm $dep.txt $simulation.py
rm -r saved_models  # entfernen generic model folder

# Löschen des .venv
rm -r .venv
echo 'Umgebung gelöscht!'

# Fertig!
echo 'Berechnungen beendet!'
