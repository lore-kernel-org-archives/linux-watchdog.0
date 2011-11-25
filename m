Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:51131 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626Ab1KYXzH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Nov 2011 18:55:07 -0500
Received: from mail625.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id A0D831008F5D
	for <linux-watchdog@vger.kernel.org>; Sat, 26 Nov 2011 00:44:32 +0100 (CET)
Date: Sat, 26 Nov 2011 00:38:01 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Dimitry Andric <dimitry.andric@tomtom.com>,
	Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH] watchdog: fix nowayout setting in s3c2410_wdt
Message-ID: <4ed026d9.TvJLr8ihQ2VtvqPD%marc.vertes@sigfox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Set nowayout flag in probe function, otherwise option is useless.

Signed-off-by: Marc Vertes <marc.vertes@sigfox.com>
---

 s3c2410_wdt.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-3.2-rc3/drivers/watchdog/s3c2410_wdt.c.orig	2011-11-24 05:20:28.000000000 +0100
+++ linux-3.2-rc3/drivers/watchdog/s3c2410_wdt.c	2011-11-26 00:08:58.985896169 +0100
@@ -395,6 +395,9 @@ static int __devinit s3c2410wdt_probe(st
 		s3c2410wdt_stop(&s3c2410_wdd);
 	}
 
+	if (nowayout)
+		set_bit(WDOG_NO_WAY_OUT, &s3c2410_wdd.status);
+
 	/* print out a statement of readiness */
 
 	wtcon = readl(wdt_base + S3C2410_WTCON);
