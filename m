Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38609 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeJAEvg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 1 Oct 2018 00:51:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so7769640pfh.5
        for <linux-watchdog@vger.kernel.org>; Sun, 30 Sep 2018 15:16:54 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH] MAINTAINERS: Fix file pattern for MEN Z069 watchdog driver
Date: Sun, 30 Sep 2018 15:16:50 -0700
Message-Id: <1538345810-9623-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The file name is menz69_wdt.c, not menz069_wdt.c.

Reported-by: Joe Perches <joe@perches.com>
Cc: Joe Perches <joe@perches.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..4c1a6e88bc5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9478,7 +9478,7 @@ MEN Z069 WATCHDOG DRIVER
 M:	Johannes Thumshirn <jth@kernel.org>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
-F:	drivers/watchdog/menz069_wdt.c
+F:	drivers/watchdog/menz69_wdt.c
 
 MESON AO CEC DRIVER FOR AMLOGIC SOCS
 M:	Neil Armstrong <narmstrong@baylibre.com>
-- 
2.7.4
