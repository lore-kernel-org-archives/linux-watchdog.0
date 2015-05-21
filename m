Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35233 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbEUJBC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 05:01:02 -0400
Received: by obcus9 with SMTP id us9so55701149obc.2
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 02:01:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4405999.8GGyzVsbM7@wuerfel>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<4405999.8GGyzVsbM7@wuerfel>
Date: Thu, 21 May 2015 17:01:01 +0800
Message-ID: <CADyBb7sOrbMGhbstaPF25kJJ=BQmctf31Fb6wf7nwgsL5teuvQ@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v2 0/7] Watchdog: introduce ARM SBSA
 watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Jon Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Timur Tabi <timur@codeaurora.org>, wim@iguana.be,
	Wei Fu <tekkamanninja@gmail.com>, vgandhi@codeaurora.org,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Arnd,

Great thanks for your review! :-)

On 21 May 2015 at 16:46, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 May 2015 16:32:29 fu.wei@linaro.org wrote:
>>
>> This patchset:
>>
>>     (1)Export "arch_timer_get_rate" in arm_arch_timer.c for the
>>     other drivers, like SBSA watchdog driver
>>
>>     (2)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>>     for FDT info of SBSA Generic Watchdog, and give two examples of
>>     adding SBSA Generic Watchdog device node into the dts files:
>>     foundation-v8.dts and amd-seattle-soc.dtsi.
>>
>>     (3)Introduce "pretimeout" into the watchdog framework, and update
>>     Documentation/watchdog/watchdog-kernel-api.txt to introduce:
>>         (1)the new elements in the watchdog_device and watchdog_ops struct;
>>         (2)the new API "watchdog_init_timeouts".
>>
>>     (4)Introduce ARM SBSA watchdog driver:
>>         a.Use linux kernel watchdog framework;
>>         b.Work with FDT on ARM64;
>>         c.Use "pretimeout" in watchdog framework;
>>         d.In first timeout(WS0), do panic to save system context;
>>         e.Support geting timeout and pretimeout from parameter and FDT
>>           at the driver init stage.
>
> Looks all good to me, please add
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> for patches 1-6.

Great! happy to do so :-)

>
>>     (5)Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>>     and create a platform device with that information.
>>     This platform device can be used by This Watchdog driver.
>
> This needs to be reviewed by someone who understands ACPI.

yes, maybe Hanjun and Al can help :-)

>
>         Arnd



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
