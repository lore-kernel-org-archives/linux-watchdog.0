Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60486 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758359Ab3GOXdT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:33:19 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 01/10] clocksource: orion: Add thread-safe API header
Date: Mon, 15 Jul 2013 20:32:34 -0300
Message-Id: <1373931163-12670-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a header declaration to allow drivers (such as watchdog)
to access this exported API.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 include/linux/time-orion.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 include/linux/time-orion.h

diff --git a/include/linux/time-orion.h b/include/linux/time-orion.h
new file mode 100644
index 0000000..c7e6458
--- /dev/null
+++ b/include/linux/time-orion.h
@@ -0,0 +1,7 @@
+
+#ifndef __TIME_ORION_H
+#define __TIME_ORION_H
+
+void orion_timer_ctrl_clrset(u32 clr, u32 set);
+
+#endif
-- 
1.8.1.5

