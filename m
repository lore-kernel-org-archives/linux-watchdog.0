Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56137 "EHLO
	alan.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932542Ab3LDPbu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Dec 2013 10:31:50 -0500
Subject: [PATCH] sc1200_wdt: Fix oops
To: wim@iguana.be, linux-watchdog@vger.kernel.org
From: Alan <gnomes@lxorguk.ukuu.org.uk>
Date: Wed, 04 Dec 2013 15:31:52 +0000
Message-ID: <20131204153135.32175.35874.stgit@alan.etchedpixels.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If loaded with isapnp = 0 the driver explodes. This is catching
people out now and then. What should happen in the working case is
a complete mystery and the code appears terminally confused, but we
can at least make the error path work properly.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Partially-Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=53991
---
 drivers/watchdog/sc1200wdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 3b9fff9..131193a 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -409,8 +409,9 @@ static int __init sc1200wdt_init(void)
 #if defined CONFIG_PNP
 	/* now that the user has specified an IO port and we haven't detected
 	 * any devices, disable pnp support */
+	if (isapnp)
+		pnp_unregister_driver(&scl200wdt_pnp_driver);
 	isapnp = 0;
-	pnp_unregister_driver(&scl200wdt_pnp_driver);
 #endif
 
 	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {

