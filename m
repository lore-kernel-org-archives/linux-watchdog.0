Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:44969 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbbKXN22 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 08:28:28 -0500
Subject: Re: [PATCH 6/6] watchdog: pretimeout: add ping watchdog pretimeout
 governor
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1448089910-11453-7-git-send-email-vladimir_zapolskiy@mentor.com>
 <56540567.1020803@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <565465A5.7090004@mentor.com>
Date: Tue, 24 Nov 2015 15:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <56540567.1020803@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24.11.2015 08:36, Guenter Roeck wrote:
> On 11/20/2015 11:11 PM, Vladimir Zapolskiy wrote:
>> Ping watchdog pretimeout governor, on watchdog pretimeout event ping
>> watchdog device. Use this watchdog pretimeout governor with caution,
>> it may humiliate watchdog work, however it may be helpful in some
>> particular situations, for instance if once started watchdog can not
>> be stopped, but reboot caused by the watchdog is undesired.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>>   drivers/watchdog/Kconfig           | 16 +++++++++++++
>>   drivers/watchdog/Makefile          |  1 +
>>   drivers/watchdog/pretimeout_ping.c | 48 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 65 insertions(+)
>>   create mode 100644 drivers/watchdog/pretimeout_ping.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 6c1f7e1..cb0885a 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1669,6 +1669,12 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_DEVICE
>>   	  Use device specific watchdog pretimeout event handler
>>   	  by default.
>>
>> +config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PING
>> +	bool "ping"
>> +	select WATCHDOG_PRETIMEOUT_GOV_PING
>> +	help
>> +	  Use ping watchdog pretimeout event handler by default.
>> +
>>   endchoice
>>
>>   config WATCHDOG_PRETIMEOUT_GOV_NOOP
>> @@ -1698,6 +1704,16 @@ config WATCHDOG_PRETIMEOUT_GOV_DEVICE
>>   	  does nothing, if watchdog driver does not define a pretimeout
>>   	  callback.
>>
>> +config WATCHDOG_PRETIMEOUT_GOV_PING
>> +	tristate "Ping watchdog pretimeout governor"
>> +	help
>> +	  Ping watchdog pretimeout governor, on watchdog pretimeout
>> +	  event ping watchdog device. Use this watchdog pretimeout
>> +	  governor with caution, it may humiliate watchdog work,
>> +	  however it may be helpful in some particular situations,
>> +	  for instance if once started watchdog can not be stopped,
>> +	  but reboot caused by the watchdog is undesired.
>> +
> 
> This one will be unnecessary once the pending infrastructure enhancements
> are accepted. The watchdog core will then handle the ping.
> I don't think this should be left to user space, as it _would_ defeat
> the watchdog's purpose if the watchdog application fails to ping
> the watchdog.
> 

Ok, I'll drop it.

--
With best wishes,
Vladimir
