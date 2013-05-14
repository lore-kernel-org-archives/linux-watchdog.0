Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:43154 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab3ENGyZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 May 2013 02:54:25 -0400
Received: by mail-da0-f45.google.com with SMTP id w3so123564dad.18
        for <linux-watchdog@vger.kernel.org>; Mon, 13 May 2013 23:54:25 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org
Subject: [PATCH 1/1] watchdog: dw_wdt: Staticize local symbol
Date: Tue, 14 May 2013 12:11:03 +0530
Message-Id: <1368513663-23880-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

'dw_wdt_write' is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/dw_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2037669..fb8e91d 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -154,8 +154,8 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 	return nonseekable_open(inode, filp);
 }
 
-ssize_t dw_wdt_write(struct file *filp, const char __user *buf, size_t len,
-		     loff_t *offset)
+static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
+			    size_t len, loff_t *offset)
 {
 	if (!len)
 		return 0;
-- 
1.7.9.5

