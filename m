Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46903 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaB0Fq3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 00:46:29 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N00FSB41F3H50@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 27 Feb 2014 14:46:27 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Akinobu Mita' <akinobu.mita@gmail.com>
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
In-reply-to: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
Subject: [PATCH 4/6] watchdog: ibmasr: fix incorrect placement of __initdata
 marker
Date: Thu, 27 Feb 2014 14:46:27 +0900
Message-id: <004801cf337f$41d5af60$c5810e20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The __initdata marker can be virtually anywhere on the line,
EXCEPT right after "struct". The preferred location is before
the "=" sign if there is one, or before the trailing ";"
otherwise. It also fixes the following chechpatch warning.

  WARNING: __initdata should be placed after ibmasr_id_table[]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/ibmasr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index db0a344..366b047 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -360,7 +360,7 @@ struct ibmasr_id {
 	int type;
 };
 
-static struct ibmasr_id __initdata ibmasr_id_table[] = {
+static struct ibmasr_id ibmasr_id_table[] __initdata = {
 	{ "IBM Automatic Server Restart - eserver xSeries 220", ASMTYPE_TOPAZ },
 	{ "IBM Automatic Server Restart - Machine Type 8673", ASMTYPE_PEARL },
 	{ "IBM Automatic Server Restart - Machine Type 8480", ASMTYPE_JASPER },
-- 
1.7.10.4


