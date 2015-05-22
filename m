Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34158 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbEVFRt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 01:17:49 -0400
Received: by oige141 with SMTP id e141so6209654oig.1
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 22:17:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150521153225.GA17441@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-6-git-send-email-fu.wei@linaro.org>
	<20150521153225.GA17441@roeck-us.net>
Date: Fri, 22 May 2015 13:17:48 +0800
Message-ID: <CADyBb7vwMcL=7Jszv-dPwYEygwDGXzH1HDSs6V=thwTCYQzSeA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,


On 21 May 2015 at 23:32, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, May 21, 2015 at 04:32:34PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Also update Documentation/watchdog/watchdog-kernel-api.txt to
>> introduce:
>> (1)the new elements in the watchdog_device and watchdog_ops struct;
>> (2)the new API "watchdog_init_timeouts".
>>
>> Reasons:
>> (1)kernel already has two watchdog drivers are using "pretimeout":
>>       drivers/char/ipmi/ipmi_watchdog.c
>>       drivers/watchdog/kempld_wdt.c(but the definition is different)
>> (2)some other dirvers are going to use this: ARM SBSA Generic Watchdog
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>
> [ ... ]
>
>>
>> +/* Use the following function to check if a pretimeout value is invalid */
>> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
>> +                                            unsigned int t)
>> +{
>> +     return ((wdd->max_pretimeout != 0) &&
>> +             (t < wdd->min_pretimeout || t > wdd->max_pretimeout));
>> +}
>
> Should this function also enforce "t < wdd->timeout", and
> should watchdog_timeout_invalid() enforce "t > wdd->pretimeout" ?

yes, you are right , thanks for the correction !! :-)

>
> Thanks,
> Guenter



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
