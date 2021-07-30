Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A2AC4338F
	for <linux-watchdog@archiver.kernel.org>; Fri, 30 Jul 2021 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7212860F01
	for <linux-watchdog@archiver.kernel.org>; Fri, 30 Jul 2021 19:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhG3TjY (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:39:24 -0400
Received: from david.siemens.de ([192.35.17.14]:48202 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhG3TjY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Jul 2021 15:39:24 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 16UJd19b024569
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 21:39:02 +0200
Received: from [167.87.33.191] ([167.87.33.191])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16UJd0Vc012541;
        Fri, 30 Jul 2021 21:39:01 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] watchdog: Respect handle_boot_enabled when setting last
 last_hw_keepalive
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Message-ID: <fe8cf65f-f949-9326-8f32-fda7134c8da6@siemens.com>
Date:   Fri, 30 Jul 2021 21:39:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We must not pet a running watchdog when handle_boot_enabled is off
because this requests to only start doing that via userspace, not during
probing.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/watchdog/watchdog_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3bab32485273..3c93d00bb284 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1172,7 +1172,10 @@ int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
 
 	wd_data->last_hw_keepalive = ktime_sub(now, ms_to_ktime(last_ping_ms));
 
-	return __watchdog_ping(wdd);
+	if (handle_boot_enabled)
+		return __watchdog_ping(wdd);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(watchdog_set_last_hw_keepalive);
 
-- 
2.31.1
