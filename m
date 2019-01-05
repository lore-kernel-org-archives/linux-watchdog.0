Return-Path: <SRS0=S4iV=PN=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DCFC43387
	for <linux-watchdog@archiver.kernel.org>; Sat,  5 Jan 2019 01:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280192173B
	for <linux-watchdog@archiver.kernel.org>; Sat,  5 Jan 2019 01:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl9oI5Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAEBpm (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:45:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43800 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEBpm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Jan 2019 20:45:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so18177992pgk.10
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Jan 2019 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vvrYkr0tm6soGdI4WlgsFRMGilsOhy19pGLM8Qs7Ldc=;
        b=pl9oI5Qk6kw93WvNrOOdLKat4YqwNg2Z4akA/ooTTy1QAjl/OXiGd7wfo9X7ssyEHG
         TnV9mILge1dHTo5kUDnlK2drvhoQX0E0qIFgM3W+E0EqKK3FWEDtotHlJjb5NyWmQ2+W
         FnETqIgtQFTtPXtsEbSyIP4gl4YENB3/cp5j83B0fTw7X3W907Od0FeHUFUGq20iSqDU
         yH+NEnJPpPWfYK8VJvnttV0TbAndOTBDs2fZW/lTpKD51HM3sVVH+FhcYk11Pcf5zP7m
         N3EbrFrTe/9vEQsJbDNPGjrToAo89J++T1PPou4F7QC2HGGmlAK8nza//VPgEW7F4cqR
         2W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vvrYkr0tm6soGdI4WlgsFRMGilsOhy19pGLM8Qs7Ldc=;
        b=tUPPMzPyxzGSfKg9hCCj/KjlQsvZCKRsZ8Zy/5wBQUe58W23SAm6wKSeJLX+H4kdvX
         C/HiwK2pVmBfSxs5rmaOVwcqC6nINMuebqhiJQqb3sVFNIQbLHPzoLSYfrXYIC1xJSfM
         EvjGe2MpOV2IXxNH7X9C3hzPb8K3El+yR92Y0UhPSUeEm+MgjqrZQdliAsEf2/I2wqN3
         76E9IoH0JeJqEoBCM0gfHcHZwizh040y/yItLDJJtvhfRDjvpRranUAIr1a0o6sz9Awl
         VzAnQnVxgIPN0X2gYuTMEDWbs1+6yERF8oy573dyn0pfElY3/Hwi1FAKrVagQLc7Dh3I
         Bzpg==
X-Gm-Message-State: AJcUukfMpEPImFRKmTYKZsMquT11J9HZlkFV5L/B6+fZqvlfPOSbn4Dt
        AtGtZZuM/iYcwR8KeWIF+qg=
X-Google-Smtp-Source: ALg8bN5GxGzacD+H66Vey2MfQXztaEJhBFhQ59nZPbN4jvrNYRIbkl4522sN+SrbXdlbQ9X1f18nTg==
X-Received: by 2002:a63:d301:: with SMTP id b1mr22727386pgg.61.1546652741285;
        Fri, 04 Jan 2019 17:45:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e123sm73903675pgc.58.2019.01.04.17.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 17:45:40 -0800 (PST)
Subject: Re: [PATCH] watchdog: wm831x: Use GPIO descriptor
To:     Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
References: <20190105010908.26623-1-linus.walleij@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <42d28b28-4c6f-e726-0d0d-60bda2da3f5b@roeck-us.net>
Date:   Fri, 4 Jan 2019 17:45:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190105010908.26623-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 1/4/19 5:09 PM, Linus Walleij wrote:
> The WM831x watchdog driver passes a global GPIO number from
> platform data into this driver, this is discouraged so pass
> a GPIO descriptor instead.
> 
> More thorough approaches are possible passing descriptors
> associated with the device through machine descriptor tables,
> but no boardfiles in the kernel currently use this driver
> so it is hard to test.
> 

There is a semantic change: Up to now, the gpio descriptor/pin
is released when the driver is removed. This is no longer the
case after this patch is applied. What happens with the provided
gpiod on driver removal ?

Anyway, it seems to me that it might make more sense to remove
the platform data and all its uses entirely. It isn't provided
and thus not used, and who knows if it even works. Providing
it would require changes in the mfd driver, which are unlikely
to happen at this point since the driver is close to 10 years old.

Mark, since you wrote that code, do you have any idea what
the use case might be (or have been) ?

Thanks,
Guenter

> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/watchdog/wm831x_wdt.c    | 23 ++++++-----------------
>   include/linux/mfd/wm831x/pdata.h |  3 ++-
>   2 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
> index 116c2f47b463..998a39f83c48 100644
> --- a/drivers/watchdog/wm831x_wdt.c
> +++ b/drivers/watchdog/wm831x_wdt.c
> @@ -13,7 +13,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   #include <linux/uaccess.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>   
>   #include <linux/mfd/wm831x/core.h>
>   #include <linux/mfd/wm831x/pdata.h>
> @@ -29,7 +29,7 @@ struct wm831x_wdt_drvdata {
>   	struct watchdog_device wdt;
>   	struct wm831x *wm831x;
>   	struct mutex lock;
> -	int update_gpio;
> +	struct gpio_desc *update_gpiod;
>   	int update_state;
>   };
>   
> @@ -103,8 +103,8 @@ static int wm831x_wdt_ping(struct watchdog_device *wdt_dev)
>   
>   	mutex_lock(&driver_data->lock);
>   
> -	if (driver_data->update_gpio) {
> -		gpio_set_value_cansleep(driver_data->update_gpio,
> +	if (driver_data->update_gpiod) {
> +		gpiod_set_value_cansleep(driver_data->update_gpiod,
>   					driver_data->update_state);
>   		driver_data->update_state = !driver_data->update_state;
>   		ret = 0;
> @@ -239,19 +239,8 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
>   		reg |= pdata->secondary << WM831X_WDOG_SECACT_SHIFT;
>   		reg |= pdata->software << WM831X_WDOG_RST_SRC_SHIFT;
>   
> -		if (pdata->update_gpio) {
> -			ret = devm_gpio_request_one(&pdev->dev,
> -						pdata->update_gpio,
> -						GPIOF_OUT_INIT_LOW,
> -						"Watchdog update");
> -			if (ret < 0) {
> -				dev_err(wm831x->dev,
> -					"Failed to request update GPIO: %d\n",
> -					ret);
> -				return ret;
> -			}
> -
> -			driver_data->update_gpio = pdata->update_gpio;
> +		if (pdata->update_gpiod) {
> +			driver_data->update_gpiod = pdata->update_gpiod;
>   
>   			/* Make sure the watchdog takes hardware updates */
>   			reg |= WM831X_WDOG_RST_SRC;
> diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
> index dcc9631b3052..ea7e9ad10a14 100644
> --- a/include/linux/mfd/wm831x/pdata.h
> +++ b/include/linux/mfd/wm831x/pdata.h
> @@ -15,6 +15,7 @@
>   #ifndef __MFD_WM831X_PDATA_H__
>   #define __MFD_WM831X_PDATA_H__
>   
> +struct gpio_desc;
>   struct wm831x;
>   struct regulator_init_data;
>   
> @@ -95,7 +96,7 @@ enum wm831x_watchdog_action {
>   
>   struct wm831x_watchdog_pdata {
>   	enum wm831x_watchdog_action primary, secondary;
> -	int update_gpio;
> +	struct gpio_desc *update_gpiod;
>   	unsigned int software:1;
>   };
>   
> 

