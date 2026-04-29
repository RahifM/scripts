set -e

sudo apt update
sudo apt install openjdk-8-jdk libncurses6 -y
sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
java -version
javac -version
sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6 /usr/lib/x86_64-linux-gnu/libncursesw.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5


rm -rf .repo/local_manifests
repo init -u https://github.com/LineageOS/android.git -b cm-14.1 --depth=1 --git-lfs
git clone https://github.com/RahifM/local_manifests --depth 1 -b cm-14.1 .repo/local_manifests
/opt/crave/resync.sh
export TZ=Asia/Kolkata && echo $(date)
export LC_ALL=C
sudo sed -i 's|jdk.tls.disabledAlgorithms=SSLv3, TLSv1, TLSv1.1|jdk.tls.disabledAlgorithms=SSLv3|g' /etc/java-8-openjdk/security/java.security
source build/envsetup.sh
lunch lineage_wt88047-user
make installclean
m bacon
