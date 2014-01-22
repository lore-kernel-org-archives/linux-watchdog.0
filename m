Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47889 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752564AbaAVSAv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 13:00:51 -0500
Date: Wed, 22 Jan 2014 15:01:01 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
Message-ID: <20140122180100.GE27273@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
 <3176358.2QFcJHj0fv@wuerfel>
 <20140122162136.GA27273@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140122162136.GA27273@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 01:21:36PM -0300, Ezequiel Garcia wrote:
> > I don't see a good way out that would preserve backwards compatibil=
ity,
> > other than hardcoding the physical address in the driver, which see=
ms
> > just as bad as breaking compatibility. That said, it is always the
> > same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
> > Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcodi=
ng
> > a fallback would technically work, but we should print a fat warnin=
g at
> > boot time if we actually fall back to that.
> >=20
>=20
> Yes, I was thinking just about this. Namely:
>=20
[..]

How about something like this?

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.=
c
index a861b88..0014d23 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -26,6 +26,9 @@
 #include <linux/of.h>
 #include <mach/bridge-regs.h>
=20
+/* RSTOUT mask register physical address for Orion5x, Kirkwood and Dov=
e */
+#define ORION_RSTOUT_MASK	0xf1020108
+
 /*
  * Watchdog timer block registers.
  */
@@ -119,6 +122,30 @@ static irqreturn_t orion_wdt_irq(int irq, void *de=
vid)
 	return IRQ_HANDLED;
 }
=20
+/*
+ * The original devicetree binding for this driver specified only
+ * one memory resource, so in order to keep DT backwards compatibility
+ * we try to fallback to a hardcoded register address, if the resource
+ * is missing from the devicetree.
+ */
+static void __iomem * try_compat_rstout_ioremap(struct platform_device=
 *pdev)
+{
+	struct resource *res;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res)
+		return devm_ioremap(&pdev->dev, res->start,
+				    resource_size(res));
+
+	/* This workaround works only for "orion-wdt", DT-enabled */
+	if (!of_device_is_compatible(pdev->dev.of_node, "marvell,orion-wdt"))
+		return NULL;
+
+	dev_warn(&pdev->dev, "falling back to harcoded RSTOUT reg 0x%x\n",
+		 ORION_RSTOUT_MASK);
+	return devm_ioremap(&pdev->dev, ORION_RSTOUT_MASK, 0x4);
+}
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -139,10 +166,7 @@ static int orion_wdt_probe(struct platform_device =
*pdev)
 	if (!wdt_reg)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
-	wdt_rstout =3D devm_ioremap(&pdev->dev, res->start, resource_size(res=
));
+	wdt_rstout =3D try_compat_rstout_ioremap(pdev);
 	if (!wdt_rstout)
 		return -ENOMEM;
=20
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
