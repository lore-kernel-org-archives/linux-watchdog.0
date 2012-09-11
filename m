Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp175.iad.emailsrvr.com ([207.97.245.175]:56106 "EHLO
	smtp175.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab2IKFuW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Sep 2012 01:50:22 -0400
Message-ID: <504ED10F.7090008@jollamobile.com>
Date: Tue, 11 Sep 2012 08:50:07 +0300
From: Jarkko Nikula <jarkko.nikula@jollamobile.com>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH] watchdog: Convert twl4030_wdt to watchdog core
References: <1347291886-15218-1-git-send-email-jarkko.nikula@jollamobile.com> <20120910215946.GB26184@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20120910215946.GB26184@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Thanks Aaro!

On 09/11/2012 12:59 AM, Aaro Koskinen wrote:
> On Mon, Sep 10, 2012 at 06:44:46PM +0300, Jarkko Nikula wrote:
>> Convert the twl4030_wdt watchdog driver to watchdog core.
>>
>> While at there use devm_kzalloc and set the default timeout in order to be
>> able test this driver with a simple shell script.
>>
>> Signed-off-by: Jarkko Nikula<jarkko.nikula@jollamobile.com>
>> ---
>>   drivers/watchdog/Kconfig       |    1 +
>>   drivers/watchdog/twl4030_wdt.c |  183 ++++++++--------------------------------
>>   2 files changed, 35 insertions(+), 149 deletions(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 53d7571..21f6205 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -232,6 +232,7 @@ config EP93XX_WATCHDOG
>>   config OMAP_WATCHDOG
>>   	tristate "OMAP Watchdog"
>>   	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
>> +	select WATCHDOG_CORE
> This should be under TWL4030_WATCHDOG.
Grr.. leftover from testing your patch and accidentally dropping my 
change :-)

I'll fix this, add your Tested-by and repost.

-- 
Jarkko
