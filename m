Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61275 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaLONjE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Dec 2014 08:39:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/8] mfd: Add ST's Low Power Controller driver
Date: Mon, 15 Dec 2014 14:38:33 +0100
Message-ID: <2928949.OKYp272uiY@wuerfel>
In-Reply-To: <1418642738-17407-6-git-send-email-lee.jones@linaro.org>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org> <1418642738-17407-6-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 15 December 2014 11:25:35 Lee Jones wrote:
> +       ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> +       if (ret) {
> +               dev_err(&pdev->dev, "An LPC mode must be selected\n");
> +               return ret;
> +       }
> +
> +       switch (mode) {
> +       case ST_LPC_MODE_RTC:
> +               cell->name = "st-lpc-rtc";
> +               break;
> +       case ST_LPC_MODE_WDT:
> +               cell->name = "st-lpc-wdt";
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unsupported mode: %d\n", mode);
> +               return ret;
> +       }
> +
> +       /* Pass resources though to selected child device. */
> +       cell->resources = pdev->resource;
> +       cell->num_resources = pdev->num_resources;
> +
> +       ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> +                             cell, 1, NULL, 0, NULL);
> 

I don't think it's necessary to have the MFD node if only one of the
two modes can be used based on a DT property. It should be enough
to have both the rtc and the wdt driver list the same compatible
string and check the property in the probe function to decide if
they want to drive the device or not:

	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
	if (!ret && mode != ST_LPC_MODE_RTC)
		return -ENXIO


	Arnd
