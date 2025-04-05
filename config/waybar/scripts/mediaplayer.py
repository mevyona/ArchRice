#!/usr/bin/env python3
import argparse
import json
import subprocess

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('--player', help='Player to use')
    return parser.parse_args()

def get_player_status(player):
    status = {}
    try:
        # Vérifier si le lecteur est en cours d'exécution
        check_cmd = ['playerctl', '--player=' + player, 'status']
        subprocess.check_output(check_cmd, stderr=subprocess.DEVNULL)
        
        # Obtenir les métadonnées
        cmd = ['playerctl', '--player=' + player, 'metadata', '--format', 
               '{"artist": "{{artist}}", "title": "{{title}}", "status": "{{status}}"}']
        output = subprocess.check_output(cmd, text=True).strip()
        data = json.loads(output)
        
        status = {
            "text": f"{data['artist']} - {data['title']}",
            "class": data['status'].lower(),
            "alt": player,
            "tooltip": f"{data['artist']} - {data['title']} ({data['status']})"
        }
        
        # Si pas en lecture, ajouter une icône play
        if data['status'].lower() != "playing":
            status["text"] = f"▶ {status['text']}"
        else:
            status["text"] = f"⏸ {status['text']}"
    except:
        # Fallback quand aucun lecteur n'est détecté
        status = {
            "text": "Aucune musique",
            "class": "stopped",
            "alt": player,
            "tooltip": "Aucune musique en cours"
        }
    
    return status

def main():
    args = parse_arguments()
    
    if args.player:
        status = get_player_status(args.player)
    else:
        status = get_player_status("spotify,firefox,chromium,brave")
    
    print(json.dumps(status))

if __name__ == "__main__":
    main()