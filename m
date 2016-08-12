Return-path: <shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1a86f6d6-fc92-81ec-eb07-669c2bda8b38@roeck-us.net>
References: <1470982664-13228-1-git-send-email-shubhrajyoti.datta@xilinx.com> <1a86f6d6-fc92-81ec-eb07-669c2bda8b38@roeck-us.net>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 12 Aug 2016 12:12:21 +0530
Message-ID: <CAKfKVtHubRMwdYUfFx1YaiwKjYR_uUBBgouCTaTahmK9DGq6gQ@mail.gmail.com>
Subject: Re: [PATCHv4] watchdog: xilinx: Add clock support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>, wim@iguana.be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

[...]
>
>
> The clock is optional. Why print anything ?
>
> I am not a friend of logging noise, and I think this is just noise.
> Would you want such a message printed for each optional property ?
>
> Guenter
>
sure patch below


From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] watchdog: xilinx: Add clock support

Add support for the clock. Currently we enable
at probe and relinquish at remove.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: S=C3=83=C2=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
fix spaces and error path.
v3
do not fail existing dts

v4:
fix the error prints as the clock is optional

 .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
 drivers/watchdog/of_xilinx_wdt.c                   | 25 ++++++++++++++++++=
++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
index 6d63782..c6ae9c9 100644
--- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
@@ -7,6 +7,8 @@ Required properties:
 - reg : Physical base address and size

 Optional properties:
+- clocks : Input clock specifier. Refer to common clock
+  bindings.
 - clock-frequency : Frequency of clock in Hz
 - xlnx,wdt-enable-once : 0 - Watchdog can be restarted
   1 - Watchdog can be enabled just once
@@ -17,6 +19,7 @@ Example:
 axi-timebase-wdt@40100000 {
  clock-frequency =3D <50000000>;
  compatible =3D "xlnx,xps-timebase-wdt-1.00.a";
+ clocks =3D <&clkc 15>;
  reg =3D <0x40100000 0x10000>;
  xlnx,wdt-enable-once =3D <0x0>;
  xlnx,wdt-interval =3D <0x1b>;
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_=
wdt.c
index b2e1b4c..fae7fe9 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -10,6 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */

+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -45,6 +46,7 @@ struct xwdt_device {
  u32 wdt_interval;
  spinlock_t spinlock;
  struct watchdog_device xilinx_wdt_wdd;
+ struct clk *clk;
 };

 static int xilinx_wdt_start(struct watchdog_device *wdd)
@@ -195,16 +197,30 @@ static int xwdt_probe(struct platform_device *pdev)
  spin_lock_init(&xdev->spinlock);
  watchdog_set_drvdata(xilinx_wdt_wdd, xdev);

+ xdev->clk =3D devm_clk_get(&pdev->dev, NULL);
+ if (IS_ERR(xdev->clk)) {
+ if (PTR_ERR(xdev->clk) =3D=3D -ENOENT)
+ xdev->clk =3D NULL;
+ else
+ return PTR_ERR(xdev->clk);
+ }
+
+ rc =3D clk_prepare_enable(xdev->clk);
+ if (rc) {
+ dev_err(&pdev->dev, "unable to enable clock\n");
+ return rc;
+ }
+
  rc =3D xwdt_selftest(xdev);
  if (rc =3D=3D XWT_TIMER_FAILED) {
  dev_err(&pdev->dev, "SelfTest routine error\n");
- return rc;
+ goto err_clk_disable;
  }

  rc =3D watchdog_register_device(xilinx_wdt_wdd);
  if (rc) {
  dev_err(&pdev->dev, "Cannot register watchdog (err=3D%d)\n", rc);
- return rc;
+ goto err_clk_disable;
  }

  dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
@@ -213,6 +229,10 @@ static int xwdt_probe(struct platform_device *pdev)
  platform_set_drvdata(pdev, xdev);

  return 0;
+err_clk_disable:
+ clk_disable_unprepare(xdev->clk);
+
+ return rc;
 }

 static int xwdt_remove(struct platform_device *pdev)
@@ -220,6 +240,7 @@ static int xwdt_remove(struct platform_device *pdev)
  struct xwdt_device *xdev =3D platform_get_drvdata(pdev);

  watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
+ clk_disable_unprepare(xdev->clk);

  return 0;
 }
--=20
2.1.1
