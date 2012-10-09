Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46214 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab2JIMER (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Oct 2012 08:04:17 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3446960eek.19
        for <linux-watchdog@vger.kernel.org>; Tue, 09 Oct 2012 05:04:17 -0700 (PDT)
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
Subject: [PATCH v4 1/8] dt: add helper inline for retrieving timeout-sec property
Date: Tue,  9 Oct 2012 14:04:04 +0200
Message-Id: <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
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
index 72843b7..5870818 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -470,4 +470,15 @@ static inline int of_property_read_u32(const struct device_node *np,
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
1.7.11.3

