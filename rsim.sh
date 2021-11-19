#!/bin/bash
# Erstellt ein python local env 
# installiert alle dependencies

# Benutzer Eingabe der Quelldatei
echo 'Welche Datei soll ausgeführt werden? (ohne .py):'
read simulation

# Folder Struktur erstellen
# schauen ob results existiert oder nicht
if [[ ! -d "results" ]]
then 
    echo "Results Struktur wird erstellt."
    mkdir results
fi

# Folder für gespeicherte Modelle
if [[ ! -d "saved_model" ]]
then 
    echo "Ordner für fertig trainierte Modelle erstellt."
    mkdir saved_model
fi

# Alles in einen extra Folder für die Simulation in results stecken.
current_time=$(date "+%F_%H:%M:%S")
mkdir results/$current_time
cp $simulation.py results/$current_time/$current_time.$simulation.py

# Benutzer Eingabe der Quelldatei
# Ausgabe des Zeitpunktes wo die Berechnung durch ist:
# cp log_file.log results/$current_time/$current_time.log_file.log    # log der simulation
cp -R saved_model/ results/$current_time/$current_time.saved_model  # gespeicherte modelle
# rm log_file.log    # entfernen generic log
# rm $dep.txt $simulation.py
rm -r saved_model  # entfernen generic model folder

# Löschen des .venv
# rm -r .venv
# echo 'Umgebung gelöscht!'

# Fertig!
echo 'Berechnungen beendet!'

# TODO
# Den ganzen Python Quatsch auf R anpassen.
# Ebenso eine Parallelisierungs Option wählen.
