Return-path: <lee.jones@linaro.org>
Date: Mon, 18 Jan 2016 07:41:46 +0000
From: Lee Jones <lee.jones@linaro.org>
To: richard.dorsch@gmail.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com
Subject: Re: [PATCH v3 4/6] Add Advantech iManager I2C driver
Message-ID: <20160118074146.GI28745@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-5-git-send-email-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452468675-5827-5-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 10 Jan 2016, richard.dorsch@gmail.com wrote:

> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> 
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>  Documentation/i2c/busses/i2c-imanager |  48 ++++
>  drivers/i2c/busses/Kconfig            |  11 +
>  drivers/i2c/busses/Makefile           |   2 +
>  drivers/i2c/busses/imanager-ec-i2c.c  | 466 ++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/imanager-i2c.c     | 239 +++++++++++++++++
>  include/linux/mfd/imanager/i2c.h      |  55 ++++

Same comments as Watchdog and HWMON.

>  6 files changed, 821 insertions(+)
>  create mode 100644 Documentation/i2c/busses/i2c-imanager
>  create mode 100644 drivers/i2c/busses/imanager-ec-i2c.c
>  create mode 100644 drivers/i2c/busses/imanager-i2c.c
>  create mode 100644 include/linux/mfd/imanager/i2c.h

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
