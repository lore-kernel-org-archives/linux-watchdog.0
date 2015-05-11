Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35950 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbbEKKxx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 May 2015 06:53:53 -0400
Received: by wizk4 with SMTP id k4so100340918wiz.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2015 03:53:52 -0700 (PDT)
Date: Mon, 11 May 2015 11:53:47 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org, tglx@linutronix.de,
	wim@iguana.be, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	linux@roeck-us.net
Subject: Re: [PATCH 02/12] clocksource: sti: Provide support for the ST LPC
 Clocksource IP
Message-ID: <20150511105347.GA20742@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
 <55506B87.3070807@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <55506B87.3070807@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 11 May 2015, Daniel Lezcano wrote:

> On 05/07/2015 03:38 PM, Lee Jones wrote:
> >This IP is shared with Watchdog and RTC functionality.  Only one of
> >these IPs can be used at the same time.  We use the device-driver
> >model combined with a DT 'mode' property to enforce this.
> >
> >The ST LPC Clocksource IP can be used as the system (tick) timer.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  drivers/clocksource/Kconfig         |   8 +++
> >  drivers/clocksource/Makefile        |   1 +
> >  drivers/clocksource/clksrc_st_lpc.c | 123 ++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 132 insertions(+)
> >  create mode 100644 drivers/clocksource/clksrc_st_lpc.c
> >
> >diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconf=
ig
> >index 68161f7..ac424cf 100644
> >--- a/drivers/clocksource/Kconfig
> >+++ b/drivers/clocksource/Kconfig
> >@@ -250,4 +250,12 @@ config CLKSRC_PXA
> >  	help
> >  	  This enables OST0 support available on PXA and SA-11x0
> >  	  platforms.
> >+
> >+config CLKSRC_ST_LPC
> >+	bool
> >+	depends on ARCH_STI
> >+	select CLKSRC_OF if OF
> >+	help
> >+	  Enable this option to use the Low Power controller timer
> >+	  as clocksource.
> >  endmenu
> >diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Make=
file
> >index 752d5c7..e08da4d 100644
> >--- a/drivers/clocksource/Makefile
> >+++ b/drivers/clocksource/Makefile
> >@@ -51,3 +51,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+=3D timer-integr=
ator-ap.o
> >  obj-$(CONFIG_CLKSRC_VERSATILE)		+=3D versatile.o
> >  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+=3D mips-gic-timer.o
> >  obj-$(CONFIG_ASM9260_TIMER)		+=3D asm9260_timer.o
> >+obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
> >diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksour=
ce/clksrc_st_lpc.c
> >new file mode 100644
> >index 0000000..18a7dcd0
> >--- /dev/null
> >+++ b/drivers/clocksource/clksrc_st_lpc.c
> >@@ -0,0 +1,123 @@
> >+/*
> >+ * Clocksource using the Low Power Timer found in the Low Power Con=
troller (LPC)
> >+ *
> >+ * Copyright (C) 2015 STMicroelectronics =E2=80=93 All Rights Reser=
ved
> >+ *
> >+ * Author(s): Francesco Virlinzi <francesco.virlinzi@st.com>
> >+ *	      Ajit Pal Singh <ajitpal.singh@st.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or mo=
dify
> >+ * it under the terms of the GNU General Public License as publishe=
d by
> >+ * the Free Software Foundation; either version 2 of the License, o=
r
> >+ * (at your option) any later version.
> >+ */
> >+
> >+#include <linux/clk.h>
> >+#include <linux/clocksource.h>
> >+#include <linux/init.h>
> >+#include <linux/of_address.h>
> >+#include <linux/slab.h>
> >+
> >+#include <dt-bindings/mfd/st-lpc.h>
> >+
> >+/* Low Power Timer */
> >+#define LPC_LPT_LSB_OFF		0x400
> >+#define LPC_LPT_MSB_OFF		0x404
> >+#define LPC_LPT_START_OFF	0x408
> >+
> >+static struct st_clksrc_ddata {
> >+	struct clk		*clk;
> >+	void __iomem		*base;
> >+} ddata;
> >+
> >+static void st_clksrc_reset(void)
> >+{
> >+	writel_relaxed(0, ddata.base + LPC_LPT_START_OFF);
> >+	writel_relaxed(0, ddata.base + LPC_LPT_MSB_OFF);
> >+	writel_relaxed(0, ddata.base + LPC_LPT_LSB_OFF);
> >+	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
> >+}
> >+
> >+static int __init st_clksrc_init(void)
> >+{
> >+	unsigned long rate;
> >+	int ret;
> >+
> >+	st_clksrc_reset();
> >+
> >+	rate =3D clk_get_rate(ddata.clk);
> >+
> >+	ret =3D clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
> >+				    "clksrc-st-lpc", rate, 300, 32,
> >+				    clocksource_mmio_readl_up);
> >+	if (ret) {
> >+		pr_err("clksrc-st-lpc: Failed to register clocksource\n");
> >+		return ret;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int st_clksrc_setup_clk(struct device_node *np)
> >+{
> >+	struct clk *clk;
> >+	int ret;
> >+
> >+	clk =3D of_clk_get(np, 0);
> >+	if (IS_ERR(clk)) {
> >+		pr_err("clksrc-st-lpc: Failed to get LPC clock\n");
> >+		ret =3D PTR_ERR(clk);
> >+		return ret;
>=20
> return PTR_ERR(clk);
>=20
> so you can get rid of the 'int ret' variable.

Absolutely.  Good spot.

> >+	}
> >+
> >+	if (clk_prepare_enable(clk)) {
> >+		pr_err("clksrc-st-lpc: Failed to enable LPC clock\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	if (!clk_get_rate(clk)) {
> >+		pr_err("clksrc-st-lpc: Failed to get LPC clock rate\n");
> >+		clk_disable_unprepare(clk);
> >+		return -EINVAL;
> >+	}
> >+
> >+	ddata.clk =3D clk;
> >+
> >+	return 0;
> >+}
> >+
> >+static void __init st_clksrc_of_register(struct device_node *np)
> >+{
> >+	int ret;
> >+	uint32_t mode;
> >+
> >+	ret =3D of_property_read_u32(np, "st,lpc-mode", &mode);
> >+	if (ret) {
> >+		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
> >+		return;
> >+	}
> >+
> >+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> >+	if (mode !=3D ST_LPC_MODE_CLKSRC)
> >+		return;
>=20
> I am confused with this patch description + comment and the patch
> 1's description.
>=20
> For the former, I understand the LPC could be in RTC or WDT mode and
> used as a clocksource (clksrc + rtc / clksrc + wdt), for the latter
> I understand there are three modes clocksource, rtc and watchdog
> (mutually exclusive). Could you clarify ?

They are all mutually exclusive.  I will fix-up the commit log to
re-enforce this.

> >+
> >+	ddata.base =3D of_iomap(np, 0);
> >+	if (!ddata.base) {
> >+		pr_err("clksrc-st-lpc: Unable to map iomem\n");
> >+		return;
> >+	}
> >+
> >+	if (st_clksrc_setup_clk(np)) {
> >+		iounmap(ddata.base);
> >+		return;
> >+	}
> >+
> >+	if (st_clksrc_init()) {
> >+		iounmap(ddata.base);
> >+		return;
> >+	}
> >+
> >+	pr_info("clksrc-st-lpc: clocksource initialised - running @ %luHz\=
n",
> >+		clk_get_rate(ddata.clk));
> >+}
> >+CLOCKSOURCE_OF_DECLARE(ddata, "st,stih407-lpc", st_clksrc_of_regist=
er);
> >
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
