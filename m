Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33815 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbAVTbw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Jan 2015 14:31:52 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YENTs-000e6n-QI
	for linux-watchdog@vger.kernel.org; Thu, 22 Jan 2015 19:31:53 +0000
Message-ID: <54C15021.4060907@roeck-us.net>
Date: Thu, 22 Jan 2015 11:31:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	david.paris@st.com
Subject: Re: [PATCH v2 6/9] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org> <1421927767-28889-7-git-send-email-lee.jones@linaro.org> <54C12F10.4090901@roeck-us.net> <20150122172100.GF9129@x1>
In-Reply-To: <20150122172100.GF9129@x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2015 09:21 AM, Lee Jones wrote:
> On Thu, 22 Jan 2015, Guenter Roeck wrote:
>
>> On 01/22/2015 03:56 AM, Lee Jones wrote:
>>> Signed-off-by: David Paris <david.paris@st.com>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>   drivers/watchdog/Kconfig      |  13 ++
>>>   drivers/watchdog/Makefile     |   1 +
>>>   drivers/watchdog/st_lpc_wdt.c | 335 ++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 349 insertions(+)
>>>   create mode 100644 drivers/watchdog/st_lpc_wdt.c
>
> [...]
>
>>> +struct st_wdog_syscfg {
>>> +	struct regmap *regmap;
>>
>> Hi David & Lee,
>>
>> Why did you add the regmap pointer to this structure and not to st_wdog ?
>> It is not a configuration value, after all, and it is always dereferenced
>> through wt_wdog->syscfg. So all it does is to make the code more complicated.
>>
>> Am I missing something ?
>
> I guess it was just to group it all together, as it will all be used
> at the same time:
>
> 	regmap_update_bits(st_wdog->syscfg->regmap,
> 			   st_wdog->syscfg->reset_type_reg,
> 			   st_wdog->syscfg->reset_type_mask,
> 			   st_wdog->warm_reset);
>
> It really doesn't matter to me either way.
>
Having it in syscfg means it is stored in the static configuration data instead
of the allocated data, which is at least conceptually wrong. So I think it should
be in st_wdog.

Thanks,
Guenter

