Return-path: <lee.jones@linaro.org>
Date: Mon, 18 Jan 2016 07:42:15 +0000
From: Lee Jones <lee.jones@linaro.org>
To: richard.dorsch@gmail.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com
Subject: Re: [PATCH v3 2/6] Add Advantech iManager GPIO driver
Message-ID: <20160118074215.GJ28745@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-3-git-send-email-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452468675-5827-3-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 10 Jan 2016, richard.dorsch@gmail.com wrote:

> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> 
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>  drivers/gpio/Kconfig              |   8 ++
>  drivers/gpio/Makefile             |   2 +
>  drivers/gpio/imanager-ec-gpio.c   |  98 +++++++++++++++++++++
>  drivers/gpio/imanager-gpio.c      | 181 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/imanager/gpio.h |  27 ++++++

Same comments as Watchdog and HWMON.

>  5 files changed, 316 insertions(+)
>  create mode 100644 drivers/gpio/imanager-ec-gpio.c
>  create mode 100644 drivers/gpio/imanager-gpio.c
>  create mode 100644 include/linux/mfd/imanager/gpio.h

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
