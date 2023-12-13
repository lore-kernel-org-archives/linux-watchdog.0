Received: from srv.wefi.net (srv.wefi.net [80.66.63.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB932D5
	for <linux-watchdog@vger.kernel.org>; Wed, 13 Dec 2023 01:45:34 -0800 (PST)
Received: from x390.thomas-krenn.com (unknown [91.223.201.37])
	by srv.wefi.net (Postfix) with ESMTPA id C0D455A3590;
	Wed, 13 Dec 2023 10:45:33 +0100 (CET)
From: Werner Fischer <devlists@wefi.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Werner Fischer <devlists@wefi.net>
Subject: [PATCH 3/4] watchdog: it87_wdt: Add IT8659 ID
Date: Wed, 13 Dec 2023 10:45:24 +0100
Message-Id: <20231213094525.11849-3-devlists@wefi.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213094525.11849-1-devlists@wefi.net>
References: <20231213094525.11849-1-devlists@wefi.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds watchdog support for the ITE IT8659 watchdog.
IT8659 watchdog works in the same way as the other watchdogs supported
by it87_wdt.

Before this patch, IT8659 watchdog is not supported. After a modprobe,
dmesg reports:
  it87_wdt: Unknown Chip found, Chip 8659 Revision 0007

With this patch, modprobe it87_wdt recognizes the watchdog as the dmesg
output shows:
  it87_wdt: Chip IT8659 revision 7 initialized. timeout=60 sec (nowayout=0
  testmode=0)

Watchdog tests on a YANLING YL-ALP3L2C-1235U system have been successful,
the watchdog works as expected with this patch.

Signed-off-by: Werner Fischer <devlists@wefi.net>
---
 drivers/watchdog/it87_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index ca377096bdd7..f6a344c002af 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -13,9 +13,9 @@
  *		    http://www.ite.com.tw/
  *
  *	Support of the watchdog timers, which are available on
- *	IT8607, IT8613, IT8620, IT8622, IT8625, IT8628, IT8655, IT8665,
- *	IT8686, IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
- *	IT8728, IT8772, IT8783 and IT8784.
+ *	IT8607, IT8613, IT8620, IT8622, IT8625, IT8628, IT8655, IT8659,
+ *	IT8665, IT8686, IT8702, IT8712, IT8716, IT8718, IT8720, IT8721,
+ *	IT8726,	IT8728, IT8772, IT8783, IT8784 and IT8786.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -56,6 +56,7 @@
 #define IT8625_ID	0x8625
 #define IT8628_ID	0x8628
 #define IT8655_ID	0x8655
+#define IT8659_ID	0x8659
 #define IT8665_ID	0x8665
 #define IT8686_ID	0x8686
 #define IT8702_ID	0x8702
@@ -281,6 +282,7 @@ static int __init it87_wdt_init(void)
 	case IT8625_ID:
 	case IT8628_ID:
 	case IT8655_ID:
+	case IT8659_ID:
 	case IT8665_ID:
 	case IT8686_ID:
 	case IT8716_ID:
-- 
2.39.2

