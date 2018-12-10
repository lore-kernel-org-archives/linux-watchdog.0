Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33442 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeLJOXq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Dec 2018 09:23:46 -0500
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
 <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
 <20181207214528.GA2853@kunai>
 <eb86c5d7-ab13-df05-0d0f-9dad811a6a98@roeck-us.net>
 <20181209163632.GB1673@kunai>
 <df16092e-f0f6-c085-3daf-303e1cb06428@roeck-us.net>
 <TY1PR01MB17704475D482D7A0B5B9D232C0A50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a9802cbe-b050-1f3c-f35f-b9b691f9d32b@roeck-us.net>
Date: Mon, 10 Dec 2018 06:23:42 -0800
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB17704475D482D7A0B5B9D232C0A50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/10/18 1:37 AM, Fabrizio Castro wrote:
> Hello Guenter,
> 
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: 09 December 2018 18:13
>> Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during suspend/resume
>>
>> On 12/9/18 8:36 AM, Wolfram Sang wrote:
>>> Hi Guenter,
>>>
>>>>> I can relate to the policy argument, though. Regardless of this patch, I
>>>>> wonder if we can make it configurable from userspace. A draft:
>>>>>
>>>>> #defineWDIOF_RESUME_OPTS0x0800
>>>>>
>>>>> #defineWDIOS_RESUME_KEEP0x0008
>>>>> #defineWDIOS_RESUME_RESET0x0010
>>>>>
>>>>> and then in watchdog_ioctl() under WDIOC_SETOPTIONS:
>>>>>
>>>>> if (!(wdd->info->options & WDIOF_RESUME_OPTS))
>>>>> err = -EOPNOTSUPP;
>>>>> goto break;
>>>>>
>>>>> if (val & WDIOS_RESUME_KEEP)
>>>>> wdd->status |= WDOG_KEEP_TIMER_WHEN_RESUME;
>>>>>
>>>>> if (val & WDIOS_RESUME_RESET)
>>>>> wdd->status ~= ~WDOG_KEEP_TIMER_WHEN_RESUME;
>>>>>
>>>>> So, drivers with WDIOF_RESUME_OPTS could act on the
>>>>> WDOG_KEEP_TIMER_WHEN_RESUME flag.
>>>>>
>>>>> Opinions?
>>>>>
>>>>
>>>> Not entirely sure I understand the use case.
>>>
>>> Well, as I mentioned before, I can understand the "isn't this policy?"
>>> question from Fabrizio. Would be good to hear his opinion on this.
>>>
>> I understand, but what is the use case behind it ? If the watchdog
> 
> Is there a documented use case for resetting the counter at resume? I don't
> think the documentation is clear about this, therefore we need to think ahead
> 
>> was close to expire on suspend, we want it to expire for good on resume ?
> 
> That decision is up to user space, isn't it? The decision to go to sleep comes from
> user space, therefore user space should consider the time left on the counter before
> going to sleep (or ask the system to ping the watchdog at resume), and do what's
> best for the health of the system, from kernel space we don't know if the user application
> is behaving as expected or not, therefore we don't know what's best for the system.
> Why don't we let user space decide?
> I guess Wolfram proposal goes in the right direction?
> 
>> Make the watchdog during a suspend/resume cycle more stringent that during
>> normal operation, effectively letting it expire early (or earlier) ?
> 
> As the decision to go to sleep comes from user space, I don't think we can say that
> letting the watchdog expire on resume is more stringent (or unfair) than during
> normal operation, if the system is healthy user space should consider the delay
> introduced by going to sleep and waking up and it should make sure that there is
> enough time left on the watchdog timer before asking the system to go to sleep.
> 

Should it ? Does it ? Is there any watchdog daemon out there which sends a final
ping to the watchdog just before suspend or immediately after resume ?

>>
>> I'd rather clarify in the documentation that watchdog drivers are expected
>> to ping the watchdog after resume, ie that restarting the watchdog after
>> resume should be handled like starting the watchdog.
> 
> Let me understand this a little bit better, if you have a use case where you don't
> want to automatically ping the watchdog at resume you can't go to sleep?
> 

Yes, the normal use case. The point of a watchdog is to recover from a fatal
system failure. For a normal use of a watchdog, especially one that involves
suspend/resume and is thus not time critical, that behavior should be relaxed,
not stringent, and under no circumstances should result in an unnecessary /
unexpected system reboot.

>>
>>>> Having said that, if we were to add this option, I think only a single
>>>> flag would be needed - WDIOF_RESUME_KEEP. All we need to do is declare
>>>> that a ping on resume shall be the default. Anything else would result
>>>> in undefined per-driver default behavior.
>>>
>>> I would very much love that. To be honest, I thought we already are in
>>> the undefined per-driver behaviour; this is why I added two flags, to
>>> not cause regressions. Declaring a default would be a great first step
> 
> I agree with Wolfram, to me it looks like this is undefined per-driver
> behaviour already
> 

Point well made, but that is primarily a documentation deficiency: If the
expected behavior was well documented, we would not have this argument.

At this point I would be happy to accept a patch clarifying the documentation.
Unless I get guidance from Wim suggesting otherwise, going forward I won't
accept any watchdog drivers which do not implement resetting the timer on
resume.

Thanks,
Guenter
