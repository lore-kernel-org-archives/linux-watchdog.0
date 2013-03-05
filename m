Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52862 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933245Ab3CEEye (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 23:54:34 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/8] watchdog: w83627hf: Enable watchdog device only if not already enabled
Date: Mon,  4 Mar 2013 20:54:14 -0800
Message-Id: <1362459259-9733-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362459259-9733-1-git-send-email-linux@roeck-us.net>
References: <1362459259-9733-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is no need to enable the watchdog device if it is already enabled.
Also, when enabling the watchdog device, only set the watchdog device
enable bit and do not touch other bits; depending on the chip type,
those bits may enable other functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/w83627hf_wdt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 98a4fd0..6f023e1 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -95,7 +95,9 @@ static void w83627hf_init(void)
 	}
 
 	outb_p(0x30, WDT_EFER); /* select CR30 */
-	outb_p(0x01, WDT_EFDR); /* set bit 0 to activate GPIO2 */
+	t = inb(WDT_EFDR);
+	if (!(t & 0x01))
+		outb_p(t | 0x01, WDT_EFDR); /* set bit 0 to activate GPIO2 */
 
 	outb_p(0xF6, WDT_EFER); /* Select CRF6 */
 	t = inb_p(WDT_EFDR);      /* read CRF6 */
-- 
1.7.9.7

