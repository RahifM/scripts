set -e

rm -rf .repo/local_manifests
rm -rf prebuilts/gcc/linux-x86/host/x86_64-w64-mingw32-4.8
rm -rf prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9
rm -rf prebuilts/clang/host/linux-x86
rm -rf prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8

sudo sed -i 's|features = has_journal,extent,huge_file,flex_bg,metadata_csum,metadata_csum_seed,64bit,dir_nlink,extra_isize,orphan_file|features = has_journal,extent,huge_file,flex_bg,metadata_csum,metadata_csum_seed,64bit,dir_nlink,extra_isize|g' /etc/mke2fs.conf

repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --git-lfs
git clone https://github.com/RahifM/local_manifests --depth 1 -b lineage-17.1-beryllium .repo/local_manifests
/opt/crave/resync.sh

export TZ=Asia/Kolkata && echo $(date)

source build/envsetup.sh

lunch lineage_beryllium-user
make installclean
m bacon
