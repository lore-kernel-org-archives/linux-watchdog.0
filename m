Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7117 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbaDANuL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Apr 2014 09:50:11 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-janitors@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] watchdog: via_wdt: replace del_timer by del_timer_sync
Date: Tue,  1 Apr 2014 15:49:19 +0200
Message-Id: <1396360159-16244-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1396360159-16244-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1396360159-16244-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use del_timer_sync to ensure that the timer is stopped on all CPUs before
the driver exits.

This change was suggested by Thomas Gleixner.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier i,t,ex;
@@
struct t i = { .remove = ex, };

@@
identifier r.ex;
@@
ex(...) {
  <...
- del_timer
+ del_timer_sync
    (...)
  ...>
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 drivers/watchdog/via_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index d2cd9f0..56369c4 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -232,7 +232,7 @@ err_out_disable_device:
 static void wdt_remove(struct pci_dev *pdev)
 {
 	watchdog_unregister_device(&wdt_dev);
-	del_timer(&timer);
+	del_timer_sync(&timer);
 	iounmap(wdt_mem);
 	release_mem_region(mmio, VIA_WDT_MMIO_LEN);
 	release_resource(&wdt_res);

