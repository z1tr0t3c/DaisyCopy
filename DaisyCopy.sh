# DaisyCopy

# Dieses Programm zipt automatisch den Inhalt einer Daisy-CD, so dass sie mit Software Daisy-Playern kompatibel wird.

# Copyright (c) 2017  Falk Rismansanj

# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.

echo "Wilkommen zu DaisyCopy!"
echo "Version: 1.0 by z1tr0t3c - http://zitrotec.de"
echo "Suche Daisy-CD..."
id=$(drutil status | grep -m1 -o '/dev/disk[0-9]*')
if [ -z "$id" ]; then
  echo "Fehler! Es konnte keine Daisy-CD gefunden werden."
else
path1=$(df | grep "$id" | grep -o /Volumes.*)
echo "Daisy-CD gefunden: $path1"
read -e -p "Gib bitte den Pfad zum speichern der Daten an: " path2
echo "OK, $path2"
echo "Kopiere Daten..."
rsync -a -P $path1/* $path2/
echo "Fertig!"
echo "Daisy-CD wird ausgeworfen..."
drutil eject
echo -n "Bitte gib einen Dateinamen für die ZIP-Datei an: "
read filename
echo "OK $filename.zip"
echo "Erstelle Archiv..."
cd $path2
zip -D -jm "$filename.zip" * -x "*/.*"
echo "Fertig!"
fi
