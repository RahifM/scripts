run  --no-patch -- "rm -rf .repo/local_manifests; \
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5; \
sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5; \
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs; \
git clone https://github.com/RahifM/local_manifests --depth 1 -b lineage-18.1-beryllium .repo/local_manifests; \
/opt/crave/resync.sh; \
export TZ=Asia/Kolkata && echo $(date); \
source build/envsetup.sh; \
repopick -t R_asb_2024-03; \
lunch lineage_beryllium-user; \
make installclean; \
m bacon"
