Return-Path: <arvind.yadav.cs@gmail.com>
Return-path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tomas.winkler@intel.com,
	wim@iguana.be,
	linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: mei_wdt: constify mei_cl_device_id
Date: Sat, 26 Aug 2017 11:41:06 +0530
Message-Id: <c46499b73fe258e5fb9f79dcfdb8e825ff910e2a.1503727746.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

mei_cl_device_id are not supposed to change at runtime. All functions
working with mei_cl_device_id provided by <linux/mei_cl_bus.h> work
with const mei_cl_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/mei_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index b29c6fd..ea60b29 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -670,7 +670,7 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 #define MEI_UUID_WD UUID_LE(0x05B79A6F, 0x4628, 0x4D7F, \
 			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
 
-static struct mei_cl_device_id mei_wdt_tbl[] = {
+static const struct mei_cl_device_id mei_wdt_tbl[] = {
 	{ .uuid = MEI_UUID_WD, .version = MEI_CL_VERSION_ANY },
 	/* required last entry */
 	{ }
-- 
2.7.4
