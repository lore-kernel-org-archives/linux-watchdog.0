Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:40392 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbbCDPoI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 10:44:08 -0500
Received: by wevk48 with SMTP id k48so3733470wev.7
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Mar 2015 07:44:07 -0800 (PST)
Date: Wed, 4 Mar 2015 15:44:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/9] mfd: syscon: Add atmel system timer registers
 definition
Message-ID: <20150304154403.GM32624@x1>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-3-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1425478897-27322-3-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 04 Mar 2015, Alexandre Belloni wrote:

> AT91RM920 has a memory range reserved for timer and watchdog configur=
ation.
> Expose those registers so that drivers can make use of the system tim=
er syscon
> declared in at91 DTs.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> ---
>  include/linux/mfd/syscon/atmel-st.h | 47 +++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 include/linux/mfd/syscon/atmel-st.h
>=20
> diff --git a/include/linux/mfd/syscon/atmel-st.h b/include/linux/mfd/=
syscon/atmel-st.h
> new file mode 100644
> index 000000000000..8e29a1028807
> --- /dev/null
> +++ b/include/linux/mfd/syscon/atmel-st.h
> @@ -0,0 +1,47 @@
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
> +#define	AT91_ST_CR	0x00	/* Control Register */
> +#define		AT91_ST_WDRST	(1 << 0)	/* Watchdog Timer Restart */

Please use BIT() for "1 <<".

> +#define	AT91_ST_PIMR	0x04	/* Period Interval Mode Register */
> +#define		AT91_ST_PIV	(0xffff <<  0)	/* Period Interval Value */
> +
> +#define	AT91_ST_WDMR	0x08	/* Watchdog Mode Register */
> +#define		AT91_ST_WDV	(0xffff <<  0)	/* Watchdog Counter Value */
> +#define		AT91_ST_RSTEN	(1 << 16)	/* Reset Enable */
> +#define		AT91_ST_EXTEN	(1 << 17)	/* External Signal Assertion Enable=
 */
> +
> +#define	AT91_ST_RTMR	0x0c	/* Real-time Mode Register */
> +#define		AT91_ST_RTPRES	(0xffff <<  0)	/* Real-time Prescalar Value =
*/
> +
> +#define	AT91_ST_SR	0x10	/* Status Register */
> +#define		AT91_ST_PITS	(1 << 0)	/* Period Interval Timer Status */
> +#define		AT91_ST_WDOVF	(1 << 1)	/* Watchdog Overflow */
> +#define		AT91_ST_RTTINC	(1 << 2)	/* Real-time Timer Increment */
> +#define		AT91_ST_ALMS	(1 << 3)	/* Alarm Status */
> +
> +#define	AT91_ST_IER	0x14	/* Interrupt Enable Register */
> +#define	AT91_ST_IDR	0x18	/* Interrupt Disable Register */
> +#define	AT91_ST_IMR	0x1c	/* Interrupt Mask Register */
> +
> +#define	AT91_ST_RTAR	0x20	/* Real-time Alarm Register */
> +#define		AT91_ST_ALMV	(0xfffff << 0)	/* Alarm Value */
> +
> +#define	AT91_ST_CRTR	0x24	/* Current Real-time Register */
> +#define		AT91_ST_CRTV	(0xfffff << 0)	/* Current Real-Time Value */
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
