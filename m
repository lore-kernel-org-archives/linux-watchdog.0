Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:61338 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936167AbaH1Hhf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Aug 2014 03:37:35 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so464768igb.11
        for <linux-watchdog@vger.kernel.org>; Thu, 28 Aug 2014 00:37:34 -0700 (PDT)
Date: Thu, 28 Aug 2014 08:37:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	linux@roeck-us.net, lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, cooloney@gmail.com,
	rpurdie@rpsys.net, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/4] drivers/mfd/menf21bmc: introduce MEN 14F021P00
 BMC MFD Core driver
Message-ID: <20140828073729.GJ24579@lee--X1>
References: <cover.1409161615.git.andreas.werner@men.de>
 <71aa7a1bbed06f0ec840b3a00664dfd8214fa49a.1409161615.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <71aa7a1bbed06f0ec840b3a00664dfd8214fa49a.1409161615.git.andreas.werner@men.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 27 Aug 2014, Andreas Werner wrote:

> The MEN 14F021P00 Board Management Controller provides an
> I2C interface to the host to access the feature implemented in the BM=
C.
> The BMC is a PIC Microntroller assembled on CPCI Card from MEN Mikroe=
lektronik
> and on a few Box/Display Computer.
>=20
> Added MFD Core driver, supporting the I2C communication to the device=
=2E
>=20
> The MFD driver currently supports the following features:
>  	- Watchdog
>  	- LEDs
> 	- Hwmon (voltage monitoring)
>=20
> Signed-off-by: Andreas Werner <andreas.werner@men.de>
> ---
>  drivers/mfd/Kconfig     |  15 ++++++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/menf21bmc.c | 132 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 drivers/mfd/menf21bmc.c

I'd like to take this set through the MFD tree, but for now:

Acked-by: Lee Jones <lee.jones@linaro.org>

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
