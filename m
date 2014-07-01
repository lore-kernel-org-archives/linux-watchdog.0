Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39445 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaGAUhz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Jul 2014 16:37:55 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Russell King <linux@arm.linux.org.uk>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 2/3] watchdog: get rid of FOOTBRIDGE in dependencies
Date: Tue,  1 Jul 2014 22:37:05 +0200
Message-Id: <1404247026-379-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Kconfig symbol FOOTBRIDGE is only defined if ARCH_FOOTBRIDGE is
enabled and the latter unconditionally selects the former. So they are
either both selected or none and so they are equivalent. To allow
removing FOOTBRIDGE switch the dependency of 21285_WATCHDOG to
ARCH_FOOTBRIDGE. As ARCH_NETWINDER depends on ARCH_FOOTBRIDGE dropping
=46OOTBRIDGE from 977_WATCHDOG's "depends on FOOTBRIDGE && ARCH_NETWIND=
ER"
doesn't change anything.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 76dd54122f76..0dc12d6de265 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -149,7 +149,7 @@ config AT91SAM9X_WATCHDOG
=20
 config 21285_WATCHDOG
 	tristate "DC21285 watchdog"
-	depends on FOOTBRIDGE
+	depends on ARCH_FOOTBRIDGE
 	help
 	  The Intel Footbridge chip contains a built-in watchdog circuit. Say=
 Y
 	  here if you wish to use this. Alternatively say M to compile the
@@ -163,7 +163,7 @@ config 21285_WATCHDOG
=20
 config 977_WATCHDOG
 	tristate "NetWinder WB83C977 watchdog"
-	depends on FOOTBRIDGE && ARCH_NETWINDER
+	depends on ARCH_NETWINDER
 	help
 	  Say Y here to include support for the WB977 watchdog included in
 	  NetWinder machines. Alternatively say M to compile the driver as
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
