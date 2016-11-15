Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-db5eur01on0097.outbound.protection.outlook.com ([104.47.2.97]:23583
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752266AbcKPHey (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 Nov 2016 02:34:54 -0500
From: Cor Peters <cpeters@victronenergy.com>
To: <linux-omap@vger.kernel.org>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH 0/2] Watchdog: omap_wdt: Retrieve bootstatus via syscon
Date: Tue, 15 Nov 2016 09:44:01 +0100
Message-ID: <30190331.OfTuxcilGU@corpeters>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch series adds device tree compatiblility to the watchdog status 
feature from the omap-wdt driver and adds support for that feature to
the am33xx.dti device-tree include.

It is my first patch so any comments/suggestions are welcome.

Cor Peters (2):
  Watchdog: omap_wdt: Retrieve bootstatus via syscon.
  ARM: am33xx.dtsi: Added syscon compatible prcm_dev device

 arch/arm/boot/dts/am33xx.dtsi |  6 ++++++
 drivers/watchdog/omap_wdt.c   | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
1.9.1

