Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55696 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbHDQnn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Aug 2015 12:43:43 -0400
Message-ID: <55C0EBBB.7040002@roeck-us.net>
Date: Tue, 04 Aug 2015 09:43:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/8] watchdog: Make set_timeout function optional
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <1438654414-29259-5-git-send-email-linux@roeck-us.net> <20150804153823.GS9999@pengutronix.de>
In-Reply-To: <20150804153823.GS9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/04/2015 08:38 AM, Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Aug 03, 2015 at 07:13:30PM -0700, Guenter Roeck wrote:
>> For some watchdogs, the hardware timeout is fixed, and the
>> watchdog driver depends on the watchdog core to handle the
>> actual timeout. In this situation, the watchdog driver might
>> only set the 'timeout' variable but do nothing else.
>> This can as well be handled by the infrastructure, so make
>> the set_timeout callback optional. If WDIOF_SETTIMEOUT is
>> configured but the .set_timeout callback is not available,
>> update the timeout variable in the infrastructure code.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/watchdog/watchdog-kernel-api.txt | 4 ++++
>>   drivers/watchdog/watchdog_dev.c                | 9 ++++++---
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
>> index 7fda3c86cf46..2f1a4ad7e565 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -178,6 +178,10 @@ they are supported. These optional routines/operations are:
>>     because the watchdog does not necessarily has a 1 second resolution).
>>     (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>>     watchdog's info structure).
>> +  If the watchdog driver does not have to perform any action but setting the
>> +  timeout value of the watchdog_device, this callback can be omitted.
>> +  If set_timeout is not provided but WDIOF_SETTIMEOUT is set, the watchdog
>> +  infrastructure updates the timeout value of the watchdog_device internally.
> What is the semantic of struct watchdog_device.timeout? Is it the
> corrently configured hw-timeout? Or what userspace sees? In the former
> case timeout shouldn't be updated. And in the latter case it's wrong
> that the worker thread uses this member to determine the needed rate for
> it's auto pinging.
>

.timeout is what user-space sees, but it is also what may be configured
into the hardware, depending on the value of max_hw_timeout and on the driver.

For example, if timeout = 5s and max_hw_timeout = 6000ms, the driver would (or might)
configure the _current_ hardware timeout to 5s. The worker would not be activated.
If, on the other side, timeout = 10s and max_hw_timeout = 6000ms, the driver would
configure the hardware timeout to 6s, the worker would send a heartbeat every
3 seconds, and user space would be expected to send a heartbeat every 5 seconds
or so (assuming it uses timeout/2 to determine when to send heartbeats).

Thanks,
Guenter

