Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45920 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbCMKWU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:22:20 -0400
Received: by wggx13 with SMTP id x13so22158743wgg.12
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2015 03:22:19 -0700 (PDT)
Message-ID: <5502BA58.10805@linaro.org>
Date: Fri, 13 Mar 2015 11:22:16 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 10/10] ARM: at91: remove useless include
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <1426162054-9987-11-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-11-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
> Both drivers using the system timer are now converted to an MFD. mach/a=
t91_st.h
> is now useless.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-at91/include/mach/at91_st.h | 61 ----------------------=
---------
>   1 file changed, 61 deletions(-)
>   delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
>
> diff --git a/arch/arm/mach-at91/include/mach/at91_st.h b/arch/arm/mach-=
at91/include/mach/at91_st.h
> deleted file mode 100644
> index 67fdbd13c3ed..000000000000
> --- a/arch/arm/mach-at91/include/mach/at91_st.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/*
> - * arch/arm/mach-at91/include/mach/at91_st.h
> - *
> - * Copyright (C) 2005 Ivan Kokshaysky
> - * Copyright (C) SAN People
> - *
> - * System Timer (ST) - System peripherals registers.
> - * Based on AT91RM9200 datasheet revision E.
> - *
> - * This program is free software; you can redistribute it and/or modif=
y
> - * it under the terms of the GNU General Public License as published b=
y
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#ifndef AT91_ST_H
> -#define AT91_ST_H
> -
> -#ifndef __ASSEMBLY__
> -extern void __iomem *at91_st_base;
> -
> -#define at91_st_read(field) \
> -	__raw_readl(at91_st_base + field)
> -
> -#define at91_st_write(field, value) \
> -	__raw_writel(value, at91_st_base + field)
> -#else
> -.extern at91_st_base
> -#endif
> -
> -#define	AT91_ST_CR		0x00			/* Control Register */
> -#define 	AT91_ST_WDRST		(1 << 0)		/* Watchdog Timer Restart */
> -
> -#define	AT91_ST_PIMR		0x04			/* Period Interval Mode Register */
> -#define		AT91_ST_PIV		(0xffff <<  0)		/* Period Interval Value */
> -
> -#define	AT91_ST_WDMR		0x08			/* Watchdog Mode Register */
> -#define		AT91_ST_WDV		(0xffff <<  0)		/* Watchdog Counter Value */
> -#define		AT91_ST_RSTEN		(1	<< 16)		/* Reset Enable */
> -#define		AT91_ST_EXTEN		(1	<< 17)		/* External Signal Assertion Enable=
 */
> -
> -#define	AT91_ST_RTMR		0x0c			/* Real-time Mode Register */
> -#define		AT91_ST_RTPRES		(0xffff <<  0)		/* Real-time Prescalar Value =
*/
> -
> -#define	AT91_ST_SR		0x10			/* Status Register */
> -#define		AT91_ST_PITS		(1 << 0)		/* Period Interval Timer Status */
> -#define		AT91_ST_WDOVF		(1 << 1) 		/* Watchdog Overflow */
> -#define		AT91_ST_RTTINC		(1 << 2) 		/* Real-time Timer Increment */
> -#define		AT91_ST_ALMS		(1 << 3) 		/* Alarm Status */
> -
> -#define	AT91_ST_IER		0x14			/* Interrupt Enable Register */
> -#define	AT91_ST_IDR		0x18			/* Interrupt Disable Register */
> -#define	AT91_ST_IMR		0x1c			/* Interrupt Mask Register */
> -
> -#define	AT91_ST_RTAR		0x20			/* Real-time Alarm Register */
> -#define		AT91_ST_ALMV		(0xfffff << 0)		/* Alarm Value */
> -
> -#define	AT91_ST_CRTR		0x24			/* Current Real-time Register */
> -#define		AT91_ST_CRTV		(0xfffff << 0)		/* Current Real-Time Value */
> -
> -#endif
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
