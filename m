Return-Path: <SRS0=+zyj=RO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C63DC43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Mar 2019 23:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339A2214AE
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Mar 2019 23:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfCKXy3 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:54:29 -0400
Received: from mleia.com ([178.79.152.223]:49476 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCKXy2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 Mar 2019 19:54:28 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 2F06D457DE4;
        Mon, 11 Mar 2019 23:54:27 +0000 (GMT)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, Kuo@vger.kernel.org,
        Hsuan-Chi <hckuo2@illinois.edu>
Subject: [PATCH] watchdog: fix compile time error of pretimeout governors
Date:   Tue, 12 Mar 2019 01:54:25 +0200
Message-Id: <20190311235425.1748-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190311_235427_219356_BAADFF15 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message. 
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

CONFIG_WATCHDOG_PRETIMEOUT_GOV build symbol adds watchdog_pretimeout.o
object to watchdog.o, the latter is compiled only if CONFIG_WATCHDOG_CORE
is selected, so it rightfully makes sense to add it as a dependency.

The change fixes the next compilation errors, if CONFIG_WATCHDOG_CORE=n
and CONFIG_WATCHDOG_PRETIMEOUT_GOV=y are selected:

  drivers/watchdog/pretimeout_noop.o: In function `watchdog_gov_noop_register':
  drivers/watchdog/pretimeout_noop.c:35: undefined reference to `watchdog_register_governor'
  drivers/watchdog/pretimeout_noop.o: In function `watchdog_gov_noop_unregister':
  drivers/watchdog/pretimeout_noop.c:40: undefined reference to `watchdog_unregister_governor'

  drivers/watchdog/pretimeout_panic.o: In function `watchdog_gov_panic_register':
  drivers/watchdog/pretimeout_panic.c:35: undefined reference to `watchdog_register_governor'
  drivers/watchdog/pretimeout_panic.o: In function `watchdog_gov_panic_unregister':
  drivers/watchdog/pretimeout_panic.c:40: undefined reference to `watchdog_unregister_governor'

Reported-by: Kuo, Hsuan-Chi <hckuo2@illinois.edu>
Fixes: ff84136cb6a4 ("watchdog: add watchdog pretimeout governor framework")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 242eea859637..fa325b49672e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2028,6 +2028,7 @@ comment "Watchdog Pretimeout Governors"
 
 config WATCHDOG_PRETIMEOUT_GOV
 	bool "Enable watchdog pretimeout governors"
+	depends on WATCHDOG_CORE
 	help
 	  The option allows to select watchdog pretimeout governors.
 
-- 
2.20.1

