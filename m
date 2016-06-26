Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Robin Gong
	<b38343@freescale.com>, Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 2/2] fs: compat_ioctl: add pretimeout functions for watchdogs
Date: Sun, 26 Jun 2016 04:01:05 +0300
Message-ID: <1466902865-14354-3-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Watchdog core now handles those ioctls centrally, so we want 64 bit
support, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* none

 fs/compat_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index bd01b92..914bfc5 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1208,6 +1208,8 @@ COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
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
