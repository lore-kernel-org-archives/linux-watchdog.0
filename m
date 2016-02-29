Return-path: <slemieux.tyco@gmail.com>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org,
	wim@iguana.be,
	stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v5 4/6] watchdog: pnx4008: restart: support "cmd" from userspace
Date: Mon, 29 Feb 2016 12:31:06 -0500
Message-Id: <1456767068-14449-5-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
- if a valid "cmd" is available, handle it;
- If the received "cmd" is not supported, use the default reboot mode.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v4 to v5:
- no logical change; updated to work with new revision of patch #2.

Changes from v3 to v4:
- none.

Changes from v2 to v3:
- no logical change; updated to work with new revision of patch #2.

Changes from v1 to v2:
- Rename patch title;
  was "arm: lpc32xx: restart: support "cmd" from userspace"
- Add change to "pnx-4008" driver instead of "mach-lpc32xx".

 drivers/watchdog/pnx4008_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index e05bfecf..df76231 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -129,6 +129,21 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
 static int pnx4008_restart_handler(struct watchdog_device *wdd,
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
