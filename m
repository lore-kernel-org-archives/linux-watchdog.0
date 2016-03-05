Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36836 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbcCEPvp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 5 Mar 2016 10:51:45 -0500
Received: by mail-oi0-f45.google.com with SMTP id r187so55997397oih.3
        for <linux-watchdog@vger.kernel.org>; Sat, 05 Mar 2016 07:51:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160304194747.GB7099@spo001.leaseweb.nl>
References: <1456735610-22012-1-git-send-email-fu.wei@linaro.org>
	<20160304194747.GB7099@spo001.leaseweb.nl>
Date: Sat, 5 Mar 2016 23:51:44 +0800
Message-ID: <CADyBb7vx+LofgEdwffavYweS0snbCFRuoMp-LHctuvue+rszXw@mail.gmail.com>
Subject: Re: [PATCH v14 0/4] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Richard Ruigrok <rruigrok@codeaurora.org>,
	"Abdulhamid, Harb" <harba@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 5 March 2016 at 03:47, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Fu,
>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>>     for FDT info of SBSA Generic Watchdog, and give two examples of
>>     adding SBSA Generic Watchdog device node into the dts files:
>>     foundation-v8.dts and amd-seattle-soc.dtsi.
>>
>>     (2)Introduce ARM SBSA watchdog driver:
>>         a.Use linux kernel watchdog framework;
>>         b.Work with FDT on ARM64;
>>         c.Support getting timeout from parameter and FDT at the driver
>>           init stage.
>>         d.The driver works in two modes:
>>           (1) single stage timeout (ignore WS0 interrupt)
>>           (2) two stages timeout (register WS0 interrupt, do panic in routine)
>>         e.User can config working mode by module parameter "action".
>>
>> This patchset has been tested with watchdog daemon
>> (ACPI/FDT, module/build-in) on the following platforms:
>>     (1)ARM Foundation v8 model
>>     (2)AMD Seattle platform
>>
>> This patchset has been tested with kdump successfully.
>>
>> Changelog:
>> v14:Fix a bug of registering interrupt routine: do a ping before
>>     registering interrupt routine, in case where is a pending interrupt.
>>     Reorder the initialization code to postpone registering interrupt routine.
>>     Improve some code style:
>>         (1)add some macro of string
>>         (2)use watchdog_get_drvdata instead of to_sbsa_gwdt,
>>            delete to_sbsa_gwdt.
>>
>> v13:https://lkml.org/lkml/2016/2/16/713
>>     Fix a dev_warn message typo"signle"-->"single"
>>     Add MODULE_ALIAS
>>     Add more *ed-by in commit message.
>>
>> v12:https://lkml.org/lkml/2016/2/16/154
>>     Fix a dev_warn message typo"fall"--"falling"
>>     Remove unnecessary "status" in dts
>>     Add more *ed-by in commit message.
>>
>> v11:https://lkml.org/lkml/2016/2/9/577
>>     Merge patch 4 and 5.
>>     Improve some comments.
>>     The driver works in two modes, it's configured by "action"(instead of
>>     panic_enabled).
>>     Improve the initialization of the timeout limits.
>>     Feeding dog by writing "0" to WRR.
>>
>> v10:https://lkml.org/lkml/2016/2/3/817
>>     Delete pretimeout support.
>>     Separate the driver to two parts:
>>         (1) single stage timeout driver(ignore WS0 interrupt);
>>         (2) register WS0 interrupt for the half timeout panic.
>>     timeout == (enable --> WS1).
>>
>> v9: https://lkml.org/lkml/2015/11/9/57
>>     Rebase to latest kernel version(4.3).
>>     Update the Documentation of sbsa-gwdt device node info of FDT:
>>         (1) move some introduction to pretimeout patch
>>         (2) delete WS1 value from "interrupts" of binding documentation,
>>             since WS1 won't be handled by Linux.
>>
>> v8: https://lkml.org/lkml/2015/10/27/466
>>     Rebase to latest kernel version(4.3-rc7).
>>     Separate the patches of GTDT support and arm_arch_timer. This
>>     clocksource relevant patch will upstreamed in a individual patchset.
>>     Update all the default timeout and pretimeout to 30s and 60s.
>>     Improve documentation and inline comments.
>>     Fix a bug in pretimeout support which makes timeout and pretimeout
>>     parameters initialization fail.
>>
>> v7: https://lkml.org/lkml/2015/8/24/611
>>     Rebase to latest kernel version(4.2-rc7).
>>     Improve FDT support: geting resource by order, instead of name.
>>     According to the FDT support, Update the example dts file, gtdt.c
>>     and sbsa_gwdt.c.
>>     Pass the sparse test, and fix the warning.
>>     Fix the max_pretimeout and max_timeout value overflow bug.
>>     Delete the WCV output value.
>>
>>
>> v6: https://lkml.org/lkml/2015/6/23/359
>>     Improve the dtb example files: reduce the register frame size to 4K.
>>     Improve pretimeout support:
>>         (1) improve watchdog_init_timeouts function
>>       (2) rename watchdog_check_min_max_timeouts back to the original name
>>         (1) improve watchdog_timeout_invalid/watchdog_pretimeout_invalid
>>     Add the new features in the sbsa_gwdt driver:
>>       (1) In the second stage, user can feed the dog without cleaning WS0.
>>       (2) In the second stage, user can trigger WS1 by setting pretimeout = 0.
>>       (3) expand the max value of pretimeout, in case 10 second is not enough
>>           for a kdump kernel reboot in panic.
>>
>> v5: https://lkml.org/lkml/2015/6/10/357
>>     Improve pretimeout support:
>>         (1)fix typo in documentation and comments.
>>       (2)fix the timeout limits validation bug.
>>     Simplify sbsa_gwdt driver:
>>       (1)integrate all the registers access functions into caller.
>>
>> v4: https://lkml.org/lkml/2015/6/2/4
>>     Refactor GTDT support code: remove it from arch/arm64/kernel/acpi.c,
>>     put it into drivers/acpi/gtdt.c file.
>>     Integrate the GTDT code of drivers/clocksource/arm_arch_timer.c into
>>     drivers/acpi/gtdt.c.
>>     Improve pretimeout support, fix "pretimeout == 0" problem.
>>     Simplify sbsa_gwdt driver:
>>         (1)timeout/pretimeout limits setup;
>>         (2)keepalive function;
>>         (3)delete "clk == 0" check;
>>         (4)delete WS0 status bit check in interrupt routine;
>>         (5)sbsa_gwdt_set_wcv function.
>>
>> v3: https://lkml.org/lkml/2015/5/25/111
>>     Delete "export arch_timer_get_rate" patch.
>>     Driver back to use arch_timer_get_cntfrq.
>>     Improve watchdog_init_timeouts function and update relevant documentation.
>>     Improve watchdog_timeout_invalid and watchdog_pretimeout_invalid.
>>     Improve foundation-v8.dts: delete the unnecessary tag of device node.
>>     Remove "ARM64 || COMPILE_TEST" from Kconfig.
>>     Add comments in arch/arm64/kernel/acpi.c
>>     Fix typoes and incorrect comments.
>>
>> v2: https://lkml.org/lkml/2015/5/21/172
>>     Improve watchdog-kernel-api.txt documentation for pretimeout support.
>>     Export "arch_timer_get_rate" in arm_arch_timer.c.
>>     Add watchdog_init_timeouts API for pretimeout support in framework.
>>     Improve suspend and resume foundation in driver
>>     Improve timeout/pretimeout values init code in driver.
>>     Delete unnecessary items of the sbsa_gwdt struct and #define.
>>     Delete all unnecessary debug info in driver.
>>     Fix 64bit division bug.
>>     Use the arch_timer interface to get watchdog clock rate.
>>     Add MODULE_DEVICE_TABLE for platform device id.
>>     Fix typoes.
>>
>> v1: https://lkml.org/lkml/2015/5/15/279
>>     The first version upstream patchset to linux mailing list.
>>
>> Fu Wei (4):
>>   Documentation: add sbsa-gwdt driver documentation
>>   ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
>>   ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
>>   Watchdog: introduce ARM SBSA watchdog driver
>>
>>  .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  31 ++
>>  Documentation/watchdog/watchdog-parameters.txt     |   7 +
>>  arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |   8 +
>>  arch/arm64/boot/dts/arm/foundation-v8.dts          |   7 +
>>  drivers/watchdog/Kconfig                           |  20 +
>>  drivers/watchdog/Makefile                          |   1 +
>>  drivers/watchdog/sbsa_gwdt.c                       | 408 +++++++++++++++++++++
>>  7 files changed, 482 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>>  create mode 100644 drivers/watchdog/sbsa_gwdt.c
>>
>> --
>> 2.5.0
>>
>
> Patchset added to linux-watchdog-next.
Hi Wim,
It is really a awesome news, Great thanks!  :-)

Great thanks to everyone who helps me on this patchset!

>
> Kind regards,
> Wim.
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
