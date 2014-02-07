Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50022 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751897AbaBGVaX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Feb 2014 16:30:23 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 2/3] ARM: sunxi: Add the new watchog compatibles to the reboot code
Date: Fri,  7 Feb 2014 22:29:25 +0100
Message-Id: <1391808566-31008-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that the watchdog driver has new compatibles, we need to support them in
the machine reboot code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index aeea6ce..460b5a4 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -94,8 +94,8 @@ static void sun6i_restart(enum reboot_mode mode, const char *cmd)
 }
 
 static struct of_device_id sunxi_restart_ids[] = {
-	{ .compatible = "allwinner,sun4i-wdt" },
-	{ .compatible = "allwinner,sun6i-wdt" },
+	{ .compatible = "allwinner,sun4i-a10-wdt" },
+	{ .compatible = "allwinner,sun6i-a31-wdt" },
 	{ /*sentinel*/ }
 };
 
-- 
1.8.4.2

