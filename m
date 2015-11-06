Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37611 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032269AbbKFJ4m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 04:56:42 -0500
Date: Fri, 6 Nov 2015 12:56:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] watchdog: w83977f_wdt: underflow in wdt_set_timeout()
Message-ID: <20151106095631.GA18557@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

"t" is controlled by the user.  If "t" is a very large integer then it
could lead to a negative "tmrval".  We cap the upper bound of "tmrval"
but, in the current code, we allow negatives.  This is a bug and it
causes a static checker warning.  Let's make "tmrval" unsigned to avoid
this problem.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 91bf55a..20e2bba 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -224,7 +224,7 @@ static int wdt_keepalive(void)
 
 static int wdt_set_timeout(int t)
 {
-	int tmrval;
+	unsigned int tmrval;
 
 	/*
 	 * Convert seconds to watchdog counter time units, rounding up.
