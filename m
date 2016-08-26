Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49328 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754255AbcHZQIP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Aug 2016 12:08:15 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v4 2/7] fs: compat_ioctl: add pretimeout functions for watchdogs
Date: Fri, 26 Aug 2016 19:07:56 +0300
Message-ID: <1472227681-1405-3-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Watchdog core now handles those ioctls centrally, so we want 64 bit
support, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Reviewed at http://www.spinics.net/lists/linux-watchdog/msg09484.html

Changes from v3 to v4:
* included back to the main series as it was done in v2,
* added Acked-by: Guenter tag

Changes from v2 to v3:
* none (not published)

Changes from v1 to v2:
* none

 fs/compat_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index c1e9f29c924c..f2d7402abe02 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1209,6 +1209,8 @@ COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
 COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
 COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
+COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
+COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
 /* Big R */
 COMPATIBLE_IOCTL(RNDGETENTCNT)
 COMPATIBLE_IOCTL(RNDADDTOENTCNT)
-- 
2.8.1

