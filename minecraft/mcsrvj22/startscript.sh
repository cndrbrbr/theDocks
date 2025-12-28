#!/bin/bash
#######################################################
# Start Minecraft Server Docker
# 
#
# (c) 2022 cndrbrbr start container
# (c) 2025 cndrbrbr 
#          do setup if necessary 
#          mcsrvj22
#######################################################

#!/bin/bash

SCRIPT_A="/root/mcsrvbase/start.sh"
SCRIPT_B="/root/setupfiles.sh"


# Prüfen ob Script A existiert
if [[ -f "$SCRIPT_A" ]]; then
    echo "$SCRIPT_A gefunden. Starte $SCRIPT_A ..."
    bash "$SCRIPT_A"
else
    echo "$SCRIPT_A nicht gefunden!"

    echo "Starte zuerst $SCRIPT_B..."

    bash "$SCRIPT_B"
    sleep 10
    echo "Versuche erneut, scriptA.sh auszuführen..."

    if [[ -f "$SCRIPT_A" ]]; then
        echo "$SCRIPT_A ist jetzt vorhanden. Starte $SCRIPT_A ..."
        bash "$SCRIPT_A"
    else
        echo "$SCRIPT_A existiert immer noch nicht! Abbruch."
        exit 1
    fi
fi
