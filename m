Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33603 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbbI3RW5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Sep 2015 13:22:57 -0400
Received: by oixx17 with SMTP id x17so26298710oix.0
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2015 10:22:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150930171338.GC15745@dhcppc0.redhat.com>
References: <=fu.wei@linaro.org>
	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>
	<20150930171338.GC15745@dhcppc0.redhat.com>
Date: Wed, 30 Sep 2015 13:22:56 -0400
Message-ID: <CADyBb7tS+_6nSLdiOB0ohrzqiPyc0aBkO=b3Uq+pyGMy_m=ALg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Pratyush,

Great thanks for your testing, this info is very helpful. :-)
my new patchset will come out soon.

On 30 September 2015 at 13:13, Pratyush Anand <panand@redhat.com> wrote:
> Hi Fu Wei,
>
> On 25/08/2015:01:01:15 AM, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>>     for FDT info of SBSA Generic Watchdog, and give two examples of
>>     adding SBSA Generic Watchdog device node into the dts files:
>>     foundation-v8.dts and amd-seattle-soc.dtsi.
>>
>>     (2)Introduce "pretimeout" into the watchdog framework, and update
>>     Documentation/watchdog/watchdog-kernel-api.txt to introduce:
>>         (1)the new elements in the watchdog_device and watchdog_ops struct;
>>         (2)the new API "watchdog_init_timeouts".
>>
>>     (3)Introduce ARM SBSA watchdog driver:
>>         a.Use linux kernel watchdog framework;
>>         b.Work with FDT on ARM64;
>>         c.Use "pretimeout" in watchdog framework;
>>         d.Support getting timeout and pretimeout from parameter and FDT
>>           at the driver init stage.
>>         e.In the first timeout, do panic to save system context;
>>         f.In the second stage, user can still feed the dog without
>>           cleaning WS0. By this feature, we can avoid the panic infinite
>>           loops, while backing up a large system context in a server.
>>         g.In the second stage, can trigger WS1 by setting pretimeout = 0
>>           if necessary.
>>
>>     (4)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>>     Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>>     and create a platform device with that information.
>>     This platform device can be used by This Watchdog driver.
>>     drivers/clocksource/arm_arch_timer.c is simplified by this GTDT support.
>>
>> This patchset has been tested with watchdog daemon
>> (ACPI/FDT, module/build-in) on the following platforms:
>>     (1)ARM Foundation v8 model
>>
>
> I tested it with kdump on fedora-arm64 Seattle platform. I enabled watchdog
> using systemd (with 30s timeout), insured that watchdog is active and then
> crashed the system. I can see that kdump kernel loads sbsa_wdt and activates
> watchdog, still vmcore copy is done successfully.
> My test kernel is here [1]
>
> ~Pratyush
>
> [1] https://github.com/pratyushanand/linux/commits/wdt/sbsa-test-kexec



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
