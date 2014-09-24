Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48682 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbaIXNbd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Sep 2014 09:31:33 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XWmfN-001X2z-4l
	for linux-watchdog@vger.kernel.org; Wed, 24 Sep 2014 13:31:33 +0000
Message-ID: <5422C78F.4020507@roeck-us.net>
Date: Wed, 24 Sep 2014 06:30:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v6] watchdog: Add DA9063 PMIC watchdog driver.
References: <1410184713-6436-1-git-send-email-mpa@pengutronix.de> <20140911163035.GA13969@roeck-us.net> <20140924091055.GB25366@pengutronix.de>
In-Reply-To: <20140924091055.GB25366@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/24/2014 02:10 AM, Markus Pargmann wrote:
> Hi,
>
> sorry for the late reply, I was on vacation.
>

No problem. Hope you had fun :-)

>>> +
>>> +static int da9063_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	struct da9063 *da9063;
>>> +	struct da9063_watchdog *wdt;
>>> +
>>> +	if (!pdev->dev.parent)
>>> +		return -EINVAL;
>>> +
>>> +	da9063 = dev_get_drvdata(pdev->dev.parent);
>>> +	if (!da9063)
>>> +		return -EINVAL;
>>> +
>>
>> This is not really an invalid argument. -ENODEV seems to be more appropriate,
>> given the context (presumably it means that there is no parent mfd device).
>
> Yes, but ENODEV will not result in a probe error message because the
> driver core assumes that the driver is not for this device. I would like
> to have a probe error message so that developers immediately see that
> something went wrong. This driver without a parent is a invalid setup,
> so I chose EINVAL.
> I prefer returning -EINVAL but as an alternative I could add an error
> message here and return ENODEV.
>

Good point. Given the context, one can argue that having no driver data _is_
an invalid argument (to the function), so I am fine with that.

Guenter

