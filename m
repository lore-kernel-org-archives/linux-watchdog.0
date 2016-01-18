Return-path: <lee.jones@linaro.org>
Date: Mon, 18 Jan 2016 07:38:05 +0000
From: Lee Jones <lee.jones@linaro.org>
To: richard.dorsch@gmail.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com
Subject: Re: [PATCH v3 6/6] Add Advantech iManager Watchdog driver
Message-ID: <20160118073805.GG28745@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-7-git-send-email-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452468675-5827-7-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 10 Jan 2016, richard.dorsch@gmail.com wrote:

> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Some more information required about the device here.

> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>  drivers/watchdog/Kconfig           |  12 ++
>  drivers/watchdog/Makefile          |   2 +
>  drivers/watchdog/imanager-ec-wdt.c | 170 +++++++++++++++++++
>  drivers/watchdog/imanager-wdt.c    | 333 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/imanager/wdt.h   |  37 +++++

Please relocate this to include/linux/watchdog.

>  5 files changed, 554 insertions(+)
>  create mode 100644 drivers/watchdog/imanager-ec-wdt.c
>  create mode 100644 drivers/watchdog/imanager-wdt.c
>  create mode 100644 include/linux/mfd/imanager/wdt.h

[...]

> diff --git a/include/linux/mfd/imanager/wdt.h b/include/linux/mfd/imanager/wdt.h
> new file mode 100644
> index 0000000..eb709b7
> --- /dev/null
> +++ b/include/linux/mfd/imanager/wdt.h
> @@ -0,0 +1,37 @@
> +/*
> + * Advantech iManager Watchdog core
> + *
> + * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
> + * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __WDT_H__
> +#define __WDT_H__

These need to be less generic.

> +#include <linux/types.h>
> +
> +enum wdt_event {
> +	DELAY,
> +	PWRBTN,
> +	NMI,
> +	RESET,
> +	WDPIN,
> +	SCI,
> +};

Unless shared between other source files, this should probably move
into the driver.

> +int wdt_core_init(void);
> +
> +int wdt_core_set_timeout(enum wdt_event type, u32 timeout);
> +
> +int wdt_core_disable_all(void);
> +int wdt_core_start_timer(void);
> +int wdt_core_stop_timer(void);
> +int wdt_core_reset_timer(void);
> +int wdt_core_stop_boot_timer(void);

What's the point of these?

> +#endif
> -- 
> 2.7.0
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
