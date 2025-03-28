repo init --depth=1 --git-lfs --no-repo-verify -u git://github.com/syberia-project/manifest.git -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/GunaisHere/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# build rom
source build/envsetup.sh
lunch miatoll-release
export BUILD_USERNAME=GL_Founder
export TZ=Asia/Dhaka #put before last build command
m projectsyberia

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
