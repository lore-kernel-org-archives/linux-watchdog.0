Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35578 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbbF2QxR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Jun 2015 12:53:17 -0400
Received: by oiax193 with SMTP id x193so122366513oia.2
        for <linux-watchdog@vger.kernel.org>; Mon, 29 Jun 2015 09:53:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1435068994-13526-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
	<1435068994-13526-1-git-send-email-fu.wei@linaro.org>
Date: Tue, 30 Jun 2015 00:53:16 +0800
Message-ID: <CADyBb7vgfFTmqLMMDOjWxwk3B-he2hTYAGpB3diKf47eB=dc=A@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com, Fu Wei <fu.wei@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Any suggestion on this v6 patchset, for now , I only got :
(1) delete WCV output:
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 2de5899..c42883b 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -344,8 +342,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)

        status = readl_relaxed(gwdt->control_base + SBSA_GWDT_WCS);
        if (status & SBSA_GWDT_WCS_WS1) {
-               dev_warn(dev, "System reset by WDT(WCV: %llx)\n",
-                        sbsa_gwdt_get_wcv(wdd));
+               dev_warn(dev, "System reset by WDT.\n");
                wdd->bootstatus |= WDIOF_CARDRESET;
        } else if (status == (SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_EN)) {
                gwdt->ws0_mode = true;

any question or anything I can improve for this patchset?

Great thanks for your help.


On 23 June 2015 at 22:16,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>     for FDT info of SBSA Generic Watchdog, and give two examples of
>     adding SBSA Generic Watchdog device node into the dts files:
>     foundation-v8.dts and amd-seattle-soc.dtsi.
>
>     (2)Introduce "pretimeout" into the watchdog framework, and update
>     Documentation/watchdog/watchdog-kernel-api.txt to introduce:
>         (1)the new elements in the watchdog_device and watchdog_ops struct;
>         (2)the new API "watchdog_init_timeouts".
>
>     (3)Introduce ARM SBSA watchdog driver:
>         a.Use linux kernel watchdog framework;
>         b.Work with FDT on ARM64;
>         c.Use "pretimeout" in watchdog framework;
>         d.Support getting timeout and pretimeout from parameter and FDT
>           at the driver init stage.
>         e.In the first timeout, do panic to save system context;
>         f.In the second stage, user can still feed the dog without
>           cleaning WS0. By this feature, we can avoid the panic infinite
>           loops, while backing up a large system context in a server.
>         g.In the second stage, can trigger WS1 by setting pretimeout = 0
>           if necessary.
>
>     (4)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>     Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>     and create a platform device with that information.
>     This platform device can be used by This Watchdog driver.
>     drivers/clocksource/arm_arch_timer.c is simplified by this GTDT support.
>
> This patchset has been tested with watchdog daemon
> (ACPI/FDT, module/build-in) on the following platforms:
>     (1)ARM Foundation v8 model
>
> Changelog:
> v6: Improve the dtb example files: reduce the register frame size to 4K.
>     Improve pretimeout support:
>         (1) improve watchdog_init_timeouts function
>         (2) rename watchdog_check_min_max_timeouts back to the original name
>         (1) improve watchdog_timeout_invalid/watchdog_pretimeout_invalid
>     Add the new features in the sbsa_gwdt driver:
>         (1) In the second stage, user can feed the dog without cleaning WS0.
>         (2) In the second stage, user can trigger WS1 by setting pretimeout = 0.
>         (3) expand the max value of pretimeout, in case 10 second is not enough
>             for a kdump kernel reboot in panic.
>
> v5: Improve pretimeout support:
>         (1)fix typo in documentation and comments.
>         (2)fix the timeout limits validation bug.
>     Simplify sbsa_gwdt driver:
>         (1)integrate all the registers access functions into caller.
>
> v4: Refactor GTDT support code: remove it from arch/arm64/kernel/acpi.c,
>     put it into drivers/acpi/gtdt.c file.
>     Integrate the GTDT code of drivers/clocksource/arm_arch_timer.c into
>     drivers/acpi/gtdt.c.
>     Improve pretimeout support, fix "pretimeout == 0" problem.
>     Simplify sbsa_gwdt driver:
>         (1)timeout/pretimeout limits setup;
>         (2)keepalive function;
>         (3)delete "clk == 0" check;
>         (4)delete WS0 status bit check in interrupt routine;
>         (5)sbsa_gwdt_set_wcv function.
>
> v3: Delete "export arch_timer_get_rate" patch.
>     Driver back to use arch_timer_get_cntfrq.
>     Improve watchdog_init_timeouts function and update relevant documentation.
>     Improve watchdog_timeout_invalid and watchdog_pretimeout_invalid.
>     Improve foundation-v8.dts: delete the unnecessary tag of device node.
>     Remove "ARM64 || COMPILE_TEST" from Kconfig.
>     Add comments in arch/arm64/kernel/acpi.c
>     Fix typoes and incorrect comments.
>
> v2: Improve watchdog-kernel-api.txt documentation for pretimeout support.
>     Export "arch_timer_get_rate" in arm_arch_timer.c.
>     Add watchdog_init_timeouts API for pretimeout support in framework.
>     Improve suspend and resume foundation in driver
>     Improve timeout/pretimeout values init code in driver.
>     Delete unnecessary items of the sbsa_gwdt struct and #define.
>     Delete all unnecessary debug info in driver.
>     Fix 64bit division bug.
>     Use the arch_timer interface to get watchdog clock rate.
>     Add MODULE_DEVICE_TABLE for platform device id.
>     Fix typoes.
>
> v1: The first version upstream patchset to linux mailing list.
>
> Fu Wei (8):
>   Documentation: add sbsa-gwdt.txt documentation
>   ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
>   ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
>   Watchdog: introdouce "pretimeout" into framework
>   Watchdog: introduce ARM SBSA watchdog driver
>   ACPI: add GTDT table parse driver into ACPI driver
>   Watchdog: enable ACPI GTDT support for ARM SBSA watchdog driver
>   clocksource: simplify ACPI code in arm_arch_timer.c
>
>  .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  36 ++
>  Documentation/watchdog/watchdog-kernel-api.txt     |  47 ++-
>  arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |  11 +
>  arch/arm64/boot/dts/arm/foundation-v8.dts          |  10 +
>  arch/arm64/kernel/time.c                           |   4 +-
>  drivers/acpi/Kconfig                               |   9 +
>  drivers/acpi/Makefile                              |   1 +
>  drivers/acpi/gtdt.c                                | 180 ++++++++
>  drivers/clocksource/Kconfig                        |   1 +
>  drivers/clocksource/arm_arch_timer.c               |  60 +--
>  drivers/watchdog/Kconfig                           |  15 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/sbsa_gwdt.c                       | 455 +++++++++++++++++++++
>  drivers/watchdog/watchdog_core.c                   |  98 +++--
>  drivers/watchdog/watchdog_dev.c                    |  53 +++
>  include/clocksource/arm_arch_timer.h               |   8 +
>  include/linux/acpi.h                               |   5 +
>  include/linux/clocksource.h                        |   4 +-
>  include/linux/watchdog.h                           |  39 +-
>  19 files changed, 947 insertions(+), 90 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>  create mode 100644 drivers/acpi/gtdt.c
>  create mode 100644 drivers/watchdog/sbsa_gwdt.c
>
> --
> 1.9.1
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
