Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32238 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3KGLbS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Nov 2013 06:31:18 -0500
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: [PATCH V6 0/3] Add watchdog DT nodes and use syscon regmap interfac to
 configure pmu registers
Date: Thu, 07 Nov 2013 17:21:15 +0530
Message-id: <1383825078-24515-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset does the following things
	- Adds pmusysreg device node to exynos5.dtsi file
	- Adds watchdog DT nodes to Exynos5250 and 5420
	- Uses syscon regmap interface to configure pmu registers
	  to mask/unmask enable/disable of watchdog.
	
This patch set is rebased on Kgene's for-next branch and tested on SMDK5420

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
  ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
  ARM: dts: add watchdog device nodes for Exynos5250 and Exynos5420
  watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu
    register

 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
 arch/arm/boot/dts/exynos5.dtsi                     |   12 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    6 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |    9 ++
 drivers/watchdog/s3c2410_wdt.c                     |  139 ++++++++++++++++++--
 5 files changed, 170 insertions(+), 17 deletions(-)

-- 
1.7.10.4

