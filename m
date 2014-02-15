Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:58104 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBOJXp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 04:23:45 -0500
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [94.100.177.95])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 313ADF8AE188
	for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 13:23:44 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: wdt285: Fix variable type
Date: Sat, 15 Feb 2014 13:23:25 +0400
Message-Id: <1392456205-30121-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Variable "new_margin" is checked in the function watchdog_ioctl()
to be positive, so change its type to "int".

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/wdt285.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 7355ddd0..ebbb183 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -139,9 +139,8 @@ static const struct watchdog_info ident = {
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	unsigned int new_margin;
 	int __user *int_arg = (int __user *)arg;
-	int ret = -ENOTTY;
+	int new_margin, ret = -ENOTTY;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-- 
1.8.3.2

