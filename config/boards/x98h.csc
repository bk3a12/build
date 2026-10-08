# Allwinner H618 quad core 2GB RAM SoC WiFi USB
BOARD_NAME="X98H"
BOARDFAMILY="sun50iw9"
BOARD_MAINTAINER="Nick A"
BOOTCONFIG="x98h_defconfig"
OVERLAY_PREFIX="sun50i-h616"
BOOT_LOGO="desktop"
KERNEL_TARGET="edge,dev"
FORCE_BOOTSCRIPT_UPDATE="yes"

function custom_kernel_config__x98h_aic8800() {
	kernel_config_modifying_hashes+=("CONFIG_AIC_SDIO_WLAN_SUPPORT=y" "CONFIG_AIC8800_WLAN_SUPPORT=m" "CONFIG_AIC8800_BTLPM_SUPPORT=m")
	[[ -f .config ]] || return 0
	kernel_config_set_y AIC_SDIO_WLAN_SUPPORT
	kernel_config_set_m AIC8800_WLAN_SUPPORT
	kernel_config_set_m AIC8800_BTLPM_SUPPORT
}
function post_family_tweaks__x98h() {
	display_alert "Linking AIC8800 SDIO firmware" "${BOARD}" "info"
	if [[ -d "${SDCARD}/lib/firmware/aic8800/SDIO/aic8800D80" ]]; then
		ln -sfn "aic8800/SDIO/aic8800D80" "${SDCARD}/lib/firmware/aic8800_sdio"
	else
		display_alert "armbian-firmware has no aic8800D80 dir" "wifi firmware missing" "wrn"
	fi
}