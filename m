Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22715 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3KRJaH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Nov 2013 04:30:07 -0500
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org, linux@roeck-us.net
Subject: [PATCH V9 0/3] Add watchdog DT nodes and use syscon regmap interface
 to configure pmu registers
Date: Mon, 18 Nov 2013 15:19:46 +0530
Message-id: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset does the following things
	- Adds pmusysreg device node to exynos5.dtsi file
	- Adds watchdog DT nodes to Exynos5250 and 5420
	- Uses syscon regmap interface to configure pmu registers
	  to mask/unmask enable/disable of watchdog.
	
This patch set is rebased on Kgene's for-next branch and tested on SMDK5420

changes since V8:
	- modified the patch description for the below patch
	  "watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register"
	- removed MODULE_ALIAS in watchdog driver
	- changed dev_warn to dev_err in one failure case handling (suggested by Guenter Roeck <linux@roeck-us.net>)
	- renamed variable name from pmu_config to drv_data
	- changed the compatible field description in documentation file
	  (suggested by Tomasz Figa <t.figa@samsung.com>)

changes since V7:
	- re-ordered the patches in the series
	- moved pmu_config_s3c2410 structure out of ifdef CONFIG_OF
	  and limited only this structure to platform match table
	- renamed structure name from s3c_wdt_driver_ids to s3c2410_wdt_ids
	- removed exynos variants from platform match table
	  (suggested by Tomasz Figa <t.figa@samsung.com>)

changes since V6:
	- added SoC-specific compatible value to syscon node and documented it
	- given more patch description for below patch
	  ARM: dts: update watchdog device nodes for Exynos5250 and Exynos5420
	- added platform_device_id array for watchdog devices
	- selected MFD_SYSCON in Kconfig entry for watchdog

Changes since V5:
	- removed status property in DT nodes
	- changed the return type for the function s3c2410wdt_mask_and_disable_reset()
	  and handled error cases
	- Handled to get driver data in non-DT cases
	- Addressed comments given by Tomasz Figa <t.figa@samsung.com>

Changes since V4:
	- changed the node name from pmusysreg to syscon and node label from pmu_sys_reg to pmu_syscon
	- changed the property name from samsung,pmusysreg to samsung,syscon-phandle
	- used regmap_update_bits instead of remap_read/regmap_write
	- Addressed other comments given by Tomasz Figa <t.figa@samsung.com>

Changes since V3:
	- changed the compatible strings for watchdog node
	- splitted up adding pmusysreg node and made it separate patch
	- Addressed comments given by Sachin Kamat <sachin.kamat@linaro.org>

Changes since V2:
	- used syscon regmap interface to configure pmu registers in WDT driver
	  (suggested by Tomasz Figa <t.figa@samsung.com>)

Changes since V1:
        - Added new compatible string for Exynos5 SoCs
        - Introduced quirk mechanism to program PMU registers
        - Addressed comments given by Tomasz Figa <t.figa@samsung.com>

Leela Krishna Amudala (3):
  ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
  watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu
    register
  ARM: dts: update watchdog device nodes for Exynos5250 and Exynos5420

 .../devicetree/bindings/arm/samsung/pmu.txt        |   16 +++
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
 arch/arm/boot/dts/exynos5.dtsi                     |    7 -
 arch/arm/boot/dts/exynos5250.dtsi                  |   11 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   14 ++
 drivers/watchdog/Kconfig                           |    1 +
 drivers/watchdog/s3c2410_wdt.c                     |  145 ++++++++++++++++++--
 7 files changed, 197 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt

-- 
1.7.10.4

