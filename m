Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:52414 "EHLO
	g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbcEYQaW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 12:30:22 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 80926632D0
	for <linux-watchdog@vger.kernel.org>; Wed, 25 May 2016 16:20:59 +0000 (UTC)
From: Brian Boylston <brian.boylston@hpe.com>
To: linux-watchdog@vger.kernel.org
Cc: Brian Boylston <brian.boylston@hpe.com>
Subject: [PATCH v2 1/2] MAINTAINERS: add entry for HPE watchdog driver
Date: Wed, 25 May 2016 11:19:54 -0500
Message-Id: <20160525161954.3354-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a maintainer for the HPE watchdog driver

Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 804bc4f..520e306 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5130,6 +5130,12 @@ T:	git git://linuxtv.org/anttip/media_tree.git
 S:	Maintained
 F:	drivers/media/dvb-frontends/hd29l2*
 
+HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
+M:	Brian Boylston <brian.boylston@hpe.com>
+S:	Supported
+F:	Documentation/watchdog/hpwdt.txt
+F:	drivers/watchdog/hpwdt.c
+
 HEWLETT-PACKARD SMART ARRAY RAID DRIVER (hpsa)
 M:	Don Brace <don.brace@microsemi.com>
 L:	iss_storagedev@hp.com
-- 
2.8.3

