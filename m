Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35806 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbERRTX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 13:19:23 -0400
Received: by obcus9 with SMTP id us9so133428129obc.2
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2015 10:19:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2464980.1PKdnqcc3c@wuerfel>
References: <=fu.wei@linaro.org>
	<1431689090-3125-1-git-send-email-fu.wei@linaro.org>
	<2464980.1PKdnqcc3c@wuerfel>
Date: Tue, 19 May 2015 01:19:22 +0800
Message-ID: <CADyBb7u=HjZO5CBzZLxw1aWDx0tKdVKBuTrrhrRF9bAQr7pADQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
From: Fu Wei <fu.wei@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
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
	Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Arnd,

Great thanks for your suggestion :-)

feedback inline below

On 15 May 2015 at 22:04, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 May 2015 19:24:48 fu.wei@linaro.org wrote:
>> +static void watchdog_check_min_max_pretimeout(struct watchdog_device *wdd)
>> +{
>> +       /*
>> +        * Check that we have valid min and max pretimeout values, if
>> +        * not reset them both to 0 (=not used or unknown)
>> +        */
>> +       if (wdd->min_pretimeout > wdd->max_pretimeout) {
>> +               pr_info("Invalid min and max pretimeout, resetting to 0!\n");
>> +               wdd->min_pretimeout = 0;
>> +               wdd->max_pretimeout = 0;
>> +       }
>> +}
>
> I would probably just fold this function into the existing
> watchdog_check_min_max_timeout() and check both normal and pre-timeout
> there.

yes, I can do that , and that is good idea

>
>> +/**
>> + * watchdog_init_pretimeout() - initialize the pretimeout field
>> + * @pretimeout_parm: pretimeout module parameter
>> + * @dev: Device that stores the timeout-sec property
>> + *
>> + * Initialize the pretimeout field of the watchdog_device struct with either
>> + * the pretimeout module parameter (if it is valid value) or the timeout-sec
>> + * property (only if it is a valid value and the timeout_parm is out of bounds).
>> + * If none of them are valid then we keep the old value (which should normally
>> + * be the default pretimeout value.
>> + *
>> + * A zero is returned on success and -EINVAL for failure.
>> + */
>> +int watchdog_init_pretimeout(struct watchdog_device *wdd,
>> +                            unsigned int pretimeout_parm, struct device *dev)
>> +{
>> +       int ret = 0;
>> +       u32 timeouts[2];
>> +
>> +       watchdog_check_min_max_pretimeout(wdd);
>> +
>> +       /* try to get the timeout module parameter first */
>> +       if (!watchdog_pretimeout_invalid(wdd, pretimeout_parm) &&
>> +           pretimeout_parm) {
>> +               wdd->pretimeout = pretimeout_parm;
>> +               return ret;
>> +       }
>> +       if (pretimeout_parm)
>> +               ret = -EINVAL;
>> +
>> +       /* try to get the timeout_sec property */
>> +       if (!dev || !dev->of_node)
>> +               return ret;
>> +       ret = of_property_read_u32_array(dev->of_node,
>> +                                        "timeout-sec", timeouts, 2);
>> +       if (!watchdog_pretimeout_invalid(wdd, timeouts[1]) && timeouts[1])
>> +               wdd->pretimeout = timeouts[1];
>> +       else
>> +               ret = -EINVAL;
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(watchdog_init_pretimeout);
>
> Same here: the function is very similar to the watchdog_init_timeout
> function, and it reads the same property, so just do both here.
>
> The easiest way for that is probably to use of_find_property()
> and of_prop_next_u32() to read the two numbers.

integrate watchdog_init_pretimeout and watchdog_init_timeout will be a
little hard,
we may need to change this API to :

watchdog_init_timeouts(struct watchdog_device *wdd, unsigned int timeout_parm,
                             unsigned int pretimeout_parm, struct device *dev)

then we need to update all the watchdog drivers which use this API,
maybe we can do this in a individual patchset, after this pretimeout
patch is merged.

Is that OK  ? :-)  any thought?


>
>         Arnd
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
