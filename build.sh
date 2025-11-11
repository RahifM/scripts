crave run  --no-patch -- "set -e; \
rm -rf .repo/local_manifests; \
repo init -u https://github.com/LineageOS/android.git -b cm-14.1 --git-lfs; \
git clone https://github.com/RahifM/local_manifests --depth 1 -b cm-14.1 .repo/local_manifests; \
/opt/crave/resync.sh; \
export TZ=Asia/Kolkata && echo $(date); \
export LC_ALL=C; \
source build/envsetup.sh; \
lunch lineage_wt88047-user; \
make installclean; \
m bacon"
