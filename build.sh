set -e

rm -rf .repo/local_manifests
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs
/opt/crave/resync.sh
export TZ=Asia/Kolkata && echo $(date)
source build/envsetup.sh

# start asb pick
repopick -t R_asb_2024-03 && repopick -t R_asb_2024-04
repopick -t R_asb_2024-05
repopick -t R_asb_2024-06 && repopick -t R_asb_2024-07 && repopick -t R_asb_2024-08 && repopick -t R_asb_2024-09 && repopick -t R_asb_2024-10 && repopick -t R_asb_2024-11 && repopick -t R_asb_2024-12 && repopick -t R_asb_2025-01 && repopick -t R_asb_2025-02 && repopick -t R_asb_2025-03 && repopick -t R_asb_2025-04 && repopick -t R_asb_2025-05 && repopick -t R_asb_2025-06 && repopick -t R_asb_2025-09
lunch lineage_beryllium-user
make installclean
m bacon
