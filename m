Return-Path: <stable-owner@vger.kernel.org>
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 022/124] watchdog: dw_wdt: add stop watchdog
 operation
Date: Mon, 19 Mar 2018 15:47:21 +0000
Message-ID: <20180319154645.11350-22-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 1bfe8889380890efe4943d125124f5a7b48571b0 ]

The only way of stopping the watchdog is by resetting it.
Add the watchdog op for stopping the device and reset if
a reset line is provided.

At same time WDOG_HW_RUNNING should be remove from dw_wdt_start.
As commented by Guenter Roeck:
dw_wdt sets WDOG_HW_RUNNING in its open function. Result is
that the kref_get() in watchdog_open() won't be executed. But then
kref_put() in close will be called since the watchdog now does stop.
This causes the imbalance.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/watchdog/dw_wdt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 36be987ff9ef..c2f4ff516230 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -127,14 +127,27 @@ static int dw_wdt_start(struct watchdog_device *wdd)
=20
 	dw_wdt_set_timeout(wdd, wdd->timeout);
=20
-	set_bit(WDOG_HW_RUNNING, &wdd->status);
-
 	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
 	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
=20
 	return 0;
 }
=20
+static int dw_wdt_stop(struct watchdog_device *wdd)
+{
+	struct dw_wdt *dw_wdt =3D to_dw_wdt(wdd);
+
+	if (!dw_wdt->rst) {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		return 0;
+	}
+
+	reset_control_assert(dw_wdt->rst);
+	reset_control_deassert(dw_wdt->rst);
+
+	return 0;
+}
+
 static int dw_wdt_restart(struct watchdog_device *wdd,
 			  unsigned long action, void *data)
 {
@@ -173,6 +186,7 @@ static const struct watchdog_info dw_wdt_ident =3D {
 static const struct watchdog_ops dw_wdt_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.start		=3D dw_wdt_start,
+	.stop		=3D dw_wdt_stop,
 	.ping		=3D dw_wdt_ping,
 	.set_timeout	=3D dw_wdt_set_timeout,
 	.get_timeleft	=3D dw_wdt_get_timeleft,
--=20
2.14.1
