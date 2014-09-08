Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45137 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaIHNbr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Sep 2014 09:31:47 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XQz2p-000AJz-1K
	for linux-watchdog@vger.kernel.org; Mon, 08 Sep 2014 13:31:47 +0000
Message-ID: <540DAFBC.1010502@roeck-us.net>
Date: Mon, 08 Sep 2014 06:31:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, wim@iguana.be, linux-watchdog@vger.kernel.org,
	David Paris <david.paris@st.com>
Subject: Re: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
References: <1409841592-18890-1-git-send-email-lee.jones@linaro.org> <1409841592-18890-6-git-send-email-lee.jones@linaro.org> <20140905155811.GA12374@roeck-us.net> <20140908123246.GB26284@lee--X1>
In-Reply-To: <20140908123246.GB26284@lee--X1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/08/2014 05:32 AM, Lee Jones wrote:
> On Fri, 05 Sep 2014, Guenter Roeck wrote:
...
>>> +
>>> +static struct st_wdog_syscfg stid127_syscfg = {
>>> +	.type_mask	= BIT(2),
>>> +	.enable_mask	= BIT(2),
>>> +};
>>> +
>>> +static struct st_wdog_syscfg stih415_syscfg = {
>>> +	.type_mask	= BIT(6),
>>> +	.enable_mask	= BIT(7),
>>> +};
>>> +
>>> +static struct st_wdog_syscfg stih416_syscfg = {
>>> +	.type_mask	= BIT(6),
>>> +	.enable_mask	= BIT(7),
>>> +};
>>> +
>>> +static struct st_wdog_syscfg stih407_syscfg = {
>>> +	.enable_mask	= BIT(19),
>>> +};
>>> +
...

>>> +	/* Mask/unmask watchdog reset */
>>> +	regmap_update_bits(st_wdog->syscfg->regmap,
>>> +			   st_wdog->syscfg->enable_reg,
>>> +			   st_wdog->syscfg->enable_mask,
>>> +			   !enable);
>>
>> enable is a bool, but is supposed to provide the value to be put into the
>> register, masked with enable_mask. Unless I am missing something, the value
>> is not shifted in regmap_update_bits. So I don't think this can work, but
>> effectively always writes zero into the mask unless the mask happens to be
>> at bit position 0 - which never happens.
>>
>> Same is true for warm_reset above, which also has values 0 or 1.
>>
>> I know it does not really matter in C (at least when it comes to handling
>> 0 and 1), but I would suggest to avoid mixing booleans with bit masks.
>
> You're right of course, great spot.
>
> How about?
>
>    !enable << ffs(st_wdog->syscfg->enable_mask).
>
Seems to add a lot of complexity (as in 'makes it difficult to understand')
to avoid a conditional, and assumes that enable_mask will never have more
than one bit set. I would go with
	enable ? st_wdog->syscfg->enable_mask : 0
to avoid confusion, but your call.

Guenter

