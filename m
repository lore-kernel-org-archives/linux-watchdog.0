Return-Path: <garsilva@embeddedor.com>
Return-path: <garsilva@embeddedor.com>
Date: Fri, 7 Jul 2017 19:28:57 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: stm32_iwdg: constify watchdog_ops structure
Message-ID: <20170708002857.GA12556@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

Check for watchdog_ops structures that are only stored in the ops field of
a watchdog_device structure. This field is declared const, so watchdog_ops
structures that have this property can be declared as const also.

This issue was detected using Coccinelle and the following semantic patch:

@r
disable optional_qualifier@
identifier i;
position p;
@@
static struct watchdog_ops i@p = { ... };

@ok@
identifier r.i;
struct watchdog_device e;
position p;
@@
e.ops = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct watchdog_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct watchdog_ops i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/watchdog/stm32_iwdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 6c501b7..be64a86 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -140,7 +140,7 @@ static const struct watchdog_info stm32_iwdg_info = {
 	.identity	= "STM32 Independent Watchdog",
 };
 
-static struct watchdog_ops stm32_iwdg_ops = {
+static const struct watchdog_ops stm32_iwdg_ops = {
 	.owner		= THIS_MODULE,
 	.start		= stm32_iwdg_start,
 	.ping		= stm32_iwdg_ping,
-- 
2.5.0
