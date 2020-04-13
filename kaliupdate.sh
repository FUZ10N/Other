#!/bin/bash
#Kali VM Customizer - For ISO's prior to 2020.1
#Updating Kali VM

echo "[+] --- UPDATING KALI VM --- [+]"
apt update && apt upgrade -y && apt dist-upgrade -y

#Installing additional tools
echo "[+] --- INSTALLING ADDITIONAL TOOLS --- [+]"
apt install powershell -y
apt install powershell-empire -y
apt install terminator -y
apt install gedit -y
apt install gobuster -y
apt install chromium -y
apt install crackmapexec -y
apt install xclip -y
apt install golang -y
apt install masscan -y


cd /usr/share/wordlists
gunzip rockyou.txt.gz
crackmapexec

service postgresql start
searchsploit --update
msfdb init

#Pulling tools from Github repos
cd /opt
echo "[+] --- INSTALLING TOOLS FROM GITHUB --- [+]"

wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip

unzip aquatone_linux_amd64_1.7.0.zip
#rm README.md
#rm LICENSE.txt

cp aquatone /usr/local/bin/aquatone

cd /opt

wget https://github.com/sc0tfree/mentalist/releases/download/v1.0/Mentalist-v1.0-Linux-x86_64.zip
unzip Mentalist-v1.0-Linux-x86_64.zip

#rm * .zip

cd /usr/share/windows-binaries
wget https://eternallybored.org/misc/netcat/netcat-win32-1.11.zip
unzip netcat-win32-1.11.zip
#rm unzip netcat-win32-1.11.zip

#cd /opt
#wget  https://download.visualstudio.microsoft.com/download/pr/022d9abf-35f0-4fd5-8d1c-86056df76e89/477f1ebb70f314054129a9f51e9ec8ec/dotnet-sdk-2.2.207-linux-x64.tar.gz

#tar -zxvf dotnet-sdk-2.2.207-linux-x64.tar.gz

#wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

#sudo dpkg -i packages-microsoft-prod.deb
#sudo apt-get update
#sudo apt-get install apt-transport-https -y
#sudo apt-get install dotnet-sdk-2.2 -y
#rm *.tar.gz

#cd /opt
#git clone --recurse-submodules https://github.com/cobbr/Covenant
#cd /opt/Covenant/Covenant
#dotnet build
#dotnet build

cd /opt

git clone https://github.com/Genetic-Malware/Ebowla.git
git clone https://github.com/SecureAuthCorp/impacket.git
gem install evil-winrm
git clone https://github.com/fox-it/mitm6.git
cd /opt/mitm6
pip3 install -r requirements.txt
cd /opt

git clone https://github.com/lgandx/Responder.git

cd /opt/impacket
pip3 install .

cd /opt
mkdir privesc
cd /opt/privesc

git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
git clone https://github.com/PowerShellMafia/PowerSploit.git
git clone https://github.com/danielbohannon/Invoke-CradleCrafter.git
wget https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200308-1/mimikatz_trunk.zip
unzip mimikatz_trunk.zip
#rm mimikatz_trunk.zip

cd /opt
git clone https://github.com/samratashok/nishang.git

mkdir recon

cd /usr/share/wordlists
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/praetorian-code/Hob0Rules.git

cd ~/
echo "GOPATH=$HOME/.go" >> ~/.bashrc
echo "export GOPATH" >> ~/.bashrc
echo "PATH=\$PATH:\$GOPATH/bin # Add GOPATH/bin to PATH for scripting" >> ~/.bashrc
source ~/.bashrc

go get github.com/ffuf/ffuf

#Creating Gitrepo Update Script

cd /opt
echo"[+] ---CREATING GITHUB REPO UPDATE SCRIPT --- [+]"
cat << 'EOF' >> /opt/updategit.sh
#!/bin/bash
find . -type d -mindepth 1 -maxdepth 2 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
EOF
chmod +x /opt/updategit.sh

#Updating Kali VM Again
echo "[+] --- CHECKING FOR NEW UPDATES --- [+]"
apt update && apt upgrade -y && apt dist-upgrade -y

#Upgrading Kali VM to XFCE
#apt install kali-desktop-xfce -y
#update-alternatives --config x-session-manager

cd /opt
#rm *.txt
#rm *.MD
#bash updategit.sh

apt update && apt upgrade -y && apt dist-upgrade -y

#shutdown -r now
