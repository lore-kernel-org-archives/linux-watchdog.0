Return-Path: <f.fainelli@gmail.com>
Return-path: <f.fainelli@gmail.com>
Date: Sun, 02 Dec 2018 09:27:02 -0800
In-Reply-To: <20181202130349.30464-1-linus.walleij@linaro.org>
References: <20181202130349.30464-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] watchdog: mtx-1: Convert to use GPIO descriptor
To: Linus Walleij <linus.walleij@linaro.org>,Wim Van Sebroeck <wim@linux-watchdog.org>,Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7CD8A364-CD5E-4B3E-B122-FACC27A681E4@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

On December 2, 2018 5:03:49 AM PST, Linus Walleij <linus=2Ewalleij@linaro=
=2Eorg> wrote:
>This converts the MTX-1 driver to grab a GPIO descriptor
>associated with the device instead of using a resource with
>a global GPIO number=2E
>
>The board using this driver appears to be out-of-tree
>(OpenWRT), but the users can be easily augmented by adding a
>machine descriptor table before registering the device=2E

Unless I missed something this board should still be supported under arch/=
mips/alchemy/board-mtx1=2Ec=2E There we pass the GPIO number for the watchd=
og as an IRQ resource, but since you are switching this to GPIO descriptors=
, should not a lookup entry be added there as well?

>
>Cc: Florian Fainelli <f=2Efainelli@gmail=2Ecom>
>Signed-off-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>---
> drivers/watchdog/mtx-1_wdt=2Ec | 19 +++++++++----------
> 1 file changed, 9 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/watchdog/mtx-1_wdt=2Ec
>b/drivers/watchdog/mtx-1_wdt=2Ec
>index 1fa7d2b32494=2E=2E522a2b98ec16 100644
>--- a/drivers/watchdog/mtx-1_wdt=2Ec
>+++ b/drivers/watchdog/mtx-1_wdt=2Ec
>@@ -39,7 +39,7 @@
> #include <linux/platform_device=2Eh>
> #include <linux/io=2Eh>
> #include <linux/uaccess=2Eh>
>-#include <linux/gpio=2Eh>
>+#include <linux/gpio/consumer=2Eh>
>=20
> #include <asm/mach-au1x00/au1000=2Eh>
>=20
>@@ -55,7 +55,7 @@ static struct {
> 	int queue;
> 	int default_ticks;
> 	unsigned long inuse;
>-	unsigned gpio;
>+	struct gpio_desc *gpiod;
> 	unsigned int gstate;
> } mtx1_wdt_device;
>=20
>@@ -67,7 +67,7 @@ static void mtx1_wdt_trigger(struct timer_list
>*unused)
>=20
> 	/* toggle wdt gpio */
> 	mtx1_wdt_device=2Egstate =3D !mtx1_wdt_device=2Egstate;
>-	gpio_set_value(mtx1_wdt_device=2Egpio, mtx1_wdt_device=2Egstate);
>+	gpiod_set_value(mtx1_wdt_device=2Egpiod, mtx1_wdt_device=2Egstate);
>=20
> 	if (mtx1_wdt_device=2Equeue && ticks)
> 		mod_timer(&mtx1_wdt_device=2Etimer, jiffies + MTX1_WDT_INTERVAL);
>@@ -90,7 +90,7 @@ static void mtx1_wdt_start(void)
> 	if (!mtx1_wdt_device=2Equeue) {
> 		mtx1_wdt_device=2Equeue =3D 1;
> 		mtx1_wdt_device=2Egstate =3D 1;
>-		gpio_set_value(mtx1_wdt_device=2Egpio, 1);
>+		gpiod_set_value(mtx1_wdt_device=2Egpio, 1);
> 		mod_timer(&mtx1_wdt_device=2Etimer, jiffies + MTX1_WDT_INTERVAL);
> 	}
> 	mtx1_wdt_device=2Erunning++;
>@@ -105,7 +105,7 @@ static int mtx1_wdt_stop(void)
> 	if (mtx1_wdt_device=2Equeue) {
> 		mtx1_wdt_device=2Equeue =3D 0;
> 		mtx1_wdt_device=2Egstate =3D 0;
>-		gpio_set_value(mtx1_wdt_device=2Egpio, 0);
>+		gpiod_set_value(mtx1_wdt_device=2Egpio, 0);
> 	}
> 	ticks =3D mtx1_wdt_device=2Edefault_ticks;
> 	spin_unlock_irqrestore(&mtx1_wdt_device=2Elock, flags);
>@@ -198,12 +198,11 @@ static int mtx1_wdt_probe(struct platform_device
>*pdev)
> {
> 	int ret;
>=20
>-	mtx1_wdt_device=2Egpio =3D pdev->resource[0]=2Estart;
>-	ret =3D devm_gpio_request_one(&pdev->dev, mtx1_wdt_device=2Egpio,
>-				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
>-	if (ret < 0) {
>+	mtx1_wdt_device=2Egpiod =3D devm_gpiod_get(&pdev->dev,
>+					       NULL, GPIOD_OUT_HIGH);
>+	if (IS_ERR(mtx1_wdt_device=2Egpiod)) {
> 		dev_err(&pdev->dev, "failed to request gpio");
>-		return ret;
>+		return PTR_ERR(mtx1_wdt_device=2Egpiod);
> 	}
>=20
> 	spin_lock_init(&mtx1_wdt_device=2Elock);

--=20
Florian
