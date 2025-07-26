#variables
log_file=~/install_progress_log.txt

#install curl
sudo apt-get -y install curl
if type -p curl > /dev/null; then
    echo "curl Installed" >> $log_file
else
    echo "curl FAILED TO INSTALL!!!" >> $log_file
fi

#install tmux
sudo apt-get -y install tmux
if type -p tmux > /dev/null; then
    echo "tmux Installed" >> $log_file
else
    echo "tmux FAILED TO INSTALL!!!" >> $log_file
fi

#install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null
if [ -e ~/.tmux/plugins/tpm ]; then
    echo "tmux plugin manager (tpm) Installed" >> $log_file
else
    echo "tmux plugin manager (tpm) FAILE TO INSTALL!!!" >> $log_file
fi

#summary
echo -e "\n====== Summary ======\n"
cat $log_file
rm $log_file