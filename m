Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47974 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab3J3Ja6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 05:30:58 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: [PATCH V4 0/3] Add watchdog DT nodes and use syscon regmap interfac to
 configure pmu registers
Date: Wed, 30 Oct 2013 15:21:10 +0530
Message-id: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset does the following things
	- Adds pmusysreg device node to exynos5.dtsi file
	- Adds watchdog DT nodes to Exynos5250 and 5420
	- Uses syscon regmap interface to configure pmu registers
	  to mask/unmask enable/disable of watchdog.
	
This patch set is rebased on Kgene's for-next branch and tested on SMDK5420

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

 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   19 +++-
 arch/arm/boot/dts/exynos5.dtsi                     |   12 +--
 arch/arm/boot/dts/exynos5250.dtsi                  |    7 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   10 ++
 drivers/watchdog/s3c2410_wdt.c                     |  112 ++++++++++++++++++--
 5 files changed, 143 insertions(+), 17 deletions(-)

-- 
1.7.10.4

