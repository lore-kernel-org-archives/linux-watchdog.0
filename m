Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45878 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab3HWJib (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 23 Aug 2013 05:38:31 -0400
Date: Fri, 23 Aug 2013 12:38:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] watchdog: ts72xx_wdt: cleanup return codes in ioctl
Message-ID: <20130823093832.GL31293@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There seems to be some confusion here which functions return positive
numbers and which return negative error codes.

copy_to_user() returns the number of bytes remaining to be copied but we
want to return -EFAULT.

The rest is just clean up.  get_user() actually returns zero on success
and -EFAULT on error so we can preserve the error code.  The
timeout_to_regval() function returns -EINVAL on failure, but we can
propogate that back instead of hardcoding -EINVAL ourselves.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 4da59b4..9125b0f 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -305,7 +305,8 @@ static long ts72xx_wdt_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		error = copy_to_user(argp, &winfo, sizeof(winfo));
+		if (copy_to_user(argp, &winfo, sizeof(winfo)))
+			error = -EFAULT;
 		break;
 
 	case WDIOC_GETSTATUS:
@@ -319,10 +320,9 @@ static long ts72xx_wdt_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_SETOPTIONS: {
 		int options;
 
-		if (get_user(options, p)) {
-			error = -EFAULT;
+		error = get_user(options, p);
+		if (error)
 			break;
-		}
 
 		error = -EINVAL;
 
@@ -340,30 +340,26 @@ static long ts72xx_wdt_ioctl(struct file *file, unsigned int cmd,
 
 	case WDIOC_SETTIMEOUT: {
 		int new_timeout;
+		int regval;
 
-		if (get_user(new_timeout, p)) {
-			error = -EFAULT;
-		} else {
-			int regval;
-
-			regval = timeout_to_regval(new_timeout);
-			if (regval < 0) {
-				error = -EINVAL;
-			} else {
-				ts72xx_wdt_stop(wdt);
-				wdt->regval = regval;
-				ts72xx_wdt_start(wdt);
-			}
-		}
+		error = get_user(new_timeout, p);
 		if (error)
 			break;
 
+		regval = timeout_to_regval(new_timeout);
+		if (regval < 0) {
+			error = regval;
+			break;
+		}
+		ts72xx_wdt_stop(wdt);
+		wdt->regval = regval;
+		ts72xx_wdt_start(wdt);
+
 		/*FALLTHROUGH*/
 	}
 
 	case WDIOC_GETTIMEOUT:
-		if (put_user(regval_to_timeout(wdt->regval), p))
-			error = -EFAULT;
+		error = put_user(regval_to_timeout(wdt->regval), p);
 		break;
 
 	default:
