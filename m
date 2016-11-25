Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35127 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755081AbcKYPGr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 25 Nov 2016 10:06:47 -0500
Received: by mail-io0-f173.google.com with SMTP id a124so128880776ioe.2
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Nov 2016 07:06:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
References: <20161125084623.22515-9-fu.wei@linaro.org> <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Fri, 25 Nov 2016 23:06:32 +0800
Message-ID: <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
Subject: Re: [PATCH v17 08/15] clocksource/drivers/arm_arch_timer: move
 arch_timer_needs_of_probing into DT init call
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        G Gregory <graeme.gregory@linaro.org>,
        Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
        Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Leo Duran <leo.duran@amd.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi ,

On 25 November 2016 at 22:32, kbuild test robot <lkp@intel.com> wrote:
> Hi Fu,
>
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.9-rc6]
> [cannot apply to tip/timers/core next-20161125]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161125-171111
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> Note: the linux-review/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161125-171111 HEAD 498f1f2503da21841b0e7679ddbdb86a40451bdb builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_acpi_init':

Sorry, again,

a "+ int ret;" should be move from [12/15] to here, I have fix the
problem in my repo, it would happen in next patchset

https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel

>>> drivers/clocksource/arm_arch_timer.c:1071:2: error: 'ret' undeclared (first use in this function)
>      ret = arch_timer_register();
>      ^~~
>    drivers/clocksource/arm_arch_timer.c:1071:2: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/ret +1071 drivers/clocksource/arm_arch_timer.c
>
>   1065                  return -EINVAL;
>   1066          }
>   1067
>   1068          /* Always-on capability */
>   1069          arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
>   1070
>> 1071          ret = arch_timer_register();
>   1072          if (ret)
>   1073                  return ret;
>   1074
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
