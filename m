Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.augenpunkt.de ([213.239.207.9]:57206 "EHLO
	www.augenpunkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbFLLve (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Jun 2015 07:51:34 -0400
Message-ID: <557AC203.6060600@lategoodbye.de>
Date: Fri, 12 Jun 2015 13:26:59 +0200
From: Stefan Wahren <info@lategoodbye.de>
MIME-Version: 1.0
To: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>,
	linux-arm-kernel@lists.infradead.org
CC: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] watchdog: bcm2835: Add poweroff code for the Raspberry
 Pi
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org> <1433845305-17329-2-git-send-email-noralf@tronnes.org>
In-Reply-To: <1433845305-17329-2-git-send-email-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Noralf,

Am 09.06.2015 um 12:21 schrieb Noralf Trønnes:
> This adds a new poweroff function to the watchdog driver for the
> Raspberry Pi. Currently poweroff/halt results in a reboot.
>
> [...]
>
> +static void rpi_power_off(void)
> +{
> +	struct device_node *np =
> +		of_find_compatible_node(NULL, NULL, "brcm,raspberrypi-pm-wdt");
> +	struct platform_device *pdev = of_find_device_by_node(np);
> +	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
> +	u32 val;
> +
> +	val = readl_relaxed(wdt->base + PM_RSTS);

do you think it's safe here to assume wdt could never be NULL?

May be it's necessary to send the series to the watchdog / bcm2835 
maintainers to get more feedback.

Regards
Stefan

