Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47843 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaIXNYu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Sep 2014 09:24:50 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XWmYs-001Msg-48
	for linux-watchdog@vger.kernel.org; Wed, 24 Sep 2014 13:24:50 +0000
Message-ID: <5422C612.70906@roeck-us.net>
Date: Wed, 24 Sep 2014 06:24:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	Andreas Werner <andreas.werner@men.de>
CC: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, cooloney@gmail.com,
	rpurdie@rpsys.net, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 2/4] drivers/watchdog/menf21bmc_wdt: introduce MEN
 14F021P00 BMC Watchdog driver
References: <cover.1409161615.git.andreas.werner@men.de> <f21b275c79866e0aa9bbc59e195ae5424e538300.1409161615.git.andreas.werner@men.de> <20140924123548.GE32069@lee--X1>
In-Reply-To: <20140924123548.GE32069@lee--X1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/24/2014 05:35 AM, Lee Jones wrote:
> On Wed, 27 Aug 2014, Andreas Werner wrote:
>
>> Added driver to support the 14F021P00 BMC Watchdog.
>> The BMC is a Board Management Controller including watchdog functionality.
>>
>> Signed-off-by: Andreas Werner <andreas.werner@men.de>
>> ---
>>   drivers/watchdog/Kconfig         |  10 ++
>>   drivers/watchdog/Makefile        |   1 +
>>   drivers/watchdog/menf21bmc_wdt.c | 203 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 214 insertions(+)
>>   create mode 100644 drivers/watchdog/menf21bmc_wdt.c
>
> I see no reason to keep this dragging on.  I'm going to apply this
> along with the remainder of the set and send a pull-request to all the
> other Maintainers.  This branch is currently under test.
>
> Any fix-ups for review comments can go in subsequently.
>
Tend to agree. I thought I sent it before, but in case I didn't

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

[ for the watchdog driver ]

Guenter

