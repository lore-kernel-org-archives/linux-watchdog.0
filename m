Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:63267 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3I0Jza (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 05:55:30 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	kgene.kim@samsung.com
Cc: devicetree@vger.kernel.org, t.figa@samsung.com,
	dianders@chromium.org, linux-watchdog@vger.kernel.org
Subject: [PATCH V2 0/4] Add watchdog DT nodes and parse it to read PMU
 registers addresses
Date: Fri, 27 Sep 2013 15:46:22 +0530
Message-id: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset does the following things
	- Fixes the watchdog DT node name to follow convention
	- Adds watchdog DT node to Exynos5420 SoC
	- parse the watchdog device node to read pmu wdt sys registers
	  addresses and do mask/unmask enable/disable of WDT in probe
	  and s2r scenarios.

This patch set is rebased on Kgene's for-next branch and tested on SMDK5420

Changes since V1:
	- Added new compatible string for Exynos5 SoCs
	- Introduced quirk mechanism to program PMU registers
	- Addressed comments given by Tomasz Figa <t.figa@samsung.com>

Leela Krishna Amudala (4):
  ARM: dts: Fix the watchdog DT node name for Exynos5
  ARM: dts: add watchdog device tree node for exynos5420
  watchdog: s3c2410_wdt: parse watchdog dt node to read PMU registers
    adresses
  ARM: dts: exynos: add PMU registers addresses and mask bit to
    watchdog node

 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   24 ++++-
 arch/arm/boot/dts/exynos5.dtsi                     |    6 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |    7 ++
 drivers/watchdog/s3c2410_wdt.c                     |   94 ++++++++++++++++++--
 5 files changed, 121 insertions(+), 14 deletions(-)

-- 
1.7.9.5

