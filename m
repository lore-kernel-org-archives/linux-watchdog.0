Return-Path: <arvind.yadav.cs@gmail.com>
Return-path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: zwanem@gmail.com,
	wim@iguana.be,
	linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: sc1200: constify pnp_device_id
Date: Wed, 16 Aug 2017 10:27:03 +0530
Message-Id: <aee38052d11c39f1f6957bfe9757665a0bd9976d.1502859040.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <60c34272432b3411cd5d55728c62481e133f32a6.1502859040.git.arvind.yadav.cs@gmail.com>
References: <60c34272432b3411cd5d55728c62481e133f32a6.1502859040.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

pnp_device_id are not supposed to change at runtime. All functions
working with pnp_device_id provided by <linux/pnp.h> work with
const pnp_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/sc1200wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index b34d3d5..8e4e2fc 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -342,7 +342,7 @@ static int __init sc1200wdt_probe(void)
 
 #if defined CONFIG_PNP
 
-static struct pnp_device_id scl200wdt_pnp_devices[] = {
+static const struct pnp_device_id scl200wdt_pnp_devices[] = {
 	/* National Semiconductor PC87307/PC97307 watchdog component */
 	{.id = "NSC0800", .driver_data = 0},
 	{.id = ""},
-- 
2.7.4
