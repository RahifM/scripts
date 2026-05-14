set -e

sudo apt update
sudo apt install openjdk-8-jdk libncurses6 -y
sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
source ~/.bashrc
sudo ln -sf /etc/ssl/certs/java/cacerts ${JAVA_HOME}/jre/lib/security/cacerts
echo $JAVA_HOME
echo $PATH
java -version
javac -version
sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6 /usr/lib/x86_64-linux-gnu/libncursesw.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5

pwd && ls && rm -rf pt && mkdir pt && cd pt
wget http://security.ubuntu.com/ubuntu/pool/universe/p/python2.7/python2.7_2.7.18-13ubuntu1.5_amd64.deb http://security.ubuntu.com/ubuntu/pool/universe/p/python2.7/libpython2.7-stdlib_2.7.18-13ubuntu1.5_amd64.deb http://security.ubuntu.com/ubuntu/pool/universe/p/python2.7/python2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb http://security.ubuntu.com/ubuntu/pool/universe/p/python2.7/libpython2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb
sudo apt install ./libpython2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb ./libpython2.7-stdlib_2.7.18-13ubuntu1.5_amd64.deb ./python2.7-minimal_2.7.18-13ubuntu1.5_amd64.deb ./python2.7_2.7.18-13ubuntu1.5_amd64.deb -y
sudo rm -rf /usr/bin/python
sudo ln -s /usr/bin/python2.7 /usr/bin/python
python --version
cd ../

rm -rf .repo/local_manifests
repo init -u https://github.com/LineageOS/android.git -b cm-14.1 --depth=1 --git-lfs
git clone https://github.com/RahifM/local_manifests --depth 1 -b cm-14.1 .repo/local_manifests
/opt/crave/resync.sh
export TZ=Asia/Kolkata && echo $(date)
export LC_ALL=C
sudo sed -i 's|jdk.tls.disabledAlgorithms=SSLv3, TLSv1, TLSv1.1|jdk.tls.disabledAlgorithms=SSLv3|g' /etc/java-8-openjdk/security/java.security
java -version
javac -version
source build/envsetup.sh
lunch lineage_wt88047-user
make installclean
m bacon
