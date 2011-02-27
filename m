Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 02/17]drivers:watchdog:sbc_epx_c3.c Remove one to many n's in a word.
Date: Sat, 26 Feb 2011 20:33:55 -0800
Message-Id: <1298781250-2718-3-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
References: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The Patch below removes one to many "n's" in a word.. 

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org 
---
 drivers/watchdog/sbc_epx_c3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index 28f1214..3066a51 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -220,7 +220,7 @@ module_exit(watchdog_exit);
 MODULE_AUTHOR("Calin A. Culianu <calin@ajvar.org>");
 MODULE_DESCRIPTION("Hardware Watchdog Device for Winsystems EPX-C3 SBC.  "
 	"Note that there is no way to probe for this device -- "
-	"so only use it if you are *sure* you are runnning on this specific "
+	"so only use it if you are *sure* you are running on this specific "
 	"SBC system from Winsystems!  It writes to IO ports 0x1ee and 0x1ef!");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.4.1
