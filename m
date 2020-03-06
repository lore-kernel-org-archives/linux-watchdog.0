Return-Path: <SRS0=mVcR=4X=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869BC10F26
	for <linux-watchdog@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC85220848
	for <linux-watchdog@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFNiG (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:38:06 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:37308 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCFNiD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Mar 2020 08:38:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D5C5B803087C;
        Fri,  6 Mar 2020 13:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yO8_Hpnu8yKT; Fri,  6 Mar 2020 16:28:23 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] watchdog: watchdog_dev: Use generic msec-per-sec macro
Date:   Fri, 6 Mar 2020 16:27:43 +0300
In-Reply-To: <20200306132747.14701-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306132747.14701-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306132823.D5C5B803087C@mail.baikalelectronics.ru>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

For better readability replace the numeric literals with globally
available xSEC_PER_SEC macro.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/watchdog/watchdog_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 8b5c742f24e8..a1a3bbe21653 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -99,7 +99,7 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
 	unsigned int hm = wdd->max_hw_heartbeat_ms;
-	unsigned int t = wdd->timeout * 1000;
+	unsigned int t = wdd->timeout * MSEC_PER_SEC;
 
 	/*
 	 * A worker to generate heartbeat requests is needed if all of the
@@ -121,7 +121,7 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 static ktime_t watchdog_next_keepalive(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
-	unsigned int timeout_ms = wdd->timeout * 1000;
+	unsigned int timeout_ms = wdd->timeout * MSEC_PER_SEC;
 	ktime_t keepalive_interval;
 	ktime_t last_heartbeat, latest_heartbeat;
 	ktime_t virt_timeout;
-- 
2.25.1

