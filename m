Return-path: <sudipm.mukherjee@gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] watchdog: ath79_wdt: fix build failure
Date: Wed,  5 Oct 2016 10:58:38 +0530
Message-Id: <1475645318-15254-1-git-send-email-sudipm.mukherjee@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The build of mips ath79_defconfig was failing with the error:
drivers/watchdog/ath79_wdt.c:164:5:
	error: implicit declaration of function 'get_user'
drivers/watchdog/ath79_wdt.c:196:3:
	error: implicit declaration of function 'copy_to_user'
drivers/watchdog/ath79_wdt.c:201:3:
	error: implicit declaration of function 'put_user'

Quoting Al Viro - "another victim of indirect include chains"

Fixes: 58a8f3b69e07 ("mips: separate extable.h, switch module.h to it")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/164834126

 drivers/watchdog/ath79_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 835d310..e2209bf 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -35,6 +35,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/uaccess.h>
 
 #define DRIVER_NAME	"ath79-wdt"
 
-- 
1.9.1
