Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:31649 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbbCLOEo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Mar 2015 10:04:44 -0400
Message-ID: <55019CF3.7040609@atmel.com>
Date: Thu, 12 Mar 2015 15:04:35 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	"Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] Atmel System Timer cleanups
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Le 12/03/2015 13:07, Alexandre Belloni a =E9crit :
> This patch set cleans up the system timer driver.
>=20
> The main goal is to get rid of the mach/ headers dependency. At the s=
ame time,
> it introduces proper probing and locking (using a regmap) for the wat=
chdog
> driver.
>=20
> This is based on 4.0-rc1 and will have two merge conflicts with my cl=
eanup #1 in
> mach-at91/at91rm9200.c
>=20
> It also needs this patch to probe the watchdog properly:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/3272=
74.html
>=20
> Changes in v5:
>  - Documented the watchdog compatible
>  - Switched to simple-mfd to probe the system timer subnodes
>  - Selected ATMEL_ST from mach-at91/Kconfig instead of using def_bool=
 SOC_AT91RM9200
>  - Reordered the atmel-st probe cleanup and its move to driver/clocks=
ource
>  - Added a patch to replace setup_irq by request_irq
>  - Merged the reset handling in the watchdog timer as we are using th=
e watchdog
>    anyway to reset the board.
>  - Used a simple space after a #define for registers
>=20
> Changes in v4:
>  - Added MODULE_* metadata in at91rm9200-reset
>  - Proper copyright in at91rm9200-reset
>  - Use BIT() in atmel-st.h
>  - changed MODULE_ALIAS in at91rm9200_wdt.c
>=20
> Changes in v3:
>  - stop using an mfd and get the syscon directly from the watchdog dr=
iver
>  - introduce a proper reset driver to handle reset
>=20
> Changes in v2:
>  - cleaned up more includes in the watchdog driver
>  - stop using if OF when selecting CLKSRC_OF
>  - stop initializing .owner
>=20
>=20
> Alexandre Belloni (10):
>   ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
>   mfd: syscon: Add atmel system timer registers definition
>   watchdog: at91rm9200: use the system timer syscon
>   watchdog: at91rm9200: implement restart handler
>   ARM: at91: at91rm9200: remove deprecated arm_pm_restart
>   ARM: at91: properly initialize timer
>   ARM: at91: time: move the system timer driver to drivers/clocksourc=
e
>   clocksource: atmel-st: use syscon/regmap
>   clocksource: atmel-st: remove mach/hardware dependency
>   ARM: at91: remove useless include

I'm okay with the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

But anyway, I'm waiting for a couple of more Ack.

Thanks, bye.

>  .../devicetree/bindings/arm/atmel-at91.txt         |   4 +-
>  arch/arm/boot/dts/at91rm9200.dtsi                  |   6 +-
>  arch/arm/mach-at91/Kconfig                         |   1 +
>  arch/arm/mach-at91/Makefile                        |   2 +-
>  arch/arm/mach-at91/at91rm9200.c                    |  19 ----
>  arch/arm/mach-at91/generic.h                       |   3 -
>  arch/arm/mach-at91/include/mach/at91_st.h          |  61 -----------
>  drivers/clocksource/Kconfig                        |   4 +
>  drivers/clocksource/Makefile                       |   1 +
>  .../clocksource/timer-atmel-st.c                   | 115 ++++++++---=
----------
>  drivers/watchdog/Kconfig                           |   2 +-
>  drivers/watchdog/at91rm9200_wdt.c                  |  61 +++++++++--
>  include/linux/mfd/syscon/atmel-st.h                |  49 +++++++++
>  13 files changed, 164 insertions(+), 164 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
>  rename arch/arm/mach-at91/at91rm9200_time.c =3D> drivers/clocksource=
/timer-atmel-st.c (74%)
>  create mode 100644 include/linux/mfd/syscon/atmel-st.h
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
