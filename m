Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34855 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbbEUKFc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 06:05:32 -0400
Received: by oihd6 with SMTP id d6so13578774oih.2
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 03:05:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555D9FA8.9060106@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-6-git-send-email-fu.wei@linaro.org>
	<555D9FA8.9060106@roeck-us.net>
Date: Thu, 21 May 2015 18:05:31 +0800
Message-ID: <CADyBb7vKgnij6d+akVo1cQmrO4s67BBCr1HPr3n+Z4G0W-KqgA@mail.gmail.com>
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
	"mark.rutland" <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Thanks for review. :-)
feedback inline below

On 21 May 2015 at 17:04, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/21/2015 01:32 AM, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Also update Documentation/watchdog/watchdog-kernel-api.txt to
>> introduce:
>> (1)the new elements in the watchdog_device and watchdog_ops struct;
>> (2)the new API "watchdog_init_timeouts".
>>
>> Reasons:
>> (1)kernel already has two watchdog drivers are using "pretimeout":
>>         drivers/char/ipmi/ipmi_watchdog.c
>>         drivers/watchdog/kempld_wdt.c(but the definition is different)
>> (2)some other dirvers are going to use this: ARM SBSA Generic Watchdog
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>
>
> [ ... ]
>
>> +extern int watchdog_init_timeouts(struct watchdog_device *wdd,
>> +                                  unsigned int pretimeout_parm,
>> +                                  unsigned int timeout_parm,
>> +                                  void (*update_limits)(struct
>> watchdog_device *),
>> +                                  struct device *dev);
>>
>> -The watchdog_init_timeout function allows you to initialize the timeout
>> field
>> -using the module timeout parameter or by retrieving the timeout-sec
>> property from
>> -the device tree (if the module timeout parameter is invalid). Best
>> practice is
>> -to set the default timeout value as timeout value in the watchdog_device
>> and
>> -then use this function to set the user "preferred" timeout value.
>> +The watchdog_init_timeouts function allows you to initialize the
>> pretimeout and
>> +timeout fields using the module pretimeout and timeout parameter or by
>> +retrieving the elements in the timeout-sec property(the first element is
>> for
>> +timeout, the second one is for pretimeout) from the device tree(if the
>> module
>> +pretimeout and timeout parameter are invalid).
>> +Normally, the pretimeout value will affect the limitation of timeout, and
>> it
>> +is also hardware related. So you can write a function in your driver to
>> update
>> +the limitation of timeout, according to the pretimeout value. Then pass
>> the
>> +function pointer by the update_limits parameter. If you driver doesn't
>> +need this adjustment, just pass NULL to the update_limits parameter.
>
>
> You've lost me a bit with the update_limits function.
> watchdog_init_timeouts()
> is called from the driver.

yes, that is the help function which will be called from watchdog
driver, like SBSA watchdog driver

> Why should the function have to call back into
> the
> driver to update the parameters which are passed from the driver ?

Let me explain this, please correct me if I misunderstand something.
According to the concept of "pretimeout" in kernel, the timeout
contains the pretimeout, like

 * Kernel/API:                         P---------| pretimeout
 *                      |-------------------------------T timeout

If you set up the value of pretimeout, that means pretimeout
<min_timeout < timeout < max_timeout < (pretimeout +
max_timeout_for_1th_stage)
For  min_timeout > pretimeout.  if some one setup a timeout like :
pretimeout >  timeout > min_timeout, I think that could be a problem
For  max_timeout < (pretimeout + max_timeout_for_1th_stage),  if some
one setup a timeout like (pretimeout + max_timeout_for_1th_stage) <
timeout >  max_timeout .

I have explained a little in doc, but the adjustment may have
something to do with hardware, like  max_timeout_for_1th_stage(in SBSA
watchdog , limited by WCV)

maybe this problem wouldn't happen ,if you set up  max_timeout to a
small number. so you can pass NULL to the pointer.
 but I think maybe for other device , that may happen.

> Seems to me the driver can do that calculation first, then call
> watchdog_init_timeouts() with the result. Am I missing something ?

maybe I am overthinking it :-)
please correct me

>
> Thanks,
> Guenter
>



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
