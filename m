Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:51219 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751578Ab1GYQTa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jul 2011 12:19:30 -0400
Date: Mon, 25 Jul 2011 09:19:27 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, jorge@dti2.net,
	Wim Van Sebroeck <wim@iguana.be>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, akpm <akpm@linux-foundation.org>
Subject: [PATCH -next] watchdog: fix it8712f_wdt build errors
Message-Id: <20110725091927.e154fd28.rdunlap@xenotime.net>
In-Reply-To: <20110725162542.39ea8d8cbd51604523635c1a@canb.auug.org.au>
References: <20110725162542.39ea8d8cbd51604523635c1a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix build errors by adding missing header file:

drivers/watchdog/it8712f_wdt.c:127: error: implicit declaration of function 'request_muxed_region'
drivers/watchdog/it8712f_wdt.c:141: error: implicit declaration of function 'release_region'
drivers/watchdog/it8712f_wdt.c:412: error: implicit declaration of function 'request_region'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/watchdog/it8712f_wdt.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20110725.orig/drivers/watchdog/it8712f_wdt.c
+++ linux-next-20110725/drivers/watchdog/it8712f_wdt.c
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 #define NAME "it8712f_wdt"
 
