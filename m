Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56709 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab2KSOKx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Nov 2012 09:10:53 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1930292bkw.19
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Nov 2012 06:10:51 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH v5 1/8] dt: add helper inline for retrieving timeout-sec property
Date: Mon, 19 Nov 2012 15:10:36 +0100
Message-Id: <1353334243-16703-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The first user of this function is the watchdog framework.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/of.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index b4e50d5..d60fde9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -477,4 +477,15 @@ static inline int of_property_read_u32(const struct device_node *np,
 	return of_property_read_u32_array(np, propname, out_value, 1);
 }
 
+/**
+ * of_get_timeout_sec() - Helper to read the timeout_sec property
+ * @np:		device node from which the property value is to be read.
+ * @timeout:	adress of the output value
+ */
+static inline int of_get_timeout_sec(const struct device_node *np,
+				     u32 *timeout)
+{
+	return of_property_read_u32(np, "timeout-sec", timeout);
+}
+
 #endif /* _LINUX_OF_H */
-- 
1.8.0

