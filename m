Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51042 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933788AbbEPIxb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 16 May 2015 04:53:31 -0400
Date: Sat, 16 May 2015 10:53:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
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
Subject: Re: [rtc-linux] [PATCH V2 1/4] mfd: da9062: DA9062 MFD core driver
Message-ID: <20150516085328.GI3338@piout.net>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <af5a7d289bb149e9111ebc70bb0589a994ee2407.1431621833.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5a7d289bb149e9111ebc70bb0589a994ee2407.1431621833.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 14/05/2015 at 17:43:52 +0100, S Twiss wrote :
> +config MFD_DA9062
> +	tristate "Dialog Semiconductor DA9062 PMIC Support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=y

Isn't depends on I2C enough?

> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> new file mode 100644
> index 0000000..e6a9878
> --- /dev/null
> +++ b/drivers/mfd/da9062-core.c
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
> +#include <linux/of.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#include <linux/proc_fs.h>
> +#include <linux/kthread.h>
> +#include <linux/uaccess.h>
> +

You should order the header inclusions alphabetically

[...]

> +	{
> +		.name		= "da9062-watchdog",
> +		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
> +		.resources	= da9062_wdt_resources,
> +		.of_compatible  = "dlg,da9062-wdt",
> +	},
> +	{
> +		.name		= "da9062-onkey",
> +		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
> +		.resources	= da9062_onkey_resources,
> +		.of_compatible  = "dlg,da9062-onkey",
> +	},
> +	{
> +		.name		= "da9062-thermal",
> +		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
> +		.resources	= da9062_thermal_resources,
> +		.of_compatible  = "dlg,da9062-thermal",
> +	},
> +	{
> +		.name		= "da9062-rtc",
> +		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
> +		.resources	= da9062_rtc_resources,
> +		.of_compatible  = "dlg,da9062-rtc",

Did you try to use "da9063-rtc"? The register set seems to be exactly
the same. Unfortunately, the datasheet are not available on the diasemi
website...

Also, the .of_compatibles are not necessary because you don't add any of
bindings to the underlying drivers. The match happens on .name.

> diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd/da9062/registers.h
> new file mode 100644
> index 0000000..d07c2bc
> --- /dev/null
> +++ b/include/linux/mfd/da9062/registers.h

Comparing that file with da9063/registers.h, It really seems that
DA062AA, DA9063AD and DA9063BB are register compatible, apart from a few
differences in the regulator and the gpio count.

Also, at least the watchdog and rtc driver are duplicating their da9063
counterpart. I'm not trying to annoy you, I just want you to understand
that the less code is duplicated, the easiest it will be to maintain
later.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
