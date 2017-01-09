Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43809 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934437AbdAIJvJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 04:51:09 -0500
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>, Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: kernel@pengutronix.de, Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] watchdog: imx2: add compatibility for new i.MX35 type watchdog
Date: Mon,  9 Jan 2017 10:50:39 +0100
Message-Id: <20170109095039.11979-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When the watchdog driver learned about the i.MX35 type watchdog a new
compatibility string was introduced. Older dtb continue to use the
old fsl,imx21-wdt string and so stop writing the WMCR register which is
critical iff the machine powers off when WDOG becomes active and the
bootloader doesn't stop the power down counter.

It's unknown which boards are affected and I guess most of them are not.
Also note this is only an issue if a new kernel is operated with an old
dtb as the SoC dtsi files are fixed accordingly.

XXX: the XXX introduced needs to be changed to HEAD~2 when got a stable commit id.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/imx2_wdt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 509b2fedb112..f5616e2c2c58 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -454,6 +454,44 @@ static const struct of_device_id imx2_wdt_dt_ids[] = {
 	}, {
 		.compatible = "fsl,imx35-wdt",
 		.data = &imx2_wdt_type_imx35,
+	},
+	/*
+	 * The following ids are only there to make commit XXX compatible with
+	 * older device trees. The result is that iff the machine makes use of
+	 * the WDG signal (most don't, only WDG_RST is used) and the bootloader
+	 * doesn't stop the power down counter it powers off the board after 16
+	 * seconds.
+	 */
+	{
+		.compatible = "fsl,imx25-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx50-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx51-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx53-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx6q-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx6sl-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx6sx-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx6ul-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,imx7d-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		.compatible = "fsl,vf610-wdt",
+		.data = &imx2_wdt_type_imx35,
 	}, {
 		/* sentinel */
 	}
-- 
2.11.0

