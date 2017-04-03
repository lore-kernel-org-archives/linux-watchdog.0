Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:49665 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbdDCHwV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 03:52:21 -0400
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Zoltan Boszormenyi <zboszor@pr.hu>
Subject: [PATCH 1/3 v2] usb: pci-quirks: Add a common mutex for the I/O port pair of SB800
Date: Mon,  3 Apr 2017 09:51:31 +0200
Message-Id: <20170403075133.12343-2-zboszor@pr.hu>
In-Reply-To: <20170403075133.12343-1-zboszor@pr.hu>
References: <<20170401110223.12056-1-zboszor@pr.hu>>
 <20170403075133.12343-1-zboszor@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds a common mutex in the USB PCI quirks code and starts
using it to synchronize access to the I/O port pair 0xcd6 / 0xcd7 on
SB800.

These I/O ports are also used by i2c-piix4 and sp5100_tco, the next
two patches port these drivers to use this common mutex.

v2: No extra header and no wrapper for mutex_lock() / mutex_unlock()

Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
---
 drivers/usb/host/pci-quirks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index a9a1e4c..1ef0ada 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -279,6 +279,9 @@ bool usb_amd_prefetch_quirk(void)
 }
 EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
 
+DEFINE_MUTEX(sb800_mutex);
+EXPORT_SYMBOL_GPL(sb800_mutex);
+
 /*
  * The hardware normally enables the A-link power management feature, which
  * lets the system lower the power consumption in idle states.
@@ -314,11 +317,13 @@ static void usb_amd_quirk_pll(int disable)
 	if (amd_chipset.sb_type.gen == AMD_CHIPSET_SB800 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_HUDSON2 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_BOLTON) {
+		mutex_lock(&sb800_mutex);
 		outb_p(AB_REG_BAR_LOW, 0xcd6);
 		addr_low = inb_p(0xcd7);
 		outb_p(AB_REG_BAR_HIGH, 0xcd6);
 		addr_high = inb_p(0xcd7);
 		addr = addr_high << 8 | addr_low;
+		mutex_unlock(&sb800_mutex);
 
 		outl_p(0x30, AB_INDX(addr));
 		outl_p(0x40, AB_DATA(addr));
-- 
2.9.3

