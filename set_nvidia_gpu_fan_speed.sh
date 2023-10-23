echo "Setting GPU Fan Speed"

nvidia-settings -c :1 -a "[gpu:0]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=50" -a "[fan:1]/GPUTargetFanSpeed=50"

nvidia-settings -c :1 -a "[gpu:1]/GPUFanControlState=1"
