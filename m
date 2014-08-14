Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61980 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134AbaHNPkQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Aug 2014 11:40:16 -0400
Message-ID: <53ECD85A.8050903@roeck-us.net>
Date: Thu, 14 Aug 2014 08:40:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de> <53EC487E.2000602@roeck-us.net> <20140814095733.GG17027@pengutronix.de>
In-Reply-To: <20140814095733.GG17027@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/14/2014 02:57 AM, Markus Pargmann wrote:

>>> +
>>> +static int da9063_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
>>> +	struct da9063_watchdog *wdt;
>>> +
>>> +	if (!da9063)
>>> +		return -EPROBE_DEFER;
>>
>> Can this ever happen ? Isn't this driver instantiated from its parent,
>> which would ensure that the parent's driver data is set ?
>
> No this can't happen. I replaced it with BUG_ON and also introduced a
> BUG_ON check for dev.parent.
>
That is a bit too much. You should only use BUG_ON if the kernel can not
continue to run, which should not be the case here. I would suggest
to return -ENODEV.

Guenter

