Return-path: <lee.jones@linaro.org>
Date: Mon, 11 Jan 2016 10:23:02 +0000
From: Lee Jones <lee.jones@linaro.org>
To: richard.dorsch@gmail.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com
Subject: Re: [PATCH v3 5/6] Add Advantech iManager Backlight driver
Message-ID: <20160111102302.GV14104@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-6-git-send-email-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452468675-5827-6-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 10 Jan 2016, richard.dorsch@gmail.com wrote:

> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> 
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>  drivers/video/backlight/Kconfig          |  12 ++
>  drivers/video/backlight/Makefile         |   2 +
>  drivers/video/backlight/imanager-bl.c    | 198 +++++++++++++++++++++++++++++++
>  drivers/video/backlight/imanager-ec-bl.c | 118 ++++++++++++++++++
>  include/linux/mfd/imanager/backlight.h   |  37 ++++++
>  5 files changed, 367 insertions(+)
>  create mode 100644 drivers/video/backlight/imanager-bl.c
>  create mode 100644 drivers/video/backlight/imanager-ec-bl.c
>  create mode 100644 include/linux/mfd/imanager/backlight.h

How do you expect this to be reviewed if you don't send it to the
reviewer?

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
