Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:40668 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdJTXEh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Oct 2017 19:04:37 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/3] watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
Date: Fri, 20 Oct 2017 16:54:48 -0600
Message-Id: <fdb84d723278f8f198a59f79e31d8903870fb2a0.1508539271.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508539271.git.jerry.hoemann@hpe.com>
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508539271.git.jerry.hoemann@hpe.com>
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for WDIOC_GETPRETIMEOUT ioctl so that user applications
can determine when the NMI should arrive.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 67fbe35..ef54b03 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -50,6 +50,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static char expect_release;
 static unsigned long hpwdt_is_open;
+static const int pretimeout = 9;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_timer_reg;
@@ -622,6 +623,12 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 
+	case WDIOC_GETPRETIMEOUT:
+		ret = copy_to_user(argp, &pretimeout, sizeof(pretimeout));
+		if (ret)
+			ret = -EFAULT;
+		break;
+
 	case WDIOC_SETTIMEOUT:
 		ret = get_user(new_margin, p);
 		if (ret)
-- 
1.8.3.1

