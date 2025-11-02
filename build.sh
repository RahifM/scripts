crave run  --no-patch -- "rm -rf .repo/local_manifests; \
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5; \
sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5; \
git clone https://github.com/RahifM/local_manifests --depth 1 -b lineage-18.1-rv-beryllium .repo/local_manifests; \
/opt/crave/resync.sh; \
export TZ=Asia/Kolkata; \
source build/envsetup.sh; \
lunch lineage_beryllium-user; \
m bacon"
