Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:59377 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574Ab2FHKJP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 06:09:15 -0400
From: Tony Zelenoff <antonz@parallels.com>
To: <linux-watchdog@vger.kernel.org>
CC: <wim@iguana.be>, <antonz@parallels.com>
Subject: [PATCH] iTCO_wdt: remove unnecessary includes
Date: Fri, 8 Jun 2012 14:09:14 +0400
Message-ID: <1339150154-25247-2-git-send-email-antonz@parallels.com>
In-Reply-To: <1339150154-25247-1-git-send-email-antonz@parallels.com>
References: <1339150154-25247-1-git-send-email-antonz@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After switching to new kernel interface, those
includes are not needed anymore.

Signed-off-by: Tony Zelenoff <antonz@parallels.com>
---
 drivers/watchdog/iTCO_wdt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 14e48d9..8cfa574 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -59,12 +59,10 @@
 							(WATCHDOG_MINOR) */
 #include <linux/watchdog.h>		/* For the watchdog specific items */
 #include <linux/init.h>			/* For __init/__exit/... */
-#include <linux/fs.h>			/* For file operations */
 #include <linux/platform_device.h>	/* For platform_driver framework */
 #include <linux/pci.h>			/* For pci functions */
 #include <linux/ioport.h>		/* For io-port access */
 #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
-#include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For inb/outb/... */
 #include <linux/mfd/core.h>
 #include <linux/mfd/lpc_ich.h>
-- 
1.7.1

