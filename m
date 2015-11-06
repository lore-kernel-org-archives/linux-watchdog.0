Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36171 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030462AbbKFVzS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 16:55:18 -0500
Received: by wmec201 with SMTP id c201so6714046wme.3
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Nov 2015 13:55:17 -0800 (PST)
From: Carlo Caione <carlo@caione.org>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH 2/4] watchdog: meson: Add meson8b SoC specific data
Date: Fri,  6 Nov 2015 22:55:04 +0100
Message-Id: <1446846906-31520-3-git-send-email-carlo@caione.org>
In-Reply-To: <1446846906-31520-1-git-send-email-carlo@caione.org>
References: <1446846906-31520-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

Add SoC specific data in the watchdog driver for the meson8b SoC.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/watchdog/meson_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 89944ed..75c84f5 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -52,6 +52,12 @@ static struct meson_wdt_data meson6_wdt_data = {
 	.count_unit		= 100000, /* 10 us */
 };
 
+static struct meson_wdt_data meson8b_wdt_data = {
+	.shift_enable		= 19,
+	.terminal_count_mask	= 0xffff,
+	.count_unit		= 7812, /* 128 us */
+};
+
 struct meson_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
@@ -152,6 +158,7 @@ static const struct watchdog_ops meson_wdt_ops = {
 
 static const struct of_device_id meson_wdt_dt_ids[] = {
 	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
+	{ .compatible = "amlogic,meson8b-wdt", .data = &meson8b_wdt_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
-- 
1.9.1

