Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:38119 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbdFUEEQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Jun 2017 00:04:16 -0400
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
Subject: [PATCH 3/5] usb: pci-quirks: Protect the I/O port pair of SB800
Date: Wed, 21 Jun 2017 05:53:47 +0200
Message-Id: <20170621035349.4125-4-zboszor@pr.hu>
In-Reply-To: <20170621035349.4125-1-zboszor@pr.hu>
References: <20170403075133.12343-1-zboszor@pr.hu>
 <20170621035349.4125-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch uses the previously introduced macro called
request_declared_muxed_region() to synchronize access to
the I/O port pair 0xcd6 / 0xcd7 on SB800.

These I/O ports are also used by i2c-piix4 and sp5100_tco,
the next two patches port these drivers to use the new macro.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/usb/host/pci-quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index a9a1e4c..703eb65 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -314,11 +314,14 @@ static void usb_amd_quirk_pll(int disable)
 	if (amd_chipset.sb_type.gen == AMD_CHIPSET_SB800 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_HUDSON2 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_BOLTON) {
+		struct resource res = DEFINE_RES_IO_NAMED(0xcd6, 2, "USB host SB800/HUDSON2/BOLTON");
+		request_declared_muxed_region(&res);
 		outb_p(AB_REG_BAR_LOW, 0xcd6);
 		addr_low = inb_p(0xcd7);
 		outb_p(AB_REG_BAR_HIGH, 0xcd6);
 		addr_high = inb_p(0xcd7);
 		addr = addr_high << 8 | addr_low;
+		release_region(0xcd6, 2);
 
 		outl_p(0x30, AB_INDX(addr));
 		outl_p(0x40, AB_DATA(addr));
-- 
2.9.4

