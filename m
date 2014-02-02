Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49915 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751566AbaBCIaM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Feb 2014 03:30:12 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/3] ARM: sunxi: Add the new watchog compatibles to the reboot code
Date: Sun,  2 Feb 2014 14:55:24 +0100
Message-Id: <1391349325-11132-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that the watchdog driver has new compatibles, we need to support them in
the machine reboot code too.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index aeea6ce..c310df6 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -95,7 +95,9 @@ static void sun6i_restart(enum reboot_mode mode, const char *cmd)
 
 static struct of_device_id sunxi_restart_ids[] = {
 	{ .compatible = "allwinner,sun4i-wdt" },
+	{ .compatible = "allwinner,sun4i-a10-wdt" },
 	{ .compatible = "allwinner,sun6i-wdt" },
+	{ .compatible = "allwinner,sun6i-a31-wdt" },
 	{ /*sentinel*/ }
 };
 
-- 
1.8.4.2

