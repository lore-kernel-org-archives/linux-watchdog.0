Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35078 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbcFANF4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jun 2016 09:05:56 -0400
Date: Wed, 1 Jun 2016 09:05:48 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: pcwd: Utilize the module_isa_driver macro
Message-ID: <20160601130548.GA13035@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver does not do anything special in module init/exit. This patch
eliminates the module init/exit boilerplate code by utilizing the
module_isa_driver macro.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/watchdog/pcwd.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index e936f15..3ad5206 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -992,19 +992,7 @@ static struct isa_driver pcwd_isa_driver = {
 	},
 };
 
-static int __init pcwd_init_module(void)
-{
-	return isa_register_driver(&pcwd_isa_driver, PCWD_ISA_NR_CARDS);
-}
-
-static void __exit pcwd_cleanup_module(void)
-{
-	isa_unregister_driver(&pcwd_isa_driver);
-	pr_info("Watchdog Module Unloaded\n");
-}
-
-module_init(pcwd_init_module);
-module_exit(pcwd_cleanup_module);
+module_isa_driver(pcwd_isa_driver, PCWD_ISA_NR_CARDS);
 
 MODULE_AUTHOR("Ken Hollis <kenji@bitgate.com>, "
 		"Wim Van Sebroeck <wim@iguana.be>");
-- 
2.7.3

