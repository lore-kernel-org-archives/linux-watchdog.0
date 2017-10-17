Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de,
	Stefan Christ <s.christ@phytec.de>
Subject: [PATCH 2/6] mfd: da9062: make register CONFIG_I writable
Date: Tue, 17 Oct 2017 17:30:23 +0200
Message-Id: <20171017153027.24665-3-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Stefan Christ <s.christ@phytec.de>

Make the config register CONFIG_I writable to change the watchdog mode.
The datasheet does not mention exactly whether these registers should be
read-only or writeable. But writing to those registers works at runtime.
Only on reset they are reseted.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 drivers/mfd/da9062-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index fe1811523e4a7..f5c7bd9dc32d5 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -727,6 +727,10 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
 		.range_min = DA9062AA_BBAT_CONT,
 		.range_max = DA9062AA_BBAT_CONT,
 	}, {
+		/* CONFIG_I must be writable to set WATCHDOG_SD */
+		.range_min = DA9062AA_CONFIG_I,
+		.range_max = DA9062AA_CONFIG_I,
+	}, {
 		.range_min = DA9062AA_GP_ID_0,
 		.range_max = DA9062AA_GP_ID_19,
 	},
-- 
2.11.0
