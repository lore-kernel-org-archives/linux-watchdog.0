Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49796 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbdJZQK3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 12:10:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id b189so8898837wmd.4
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 09:10:28 -0700 (PDT)
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 4/4] watchdog: i6300esb: remove info message and version number
Date: Thu, 26 Oct 2017 17:10:16 +0100
Message-Id: <20171026161016.3198-4-rrendec@arista.com>
In-Reply-To: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
References: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The initial info message (early in the esb_probe() function) is not very
useful and we already have a message on successful probe, which includes
device identification. If the probe fails (e.g. PCI related errors),
additional messages are printed anyway.

The version number was only used in the initial info message. Other than
that, it serves no useful purpose and it ran out of favor upstream
anyway.

Signed-off-by: Radu Rendec <rrendec@arista.com>
---
 drivers/watchdog/i6300esb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 4d92925cdc1e..950c71a8bb22 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -30,8 +30,6 @@
  *      Includes, defines, variables, module parameters, ...
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -45,7 +43,6 @@
 #include <linux/io.h>
 
 /* Module and version information */
-#define ESB_VERSION "0.05"
 #define ESB_MODULE_NAME "i6300ESB timer"
 
 /* PCI configuration registers */
@@ -76,9 +73,6 @@
 #define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
 #define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
 
-/* Probed devices counter; used only for printing the initial info message */
-static int cards_found;
-
 /* module parameters */
 /* 30 sec default heartbeat (1 < heartbeat < 2*1023) */
 #define ESB_HEARTBEAT_MIN	1
@@ -302,11 +296,6 @@ static int esb_probe(struct pci_dev *pdev,
 	struct esb_dev *edev;
 	int ret;
 
-	cards_found++;
-	if (cards_found == 1)
-		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
-			ESB_VERSION);
-
 	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
 	if (!edev)
 		return -ENOMEM;
-- 
2.13.6

