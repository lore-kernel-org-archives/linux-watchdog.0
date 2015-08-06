Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59216 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbbHFIFf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Aug 2015 04:05:35 -0400
Message-ID: <55C31547.2040207@roeck-us.net>
Date: Thu, 06 Aug 2015 01:05:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wenyou Yang <wenyou.yang@atmel.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: sylvain.rochet@finsecur.com, nicolas.ferre@atmel.com,
	boris.brezillon@free-electrons.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] drivers: watchdog: add a driver to support SAMA5D4
 watchdog timer
References: <1438837170-4518-1-git-send-email-wenyou.yang@atmel.com> <1438837170-4518-2-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1438837170-4518-2-git-send-email-wenyou.yang@atmel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/05/2015 09:59 PM, Wenyou Yang wrote:
>>From SAMA5D4, the watchdog timer is upgrated with a new feature,
> which is describled as in the datasheet, "WDT_MR can be written
> until a LOCKMR command is issued in WDT_CR".
> That is to say, as long as the bootstrap and u-boot don't issue
> a LOCKMR command, WDT_MR can be written more than once in the driver.
>
> So the SAMA5D4 watchdog driver's implementation is different from
> the at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
> The user application open the device file to enable the watchdog timer
> hardware, and close to disable it, and set the watchdog timer timeout
> by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
> by issuing WDRSTT command to WDT_CR register with hard-coded key.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
[ ... ]
> +
> +/* minimum and maximum watchdog timeout, in seconds */
> +#define	MIN_WDT_TIMEOUT		1
> +#define	MAX_WDT_TIMEOUT		16
> +#define	WDT_DEFAULT_TIMEOUT	MAX_WDT_TIMEOUT
> +
> +#define	WDT_SEC2TICKS(s)	((s) ? (((s) << 8) - 1) : 0)
> +

Why did you replace the spaces after #define with tabs ?
I understand this is done in the at91.h file, but that is bad enough,
it doesn't add any value, and I don't see a reason to do it here.

> +
> +	if ((wdt->config & AT91_WDT_WDFIEN) && irq) {
> +		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
> +				       0, pdev->name, pdev);

I just realized - this interrupt is registered with flags set to 0,
while in the at91sam driver the flags are "IRQF_SHARED | IRQF_IRQPOLL |
IRQF_NO_SUSPEND". Is this different with the new SOC ?

Thanks,
Guenter

