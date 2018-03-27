Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42447 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbeC0PeK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 11:34:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id a16so8991480pfn.9
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Mar 2018 08:34:09 -0700 (PDT)
Subject: Re: [PATCH] watchdog: core: add option to make timeouts read-only
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20180327080941.29235-1-marcus.folkesson@gmail.com>
 <20180327080941.29235-2-marcus.folkesson@gmail.com>
 <2e013403-7922-3309-3d17-0a9b757faa9c@roeck-us.net>
 <20180327111616.GA5286@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1bfcee8d-c213-547b-7495-f919521f32ca@roeck-us.net>
Date: Tue, 27 Mar 2018 08:34:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180327111616.GA5286@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/27/2018 04:17 AM, Marcus Folkesson wrote:
> On Tue, Mar 27, 2018 at 03:37:04AM -0700, Guenter Roeck wrote:
>> On 03/27/2018 01:09 AM, Marcus Folkesson wrote:
>>> Some systems may not allow applications to configure the watchdog
>>> timer at all. This restriction is not limited to stop the watchdog,
>>> but also change timeouts as well.
>>>
>>> This adds a kernel parameter to disable the ability to change the
>>> watchdog timouts from userspace.
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>
>> I don't believe that this would be a watchdog-only problem. Those users probably
> 
> It is not, and I agree that the whole requirement is a bit fuzzy.
> The requesters reference is a small system with a dedicaded MCU, and tries to
> apply the same requirements on a Linux system without really understand
> what it means.
> 
>> want lots of other things read-only. If they don't, and if this is really a watchdog
>> specific request, I don't think they know what they are talking about. Besides,
>> one can bypass it by unloading/reloading the drivers, so I don't really get the
>> point.
>>
>> Are the requesters of this feature aware that, with the permissions necessary
>> to change a watchdog timeout, it is possible to do lots of things, such as,
>> say, reboot the system ? Or cause a crash ? Is that less critical ?
> 
> It is not possible to login to these systems. The requirement is, what I
> can tell, only to restrict applications (which could be external)
> to modify the timeout. Reboots and systems crashes seems to be okay.
> 
> Strain out a gnat but swallow a camel, I know.
> 
>>
>> I would _really_ want to see a more detailed case made than "some users want it"
>> before agreeing to a change like this.
> 
> I guess my only case is "some users want it" for now.
> 
> The fact that I have seen such a formulated requirement in two
> independent projects made me submit it upstreams.
> 

Sorry, but this doesn't make any sense. Anyone who really wants to defeat such
a "security" mechanism can easily do it.

Just imagine the context. Changing the timeout must be done by the watchdog
daemon. If that can be modified, it was loaded from insecure storage. If it can not
be modified, its configuration was loaded from insecure storage. Both is _bad_.
On top of that, if it is possible to run insecure applications, those might as well
do direct i2c or mmio access and program the watchdog directly. In other words,
restricting the API to change the watchdog timeout does not improve system security
at all. At best it would hide its insecurity, and it would be a pure "feel good"
measure without any real value.

I would really like to see a complete security evaluation of the projects you
mention. They must be full of security holes, or they would not even think about
requesting something like this. Automotive, you said ? Outch.

> If I overlook the paranoid requirement, I think it could be useful to
> guarantee that the timeout set by bootloader (bootargs) or devicetree is
> the value that is used and not overridden.
> 
> But again, it is something that "some users may want".
> 

The simple answer to that is that they should not do it if they don't want it.
It does not make sense to define kernel configuration options for policy decisions
like this.

In summary, NACK.

Guenter

>>
>> Guenter
>>
> 
> Best regards
> Marcus Folkesson
> 
>>> ---
>>>    drivers/watchdog/Kconfig        |  9 +++++++++
>>>    drivers/watchdog/watchdog_dev.c | 12 ++++++++++--
>>>    2 files changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index aff773bcebdb..bcba48b5c88b 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -46,6 +46,15 @@ config WATCHDOG_NOWAYOUT
>>>    	  get killed. If you say Y here, the watchdog cannot be stopped once
>>>    	  it has been started.
>>> +config WATCHDOG_TIMEOUT_READONLY
>>> +	bool "Make timeouts read-only from userspace"
>>> +	help
>>> +	  Say Y here if you want the watchdog timeout/pretimeout to be read-only
>>> +	  from userspace. This requires that the timeout is configured before
>>> +	  userspace takes over.
>>> +
>>> +	  Say N if you are unsure.
>>> +
>>>    config WATCHDOG_HANDLE_BOOT_ENABLED
>>>    	bool "Update boot-enabled watchdog until userspace takes over"
>>>    	default y
>>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>>> index ffbdc4642ea5..6064806a2a8d 100644
>>> --- a/drivers/watchdog/watchdog_dev.c
>>> +++ b/drivers/watchdog/watchdog_dev.c
>>> @@ -87,6 +87,9 @@ static struct kthread_worker *watchdog_kworker;
>>>    static bool handle_boot_enabled =
>>>    	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
>>> +static bool timeout_is_readonly =
>>> +	IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY);
>>> +
>>>    static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>>>    {
>>>    	/* All variables in milli-seconds */
>>> @@ -359,7 +362,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>>>    {
>>>    	int err = 0;
>>> -	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
>>> +	if (!(wdd->info->options & WDIOF_SETTIMEOUT) || timeout_is_readonly)
>>>    		return -EOPNOTSUPP;
>>>    	if (watchdog_timeout_invalid(wdd, timeout))
>>> @@ -390,7 +393,7 @@ static int watchdog_set_pretimeout(struct watchdog_device *wdd,
>>>    {
>>>    	int err = 0;
>>> -	if (!(wdd->info->options & WDIOF_PRETIMEOUT))
>>> +	if (!(wdd->info->options & WDIOF_PRETIMEOUT) || timeout_is_readonly)
>>>    		return -EOPNOTSUPP;
>>>    	if (watchdog_pretimeout_invalid(wdd, timeout))
>>> @@ -1181,3 +1184,8 @@ module_param(handle_boot_enabled, bool, 0444);
>>>    MODULE_PARM_DESC(handle_boot_enabled,
>>>    	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
>>>    	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
>>> +
>>> +module_param(timeout_is_readonly, bool, 0444);
>>> +MODULE_PARM_DESC(timeout_is_readonly,
>>> +	"Watchdog timeouts is readonly from userspace (default="
>>> +	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY)) ")");
>>>
>>

