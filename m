Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF967C433DB
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Mar 2021 01:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F21E619AD
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Mar 2021 01:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCWBvd (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 22 Mar 2021 21:51:33 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:57876 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCWBvJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 Mar 2021 21:51:09 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 21:51:08 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id AD1989802CA;
        Tue, 23 Mar 2021 09:43:31 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drivers: watchdog: Remove duplicate include of kernel.h
Date:   Tue, 23 Mar 2021 09:43:20 +0800
Message-Id: <20210323014320.136473-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk4eSh1NTB5PSUNKVkpNSk1PTUhDSkpCTElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6KQw*UT8TODoePxcLEgww
        Ig0wC05VSlVKTUpNT01IQ0pJSUhMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTkpNNwY+
X-HM-Tid: 0a785cc05518d992kuwsad1989802ca
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

linux/kernel.h has been included at line 17, so remove the 
duplicate one at line 22.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/watchdog/dw_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 32d0e1781e63..b1642e2d9175 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interrupt.h>
-- 
2.25.1

