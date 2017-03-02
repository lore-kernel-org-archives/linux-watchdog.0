Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53213 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdCBVsq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 16:48:46 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wenyou.Yang@microchip.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 4/4] watchdog: sama5d4: Add comment explaining what happens on resume
Date: Thu,  2 Mar 2017 18:31:14 +0100
Message-Id: <20170302173114.28508-5-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Because suspending to RAM may lose the register values, they are restored
on resume. This is currently done unconditionally because there is
currently no way to know (from the driver) whether they have really been
lost or are still valid. Writing MR also pings the watchdog and this may
not be what is expected so add a comment explaining why it happens.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/sama5d4_wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index d710014f3b7d..0ae947c3d7bc 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -300,6 +300,11 @@ static int sama5d4_wdt_resume(struct device *dev)
 {
 	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
 
+	/*
+	 * FIXME: writing MR also pings the watchdog which may not be desired.
+	 * This should only be done when the registers are lost on suspend but
+	 * there is no way to get this information right now.
+	 */
 	sama5d4_wdt_init(wdt);
 
 	return 0;
-- 
2.11.0

