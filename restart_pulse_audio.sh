echo "Restarting Pulse audio services!"

systemctl --user restart pulseaudio.service

systemctl --user restart pulseaudio.socket
