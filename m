Return-path: <carlo.caione@gmail.com>
Sender: Carlo Caione <carlo.caione@gmail.com>
From: Carlo Caione <carlo@caione.org>
To: wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	b.galvani@gmail.com
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH] ARM: meson: watchdog: remove magic value for reboot
Date: Thu,  9 Oct 2014 21:59:16 +0200
Message-Id: <1412884756-20943-1-git-send-email-carlo@caione.org>
List-ID: <linux-watchdog@vger.kernel.org>

This patch removes the magic value used for rebooting the board. This
value is useless and leads to a static checker warning as reported by
Dan Carpenter.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/watchdog/meson_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 37f9f5ec..ef6a298 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -51,7 +51,7 @@ struct meson_wdt_dev {
 static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
 				void *cmd)
 {
-	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN | 100;
+	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
 	struct meson_wdt_dev *meson_wdt = container_of(this,
 						       struct meson_wdt_dev,
 						       restart_handler);
-- 
1.9.1
