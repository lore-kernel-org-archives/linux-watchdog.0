Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Graeme Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
Date: Thu, 14 May 2015 22:03:25 +0200
Message-ID: <3074350.inBBIzlShL@wuerfel>
In-Reply-To: <1431622353-11196-1-git-send-email-timur@codeaurora.org>
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday 14 May 2015 11:52:33 Timur Tabi wrote:
> +static int arm_sbsa_wdt_set_timeout(struct watchdog_device *wdev,
> +       unsigned int timeout)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +       uint32_t wor;
> +
> +       wdev->timeout = timeout;
> +
> +       wor = arch_timer_get_cntfrq() * wdev->timeout;
> +       writel(cpu_to_le32(wor), &data->control->wor);

Why the double endianess swap? Are the registers defined to be CPU-endian?

You probably mean le32_to_cpu() here, not the other way round, although 
the effect is the same.

	Arnd
