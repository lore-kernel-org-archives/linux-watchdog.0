Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59020 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966073AbcAZOmF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 09:42:05 -0500
Subject: Re: [PATCH v7 4/9] watchdog: Add support for minimum time between
 heartbeats
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	Guenter Roeck <patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
 <1453776796-3885-5-git-send-email-patchwork@patchwork.roeck-us.net>
 <20160126080740.GU3338@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A785B8.8080601@roeck-us.net>
Date: Tue, 26 Jan 2016 06:42:00 -0800
MIME-Version: 1.0
In-Reply-To: <20160126080740.GU3338@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 01/26/2016 12:07 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Mon, Jan 25, 2016 at 06:53:11PM -0800, Guenter Roeck wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>>
>> Some watchdogs require a minimum time between heartbeats.
>> Examples are the watchdogs in DA9062 and AT91SAM9x.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v7: Rebased to v4.5-rc1
>> v6: Rebased to v4.4-rc2
>> v5: Rebased to v4.4-rc1
>>      Fixed typo in documentation.
>> v4: Added patch
>> ---
>>   Documentation/watchdog/watchdog-kernel-api.txt |  3 +++
>>   drivers/watchdog/watchdog_dev.c                | 15 +++++++++++++++
>>   include/linux/watchdog.h                       |  3 +++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
>> index 62d49d6a7ff5..2221fb4f2739 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -52,6 +52,7 @@ struct watchdog_device {
>>   	unsigned int timeout;
>>   	unsigned int min_timeout;
>>   	unsigned int max_timeout;
>> +	unsigned int min_hw_heartbeat_ms;
>>   	unsigned int max_hw_timeout_ms;
>>   	struct notifier_block reboot_nb;
>>   	struct notifier_block restart_nb;
>> @@ -81,6 +82,8 @@ It contains following fields:
>>   * max_timeout: the watchdog timer's maximum timeout value (in seconds),
>>     as seen from userspace. If set, the maximum configurable value for
>>     'timeout'. Not used if max_hw_timeout_ms is non-zero.
>> +* min_hw_heartbeat_ms: Minimum time between heartbeats sent to the chip,
>> +  in milli-seconds.
>>   * max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds.
>>     If set, the infrastructure will send heartbeats to the watchdog driver
>>     if 'timeout' is larger than max_hw_timeout_ms, unless WDOG_ACTIVE
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index 1a8f3861fe92..ff03cbc8e081 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -64,6 +64,7 @@ struct watchdog_core_data {
>>   	struct watchdog_device *wdd;
>>   	struct mutex lock;
>>   	unsigned long last_keepalive;
>> +	unsigned long last_hw_keepalive;
>>   	struct delayed_work work;
>>   	unsigned long status;		/* Internal status bits */
>>   #define _WDOG_DEV_OPEN		0	/* Opened ? */
>> @@ -138,8 +139,19 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd,
>>
>>   static int __watchdog_ping(struct watchdog_device *wdd)
>>   {
>> +	struct watchdog_core_data *wd_data = wdd->wd_data;
>> +	unsigned long earliest_keepalive = wd_data->last_hw_keepalive +
>> +				msecs_to_jiffies(wdd->min_hw_heartbeat_ms);
>>   	int err;
>>
>> +	if (time_is_after_jiffies(earliest_keepalive)) {
>> +		mod_delayed_work(watchdog_wq, &wd_data->work,
>> +				 earliest_keepalive - jiffies);
>> +		return 0;
>> +	}
>> +
>> +	wd_data->last_hw_keepalive = jiffies;
>> +
>
> Do you need to undo this assignment when ping fails?
>

I thought about it, but decided against it. I concluded that it is better
in this situation to only try again after the minimum delay between
heartbeats.

Thanks,
Guenter

