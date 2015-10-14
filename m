Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:23965
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752060AbbJNL53 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 07:57:29 -0400
From: Zhiqiang Hou <B48286@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>
CC: <Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<scottwood@freescale.com>, <bhupesh.sharma@freescale.com>,
	<leoli@freescale.com>, <wsa@the-dreams.de>, <wim@iguana.be>,
	<corbet@lwn.net>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <Wenbin.Song@freescale.com>
Subject: [PATCH V3 0/6] Add LS1043A SoC support 
Date: Wed, 14 Oct 2015 19:34:52 +0800
Message-ID: <1444822498-16477-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchest adds support for Freescale's LS1043A SoC which is
based on ARMv8 architecture.

Some pending patches are depended on:
1. The LS1043A is belong to Freescale's ARMv8 Layerscape SoC family,
so depends on the updating ARCH kconfig patch.
https://patchwork.kernel.org/patch/7120101/

2. The LS1043A use the new clockgen binding updated by Scott Wood,
depends on the patchset:
https://patchwork.kernel.org/patch/7225421/
https://patchwork.kernel.org/patch/7225461/
https://patchwork.kernel.org/patch/7225431/
https://patchwork.kernel.org/patch/7225441/
https://patchwork.kernel.org/patch/7225451/

[PATCH V3 1/6] i2c: Add i2c support to Freescale Layerscape platforms
[PATCH V3 2/6] watchdog: Add support for Freescale Layerscape
[PATCH V3 3/6] Documentation: DT: Add entry for FSL LS1043ARDB board
[PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
[PATCH V3 5/6] clk: qoriq: Add ls1043a support.
[PATCH V3 6/6] dts/ls1043a: add LS1043ARDB board support
