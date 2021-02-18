Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF1AC433E0
	for <linux-watchdog@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C593C64E33
	for <linux-watchdog@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhBRSfY (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:35:24 -0500
Received: from smtp.asem.it ([151.1.184.197]:49550 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233703AbhBRQmW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 18 Feb 2021 11:42:22 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000816795.MSG 
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Feb 2021 17:32:08 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 18
 Feb 2021 17:32:06 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 18 Feb 2021 17:32:06 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] watchdog: wdat: add param. to start wdog on module insertion
Date:   Thu, 18 Feb 2021 17:32:00 +0100
Message-ID: <20210218163200.1154812-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F17.602E9687.0048,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add the parameter "start_enable" to start the watchdog
directly on module insertion.

In an embedded system, for some applications, the watchdog
must be activated as soon as possible.

In some embedded x86 boards the watchdog can be activated
directly by the BIOS (with an appropriate setting of the
BIOS setup). In other cases, when this BIOS feature is not
present, the possibility to start the watchdog immediately
after the module loading can be very useful.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/watchdog/wdat_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index cec7917790e5..b990d0197d2e 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -61,6 +61,12 @@ module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
 		 __MODULE_STRING(WDAT_DEFAULT_TIMEOUT) ")");
 
+#define START_DEFAULT	0
+static int start_enabled = START_DEFAULT;
+module_param(start_enabled, int, 0);
+MODULE_PARM_DESC(start_enabled, "Watchdog is started on module insertion "
+		 "(default=" __MODULE_STRING(START_DEFAULT) ")");
+
 static int wdat_wdt_read(struct wdat_wdt *wdat,
 	 const struct wdat_instruction *instr, u32 *value)
 {
@@ -437,6 +443,8 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	}
 
 	wdat_wdt_boot_status(wdat);
+	if (start_enabled)
+		wdat_wdt_start(&wdat->wdd);
 	wdat_wdt_set_running(wdat);
 
 	ret = wdat_wdt_enable_reboot(wdat);
-- 
2.25.1

