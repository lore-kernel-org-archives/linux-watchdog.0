Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42478 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLHVjB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Dec 2018 16:39:01 -0500
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
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <eb86c5d7-ab13-df05-0d0f-9dad811a6a98@roeck-us.net>
Date: Sat, 8 Dec 2018 13:38:57 -0800
MIME-Version: 1.0
In-Reply-To: <20181207214528.GA2853@kunai>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/7/18 1:45 PM, Wolfram Sang wrote:
> Hi Guenter, all,
> 
>>> After discussing this mail thread [1] again, we concluded that giving
>>> userspace enough time to prepare is our favourite option. So, do not
>>> keep the time value when suspended but reset it when resuming.
>>>
>>> [1] https://patchwork.kernel.org/patch/10252209/
>>>
>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> Above exchange says it all, no need to repeat.
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks.
> 
> I can relate to the policy argument, though. Regardless of this patch, I
> wonder if we can make it configurable from userspace. A draft:
> 
> #define	WDIOF_RESUME_OPTS	0x0800
> 
> #define	WDIOS_RESUME_KEEP	0x0008
> #define	WDIOS_RESUME_RESET	0x0010
> 
> and then in watchdog_ioctl() under WDIOC_SETOPTIONS:
> 
> 	if (!(wdd->info->options & WDIOF_RESUME_OPTS))
> 		err = -EOPNOTSUPP;
> 		goto break;
> 
> 	if (val & WDIOS_RESUME_KEEP)
> 		wdd->status |= WDOG_KEEP_TIMER_WHEN_RESUME;
> 
> 	if (val & WDIOS_RESUME_RESET)
> 		wdd->status ~= ~WDOG_KEEP_TIMER_WHEN_RESUME;
> 
> So, drivers with WDIOF_RESUME_OPTS could act on the
> WDOG_KEEP_TIMER_WHEN_RESUME flag.
> 
> Opinions?
> 

Not entirely sure I understand the use case.

Having said that, if we were to add this option, I think only a single
flag would be needed - WDIOF_RESUME_KEEP. All we need to do is declare
that a ping on resume shall be the default. Anything else would result
in undefined per-driver default behavior.

Guenter
