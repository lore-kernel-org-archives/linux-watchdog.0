Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34502 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaLOOSG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Dec 2014 09:18:06 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y0WTO-003URJ-Ed
	for linux-watchdog@vger.kernel.org; Mon, 15 Dec 2014 14:18:06 +0000
Message-ID: <548EED97.60604@roeck-us.net>
Date: Mon, 15 Dec 2014 06:17:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
CC: kernel@stlinux.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] rtc: st: add new driver for ST's LPC RTC
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org> <1418642738-17407-8-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1418642738-17407-8-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2014 03:25 AM, Lee Jones wrote:
> ST's Low Power Controller (LPC) controls two devices; watchdog and RTC.
> Only one of the devices can be used at any one time.  This is enforced
> by the correlating MFD driver.  This portion of the driver-set controls
> the Real Time Clock.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/rtc/Kconfig      |  13 ++
>   drivers/rtc/Makefile     |   1 +
>   drivers/rtc/rtc-st-lpc.c | 330 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 344 insertions(+)
>   create mode 100644 drivers/rtc/rtc-st-lpc.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a168e96..aa4bd90 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1355,6 +1355,18 @@ config RTC_DRV_SIRFSOC
>   	  Say "yes" here to support the real time clock on SiRF SOC chips.
>   	  This driver can also be built as a module called rtc-sirfsoc.
>
> +config RTC_DRV_ST_LPC
> +	tristate "STMicroelectronics LPC RTC"
> +	depends on ARCH_STI
> +	depends on OF
> +	select MFD_ST_LPC
> +	help
> +	  Say Y here to include STMicroelectronics Low Power Controller
> +	  (LPC) based RTC support.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rtc-st-lpc.
> +
>   config RTC_DRV_MOXART
>   	tristate "MOXA ART RTC"
>   	depends on ARCH_MOXART || COMPILE_TEST
> @@ -1390,4 +1402,5 @@ config RTC_DRV_HID_SENSOR_TIME
>   	  rtc-hid-sensor-time.
>
>
> +

Hi Lee,

Yet another empty line ?

Guenter

