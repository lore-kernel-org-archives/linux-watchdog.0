Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:41501 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbaHULaw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Aug 2014 07:30:52 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so12677948igd.8
        for <linux-watchdog@vger.kernel.org>; Thu, 21 Aug 2014 04:30:52 -0700 (PDT)
Date: Thu, 21 Aug 2014 12:30:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, cooloney@gmail.com,
	rpurdie@rpsys.net, linux-leds@vger.kernel.org, jdelvare@suse.de,
	linux@roeck-us.net, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v4 1/4] drivers/mfd/menf21bmc: introduce MEN 14F021P00
 BMC MFD Core driver
Message-ID: <20140821113046.GZ4266@lee--X1>
References: <cover.1407918792.git.andreas.werner@men.de>
 <ddd9430eafd8f633a586f9a3cc02ade69ed35817.1407918792.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <ddd9430eafd8f633a586f9a3cc02ade69ed35817.1407918792.git.andreas.werner@men.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 13 Aug 2014, Andreas Werner wrote:
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
>  drivers/mfd/Kconfig     |  12 +++++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/menf21bmc.c | 132 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/mfd/menf21bmc.c
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b8d9ca0..bf155b9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -453,6 +453,18 @@ config MFD_MAX8998
>  	  additional drivers must be enabled in order to use the functional=
ity
>  	  of the device.
> =20
> +config MFD_MENF21BMC
> +	tristate "MEN 14F021P00 Board Management Controller Support"
> +	depends on I2C=3Dy

Why must I2C be built-in?

> +	select MFD_CORE
> +	help
> +	  Say yes here to add support for the MEN 14F021P00 BMC
> +	  which is a Board Management Controller connected to the I2C bus.
> +	  The device supports multiple sub-devices like LED, HWMON  and WDT=
=2E
> +	  This driver provides common support for accessing the devices;
> +	  additional drivers must be enabled in order to use the
> +	  functionality of the BMC device.
> +

Apart from that the patch looks good to me.

I'm assuming this can go in via the MFD tree by itself?

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
