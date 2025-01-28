#/usr/bin/env bash
NO='\033[0m'
BOLD_LINE='\033[1;4m'
RED_BOLD='\033[0;31m'

pwd=$(pwd)
USER=$(id -u -n)
source_file=$(find $pwd -maxdepth 1 -type f -name .setup_roscontr.bash)

folder_name="ROS"

if [[ "$USER" == "root" ]]; then
  echo -e "${RED_BOLD}Please RUN without sudo!${NO}"
  exit
else
  if [ -n "$source_file" ];then

    mkdir -p /home/$USER/$folder_name
    mkdir -p /home/$USER/$folder_name/humble

    chmod +x $pwd/ros_contr
    mkdir -p /home/$USER/.local/bin/
    sudo mv $pwd/ros_contr /home/$USER/.local/bin/
    sudo ln -s /home/$USER/.local/bin/ros_contr /usr/local/bin/
    mv $pwd/* /home/$USER/$folder_name/
    mv $pwd/.*[a-z] /home/$USER/$folder_name/

    sudo echo "">> /home/$USER/.bashrc
    sudo echo "# ros_container source file">> /home/$USER/.bashrc
    sudo echo "source /home/$USER/$folder_name/.setup_roscontr.bash">> /home/$USER/.bashrc
    sudo echo "">> /home/$USER/.bashrc

    echo -e "${BOLD_LINE}Installation completed!${NO}"
    ros_contr help
  else
    echo -e "${RED_BOLD}Please run this script under its location!${NO}"
  fi
fi
