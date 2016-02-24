Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36264 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbcBXRrU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 12:47:20 -0500
Received: by mail-io0-f193.google.com with SMTP id b188so3223291iof.3
        for <linux-watchdog@vger.kernel.org>; Wed, 24 Feb 2016 09:47:19 -0800 (PST)
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v3 4/6] watchdog: pnx4008: restart: support "cmd" from userspace
Date: Wed, 24 Feb 2016 12:46:56 -0500
Message-Id: <1456336018-6620-5-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
- if a valid "cmd" is available, handle it;
- If the received "cmd" is not supported, use the default reboot mode.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v2 to v3:
- no logical change; updated to work with new revision of patch #2.

Changes from v1 to v2:
- Rename patch title;
  was "arm: lpc32xx: restart: support "cmd" from userspace"
- Add change to "pnx-4008" driver instead of "mach-lpc32xx".

 drivers/watchdog/pnx4008_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index fbf027e..e97b611 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -130,6 +130,21 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
 static int pnx4008_restart_handler(struct notifier_block *this,
 				   unsigned long mode, void *cmd)
 {
+	const char *boot_cmd = (const char *)cmd;
+
+	/*
+	 * Verify if a "cmd" passed from the userspace program rebooting
+	 * the system; if available, handle it.
+	 * - For details, see the 'reboot' syscall in kernel/reboot.c
+	 * - If the received "cmd" is not supported, use the default mode.
+	 */
+	if (boot_cmd) {
+		if (boot_cmd[0] == 'h')
+			mode = (unsigned long)REBOOT_HARD;
+		else if (boot_cmd[0] == 's')
+			mode = (unsigned long)REBOOT_SOFT;
+	}
+
 	if (mode == (unsigned long)REBOOT_SOFT) {
 		/* Force match output active */
 		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
-- 
1.8.3.1

