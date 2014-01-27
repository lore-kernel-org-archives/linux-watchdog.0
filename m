Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:39953 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbaA0Gio (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 01:38:44 -0500
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] watchdog: update MAINTAINERS git tree
Date: Mon, 27 Jan 2014 08:38:33 +0200
Message-Id: <b5b4f6a855a19db21fe8143c9dbdac465725c7bf.1390804713.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The -next tree shows current watchdog development.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
BTW, both git trees web interface shows "Internal Server Error" message.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2507f38b208f..2386dcd9d374 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9470,7 +9470,7 @@ WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@iguana.be>
 L:	linux-watchdog@vger.kernel.org
 W:	http://www.linux-watchdog.org/
-T:	git git://www.linux-watchdog.org/linux-watchdog.git
+T:	git git://www.linux-watchdog.org/linux-watchdog-next.git
 S:	Maintained
 F:	Documentation/watchdog/
 F:	drivers/watchdog/
-- 
1.8.5.2

