Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Robin Gong
	<b38343@freescale.com>, Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 2/2] fs: compat_ioctl: add pretimeout functions for watchdogs
Date: Sat, 25 Jun 2016 03:27:52 +0300
Message-ID: <1466814472-18271-3-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1466814472-18271-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1466814472-18271-1-git-send-email-vladimir_zapolskiy@mentor.com>
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
