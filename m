Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41903 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbCMIDU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 04:03:20 -0400
Received: by wghl2 with SMTP id l2so21489959wgh.8
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2015 01:03:19 -0700 (PDT)
Date: Fri, 13 Mar 2015 08:03:15 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 02/10] mfd: syscon: Add atmel system timer registers
 definition
Message-ID: <20150313080315.GC3383@x1>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426162054-9987-3-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1426162054-9987-3-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 12 Mar 2015, Alexandre Belloni wrote:

> AT91RM920 has a memory range reserved for timer and watchdog configur=
ation.
> Expose those registers so that drivers can make use of the system tim=
er syscon
> declared in at91 DTs.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/syscon/atmel-st.h | 49 +++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 include/linux/mfd/syscon/atmel-st.h

Applied, thanks.

> diff --git a/include/linux/mfd/syscon/atmel-st.h b/include/linux/mfd/=
syscon/atmel-st.h
> new file mode 100644
> index 000000000000..8acf1ec1fa32
> --- /dev/null
> +++ b/include/linux/mfd/syscon/atmel-st.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright (C) 2005 Ivan Kokshaysky
> + * Copyright (C) SAN People
> + *
> + * System Timer (ST) - System peripherals registers.
> + * Based on AT91RM9200 datasheet revision E.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_MFD_SYSCON_ATMEL_ST_H
> +#define _LINUX_MFD_SYSCON_ATMEL_ST_H
> +
> +#include <linux/bitops.h>
> +
> +#define AT91_ST_CR	0x00	/* Control Register */
> +#define		AT91_ST_WDRST	BIT(0)	/* Watchdog Timer Restart */
> +
> +#define AT91_ST_PIMR	0x04	/* Period Interval Mode Register */
> +#define		AT91_ST_PIV	0xffff	/* Period Interval Value */
> +
> +#define AT91_ST_WDMR	0x08	/* Watchdog Mode Register */
> +#define		AT91_ST_WDV	0xffff	/* Watchdog Counter Value */
> +#define		AT91_ST_RSTEN	BIT(16)	/* Reset Enable */
> +#define		AT91_ST_EXTEN	BIT(17)	/* External Signal Assertion Enable *=
/
> +
> +#define AT91_ST_RTMR	0x0c	/* Real-time Mode Register */
> +#define		AT91_ST_RTPRES	0xffff	/* Real-time Prescalar Value */
> +
> +#define AT91_ST_SR	0x10	/* Status Register */
> +#define		AT91_ST_PITS	BIT(0)	/* Period Interval Timer Status */
> +#define		AT91_ST_WDOVF	BIT(1)	/* Watchdog Overflow */
> +#define		AT91_ST_RTTINC	BIT(2)	/* Real-time Timer Increment */
> +#define		AT91_ST_ALMS	BIT(3)	/* Alarm Status */
> +
> +#define AT91_ST_IER	0x14	/* Interrupt Enable Register */
> +#define AT91_ST_IDR	0x18	/* Interrupt Disable Register */
> +#define AT91_ST_IMR	0x1c	/* Interrupt Mask Register */
> +
> +#define AT91_ST_RTAR	0x20	/* Real-time Alarm Register */
> +#define		AT91_ST_ALMV	0xfffff	/* Alarm Value */
> +
> +#define AT91_ST_CRTR	0x24	/* Current Real-time Register */
> +#define		AT91_ST_CRTV	0xfffff	/* Current Real-Time Value */
> +
> +#endif /* _LINUX_MFD_SYSCON_ATMEL_ST_H */

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
