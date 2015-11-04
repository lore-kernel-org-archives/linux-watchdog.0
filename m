Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42053 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbKDQFv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Nov 2015 11:05:51 -0500
Subject: Re: [PATCH v2 2/2] watchdog: imx2_wdt: add set_pretimeout interface
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>, wim@iguana.be
References: <1446531084-15365-1-git-send-email-b38343@freescale.com>
 <1446531084-15365-2-git-send-email-b38343@freescale.com>
 <563A2849.5040707@mentor.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563A2CDB.7090101@roeck-us.net>
Date: Wed, 4 Nov 2015 08:05:47 -0800
MIME-Version: 1.0
In-Reply-To: <563A2849.5040707@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/04/2015 07:46 AM, Vladimir Zapolskiy wrote:
> Hi Robin,
>
> On 03.11.2015 08:11, Robin Gong wrote:
>> Enable set_pretimeout interface and trigger the pretimeout interrupt before
>> watchdog timeout event happen.
>>
>> Signed-off-by: Robin Gong <b38343@freescale.com>
>> ---
>
> [snip]
>
>> +
>> +static irqreturn_t imx2_wdt_isr(int irq, void *dev_id)
>> +{
>> +	struct platform_device *pdev = dev_id;
>> +	struct watchdog_device *wdog = platform_get_drvdata(pdev);
>> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>> +	u32 val;
>> +
>> +	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
>> +	if (val & IMX2_WDT_WICR_WTIS) {
>> +		/*clear interrupt status bit*/
>> +		regmap_write(wdev->regmap, IMX2_WDT_WICR, val);
>> +		panic("pre-timeout:%d, %d Seconds remained\n", wdog->pretimeout,
>> +		      wdog->timeout - wdog->pretimeout);
>
> I don't think it is a good idea to panic on pretimeout interrupt, for
> instance pretimeout interrupt may be used for any other purposes - ping
> watchdog, dump some system information before reboot and so on.
>
> In general I am even not completely convinced that the pretimeout interrupt
> handler should be placed in the driver, it may happen that there are some
> users outside, who wants to get this interrupt and act according to the event.
>

Ah yes, this is one of the reasons why adding this functionality into the
watchdog core keeps going nowhere. Some of the people involved absolutely
insist that a watchdog pretimeout should result in a panic, others are just
as strongly opposed to it. At the end, there is no consensus, and we end up
doing nothing, since nothing is better than each driver behaving differently.

Just like politics, I guess :-(.

Guenter

