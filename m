Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34735 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbFAHi2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Jun 2015 03:38:28 -0400
Received: by wgv5 with SMTP id 5so106490041wgv.1
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Jun 2015 00:38:27 -0700 (PDT)
Date: Mon, 1 Jun 2015 08:38:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, wim@iguana.be, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com
Subject: Re: [PATCH v2 00/12] mfd: Add support for Clocksource to LPC set
Message-ID: <20150601073823.GB3329@x1>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Device Tree Maintainers,

All of the functional patches in this series have been Acked by the
relevant maintainers, but the (pretty simple) DT changes are in need
of a suitable Ack.

Would someone mine glancing over them please?

> ST's Low Power Controller (LPC) controls three devices; watchdog, RTC
> and a Clocksource Timer.  Only one of the devices can be used at any
> one time, which is enforced by the Device Driver model.
> =20
> This patchset provides support for the Clocksource driver.  Watchdog
> and RTC are already in -next.
>=20
> Lee Jones (12):
>   mfd: dt-bindings: Provide human readable define for Clocksource mod=
e
>   clocksource: sti: Provide support for the ST LPC Clocksource IP
>   clocksource: sti: Provide 'use timer as sched clock' capability
>   clocksource: bindings: Provide bindings for ST's LPC Clocksource
>     device
>   watchdog: st_wdt: Update IP layout information to include Clocksour=
ce
>   watchdog: bindings: Supply knowledge of a third supported device -
>     clocksource
>   rtc: st: Update IP layout information to include Clocksource
>   rtc: bindings: Supply knowledge of a third supported device -
>     clocksource
>   MAINTAINERS: Add the LPC Clocksource to STi maintained driver list
>   ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource
>   ARM: STi: Enable LPC Clocksource
>   ARM: STi: Update platform level menuconfig 'help'
>=20
>  .../devicetree/bindings/rtc/rtc-st-lpc.txt         |  15 ++-
>  .../devicetree/bindings/timer/st,stih407-lpc       |  28 +++++
>  .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |  12 +-
>  MAINTAINERS                                        |   1 +
>  arch/arm/boot/dts/stih407-family.dtsi              |   2 +-
>  arch/arm/mach-sti/Kconfig                          |  10 +-
>  drivers/clocksource/Kconfig                        |   9 ++
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/clksrc_st_lpc.c                | 129 +++++++++++=
++++++++++
>  drivers/rtc/rtc-st-lpc.c                           |   2 +-
>  drivers/watchdog/st_lpc_wdt.c                      |   2 +-
>  include/dt-bindings/mfd/st-lpc.h                   |   1 +
>  12 files changed, 194 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/st,stih40=
7-lpc
>  create mode 100644 drivers/clocksource/clksrc_st_lpc.c
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
