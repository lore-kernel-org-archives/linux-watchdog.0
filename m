From: Gabor Juhos <juhosg@openwrt.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 16/16] watchdog: ath79_wdt: flush register writes
Date: Fri, 23 Dec 2011 19:25:42 +0100
Message-Id: <1324664742-3648-17-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog register writes required to have a flush
in order to commit the values to the register. Without
the flush, the driver not function correctly on AR934X
SoCs.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/ath79_wdt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 725c84b..9db8083 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -68,17 +68,23 @@ static int max_timeout;
 static inline void ath79_wdt_keepalive(void)
 {
 	ath79_reset_wr(AR71XX_RESET_REG_WDOG, wdt_freq * timeout);
+	/* flush write */
+	ath79_reset_rr(AR71XX_RESET_REG_WDOG);
 }
 
 static inline void ath79_wdt_enable(void)
 {
 	ath79_wdt_keepalive();
 	ath79_reset_wr(AR71XX_RESET_REG_WDOG_CTRL, WDOG_CTRL_ACTION_FCR);
+	/* flush write */
+	ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
 }
 
 static inline void ath79_wdt_disable(void)
 {
 	ath79_reset_wr(AR71XX_RESET_REG_WDOG_CTRL, WDOG_CTRL_ACTION_NONE);
+	/* flush write */
+	ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
 }
 
 static int ath79_wdt_set_timeout(int val)
-- 
1.7.2.1
