Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdG0SI7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Jul 2017 14:08:59 -0400
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyaosid@gmail.com,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/1] watchdog: iTCO_wdt: Move update_no_reboot_bit() out of atomic context
Date: Thu, 27 Jul 2017 11:08:44 -0700
Message-Id: <92432e9cc40ba7f37f677386e7f3c5eb815dc26a.1501178882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In iTCO_wdt_start() and iTCO_wdt_stop() functions, update_no_reboot_bit()
call has been made within io_lock spin lock context. But if the
update_no_reboot_bit() function is implemented by chipset/PMC driver
then we can't be sure whether their implementation does not include any
sleeping calls. Also, iTCO_wdt io_lock is mainly intended for protecting the
watchdog IO operations and has nothing to with no_reboot_bit update.

Currently, update_no_reboot_bit() function implemented by intel_pmc_ipc
driver uses mutex_lock() which in turn causes "sleeping into atomic
context" issue in iTCO_wdt_start()/iTCO_wdt_stop() functions.

So moving the update_no_reboot_bit() function out of atomic context.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/watchdog/iTCO_wdt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index c4f6587..5a018b2 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -243,17 +243,16 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 	struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
 	unsigned int val;
 
-	spin_lock(&p->io_lock);
-
-	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
-
 	/* disable chipset's NO_REBOOT bit */
 	if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
-		spin_unlock(&p->io_lock);
 		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
 		return -EIO;
 	}
 
+	spin_lock(&p->io_lock);
+
+	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
+
 	/* Force the timer to its reload value by writing to the TCO_RLD
 	   register */
 	if (p->iTCO_version >= 2)
@@ -288,11 +287,11 @@ static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
 	outw(val, TCO1_CNT(p));
 	val = inw(TCO1_CNT(p));
 
+	spin_unlock(&p->io_lock);
+
 	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
 	p->update_no_reboot_bit(p->no_reboot_priv, true);
 
-	spin_unlock(&p->io_lock);
-
 	if ((val & 0x0800) == 0)
 		return -1;
 	return 0;
-- 
2.7.4

