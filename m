Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46235 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab1KNUYx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Nov 2011 15:24:53 -0500
Received: by fagn18 with SMTP id n18so3418199fag.19
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Nov 2011 12:24:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1321207952-13556-10-git-send-email-plagnioj@jcrosoft.com>
References: <20111113180954.GD15318@game.jcrosoft.org>
	<1321207952-13556-10-git-send-email-plagnioj@jcrosoft.com>
Date: Mon, 14 Nov 2011 22:24:52 +0200
Message-ID: <CAFumwP0ExjSoPfM1B8d0TeMys3M9vtfz8hfXoJKqwVXWHNQt=Q@mail.gmail.com>
Subject: Re: [PATCH 10/12] ARM: at91: make watchdog drivers soc independent
From: Andrew Victor <avictor.za@gmail.com>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

hi,

> switch the watchdog drivers to resource and pass it via platform_device

What's this at91_devices.c ?
It looks like some unrelated code was included with a watchdog patch...

Regards,
  Andrew Victor



> +++ b/arch/arm/mach-at91/at91_devices.c
> @@ -0,0 +1,122 @@
> +/*
> + * arch/arm/mach-at91/at91cap9_devices.c
> + *
> + * =A0Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
> + * =A0Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
> + * =A0Copyright (C) 2007 Atmel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <mach/gpio.h>
> +
> +#include "generic.h"
> +
> +void at91cap9_configure_dbgu_pins(void)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PC30, 0); =A0 =A0 =A0 =A0 =A0 =
=A0/* DRXD */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PC31, 1); =A0 =A0 =A0 =A0 =A0 =
=A0/* DTXD */
> +}
> +
> +void at91cap9_configure_usart0_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA22, 1); =A0 =A0 =A0 =A0 =A0 =
=A0/* TXD0 */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA23, 0); =A0 =A0 =A0 =A0 =A0 =
=A0/* RXD0 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA24, 0); =A0 =
=A0/* RTS0 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA25, 0); =A0 =
=A0/* CTS0 */
> +}
> +
> +void at91cap9_configure_usart1_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PD0, 1); =A0 =A0 =A0 =A0 =A0 =A0=
 /* TXD1 */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PD1, 0); =A0 =A0 =A0 =A0 =A0 =A0=
 /* RXD1 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PD7, 0); =A0 =A0=
 /* RTS1 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PD8, 0); =A0 =A0=
 /* CTS1 */
> +}
> +
> +void at91cap9_configure_usart2_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PD2, 1); =A0 =A0 =A0 =A0 =A0 =A0=
 /* TXD2 */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PD3, 0); =A0 =A0 =A0 =A0 =A0 =A0=
 /* RXD2 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PD5, 0); =A0 =A0=
 /* RTS2 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PD6, 0); =A0 =A0=
 /* CTS2 */
> +}
> +
> +void at91rm9200_configure_dbgu_pins(void)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA30, 0); =A0 =A0 =A0 =A0 =A0 =
=A0/* DRXD */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA31, 1); =A0 =A0 =A0 =A0 =A0 =
=A0/* DTXD */
> +}
> +
> +void at91rm9200_configure_usart0_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA17, 1); =A0 =A0 =A0 =A0 =A0 =
=A0/* TXD0 */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA18, 0); =A0 =A0 =A0 =A0 =A0 =
=A0/* RXD0 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA20, 0); =A0 =
=A0/* CTS0 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* AT91RM9200 Errata #39 - RTS0 is not =
internally connected to PA21.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0We need to drive the pin manually=
. =A0Default is off (RTS is active low).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_gpio_output(AT91_PIN_PA21, 1);
> + =A0 =A0 =A0 }
> +}
> +
> +void at91rm9200_configure_usart1_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB20, 1); =A0 =A0 =A0 =A0 =A0 =
=A0/* TXD1 */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB21, 0); =A0 =A0 =A0 =A0 =A0 =
=A0/* RXD1 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RI)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB18, 0); =A0 =
=A0/* RI1 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_DTR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB19, 0); =A0 =
=A0/* DTR1 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_DCD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB23, 0); =A0 =
=A0/* DCD1 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB24, 0); =A0 =
=A0/* CTS1 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_DSR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB25, 0); =A0 =
=A0/* DSR1 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PB26, 0); =A0 =
=A0/* RTS1 */
> +}
> +
> +void at91rm9200_configure_usart2_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA22, 0); =A0 =A0 =A0 =A0 =A0 =
=A0/* RXD2 */
> + =A0 =A0 =A0 at91_set_A_periph(AT91_PIN_PA23, 1); =A0 =A0 =A0 =A0 =A0 =
=A0/* TXD2 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PA30, 0); =A0 =
=A0/* CTS2 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PA31, 0); =A0 =
=A0/* RTS2 */
> +}
> +
> +void at91rm9200_configure_usart3_pins(unsigned pins)
> +{
> + =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PA5, 1); =A0 =A0 =A0 =A0 =A0 =A0=
 /* TXD3 */
> + =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PA6, 0); =A0 =A0 =A0 =A0 =A0 =A0=
 /* RXD3 */
> +
> + =A0 =A0 =A0 if (pins & ATMEL_UART_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PB1, 0); =A0 =A0=
 /* CTS3 */
> + =A0 =A0 =A0 if (pins & ATMEL_UART_RTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at91_set_B_periph(AT91_PIN_PB0, 0); =A0 =A0=
 /* RTS3 */
> +}
> +
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
