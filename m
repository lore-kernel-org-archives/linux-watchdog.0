Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb2-smtp-cloud2.xs4all.net ([194.109.24.25]:55752 "EHLO
	lb2-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171AbbDRI1a (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Apr 2015 04:27:30 -0400
Message-ID: <1429345645.16771.139.camel@x220>
Subject: Re: [PATCH V1 1/6] mfd: da9062: DA9062 MFD core driver
From: Paul Bolle <pebolle@tiscali.nl>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Date: Sat, 18 Apr 2015 10:27:25 +0200
In-Reply-To: <b3bb4bc09cd94b0b13c713d98dd64576722123c1.1429280614.git.stwiss.opensource@diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
	 <b3bb4bc09cd94b0b13c713d98dd64576722123c1.1429280614.git.stwiss.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2015-04-17 at 15:23 +0100, S Twiss wrote:
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

> +config MFD_DA9062
> +	bool "Dialog Semiconductor DA9062 PMIC Support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=y
> +	help
> +	  Say yes here for support for the Dialog Semiconductor DA9062 PMIC.
> +	  This includes the I2C driver and core APIs.
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.

> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile

> +obj-$(CONFIG_MFD_DA9062)	+= da9062-core.o

MFD_DA9062 is a bool symbol. So da9062-core.o can never be part of a
module, right?

> --- /dev/null
> +++ b/drivers/mfd/da9062-core.c

> +#include <linux/module.h>

So you might not need this include.

> +MODULE_DEVICE_TABLE(of, da9062_dt_ids);

This macro will be preprocessed away for built-in code, according to
include/linux/module.h.

> +MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);

Ditto.

> +static struct i2c_driver da9062_i2c_driver = {
> +	.driver = {
> +		.name = "da9062",
> +		.of_match_table = of_match_ptr(da9062_dt_ids),
> +	},
> +	.probe    = da9062_i2c_probe,
> +	.remove   = da9062_i2c_remove,
> +	.id_table = da9062_i2c_id,
> +};
> +
> +module_i2c_driver(da9062_i2c_driver);

After looking at a few levels of #defines I think this is equivalent to
     i2c_register_driver(NULL, da9062_i2c_driver);

for built-in code. Did I grep that right?

> +MODULE_DESCRIPTION("CORE device driver for Dialog DA9062");
> +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> +MODULE_LICENSE("GPL v2");

These macros will be effectively preprocessed away for built-in only
code.

Thanks,


Paul Bolle

