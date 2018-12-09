Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41295 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLISMr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Dec 2018 13:12:47 -0500
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
 <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
 <20181207214528.GA2853@kunai>
 <eb86c5d7-ab13-df05-0d0f-9dad811a6a98@roeck-us.net>
 <20181209163632.GB1673@kunai>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <df16092e-f0f6-c085-3daf-303e1cb06428@roeck-us.net>
Date: Sun, 9 Dec 2018 10:12:44 -0800
MIME-Version: 1.0
In-Reply-To: <20181209163632.GB1673@kunai>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/9/18 8:36 AM, Wolfram Sang wrote:
> Hi Guenter,
> 
>>> I can relate to the policy argument, though. Regardless of this patch, I
>>> wonder if we can make it configurable from userspace. A draft:
>>>
>>> #define	WDIOF_RESUME_OPTS	0x0800
>>>
>>> #define	WDIOS_RESUME_KEEP	0x0008
>>> #define	WDIOS_RESUME_RESET	0x0010
>>>
>>> and then in watchdog_ioctl() under WDIOC_SETOPTIONS:
>>>
>>> 	if (!(wdd->info->options & WDIOF_RESUME_OPTS))
>>> 		err = -EOPNOTSUPP;
>>> 		goto break;
>>>
>>> 	if (val & WDIOS_RESUME_KEEP)
>>> 		wdd->status |= WDOG_KEEP_TIMER_WHEN_RESUME;
>>>
>>> 	if (val & WDIOS_RESUME_RESET)
>>> 		wdd->status ~= ~WDOG_KEEP_TIMER_WHEN_RESUME;
>>>
>>> So, drivers with WDIOF_RESUME_OPTS could act on the
>>> WDOG_KEEP_TIMER_WHEN_RESUME flag.
>>>
>>> Opinions?
>>>
>>
>> Not entirely sure I understand the use case.
> 
> Well, as I mentioned before, I can understand the "isn't this policy?"
> question from Fabrizio. Would be good to hear his opinion on this.
> 
I understand, but what is the use case behind it ? If the watchdog
was close to expire on suspend, we want it to expire for good on resume ?
Make the watchdog during a suspend/resume cycle more stringent that during
normal operation, effectively letting it expire early (or earlier) ?

I'd rather clarify in the documentation that watchdog drivers are expected
to ping the watchdog after resume, ie that restarting the watchdog after
resume should be handled like starting the watchdog.

>> Having said that, if we were to add this option, I think only a single
>> flag would be needed - WDIOF_RESUME_KEEP. All we need to do is declare
>> that a ping on resume shall be the default. Anything else would result
>> in undefined per-driver default behavior.
> 
> I would very much love that. To be honest, I thought we already are in
> the undefined per-driver behaviour; this is why I added two flags, to
> not cause regressions. Declaring a default would be a great first step

How would adding two flag bits (or one, for that matter) change the
current (undefined) behavior ?
Also, what exactly would be the regression ? Existing drivers would
not change their behavior, neither with one or two or three flag bits.

Thanks,
Guenter

> IMHO, and then we can build the WDIOF_RESUME_KEEP option on top of it,
> if needed. But for clarity, the first step seems to be a good idea in
> any case, I'd say.
>  > Thanks,
> 
>     Wolfram
> 
> 
