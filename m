Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34035 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbKIIaK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 03:30:10 -0500
Received: by obbza9 with SMTP id za9so135047370obb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Nov 2015 00:30:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1446042725-5649-1-git-send-email-fu.wei@linaro.org>
References: <1446042725-5649-1-git-send-email-fu.wei@linaro.org>
Date: Mon, 9 Nov 2015 16:30:09 +0800
Message-ID: <CADyBb7v2zGURXotA5B8ekr+BXry8=8zF_S5ACoEqUhZGiqui-A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] ACPI, clocksource: add GTDT and ARM memory-mapped
 timer support
From: Fu Wei <fu.wei@linaro.org>
To: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rafael Wysocki <rjw@rjwysocki.net>, lenb@kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <hanjun.guo@linaro.org>, davem@davemloft.net,
	jeffrey.t.kirsher@intel.com, richardcochran@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>, Fu Wei <fu.wei@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all

On 28 October 2015 at 22:32,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
>
>     (2)Simplify ACPI code for arch timer in arm_arch_timer.c
>
>     (3)Add memory-mapped timer support in arm_arch_timer.c
>
> [PATCH 2/3] and [PATCH 3/3] depend on a patchset
> [PATCH v2 0/5] ACPI probing infrastructure,
> https://lkml.org/lkml/2015/9/13/126, which has been accepted by upstream
> maintainer, and has been merged in linux-next.git, tag: next-20151013.

FYI: These dependent patches have been merged into master branch of
vanilla kernel
That means this patchset can be applied on mainline kernel.

>
> The SBSA Generic Watchdog info parsing support have been tested with
> a upstreaming SBSA Generic Watchdog driver:
> https://lkml.org/lkml/2015/10/27/466
> on the following platforms:
>     (1)ARM Foundation v8 model
>     (2)AMD Seattle platform
>
> ARM memory-mapped timer support of this patchset has been tested
> on the following platforms:
>     (1)ARM Foundation v8 model
>
> Changelog:
> v1: The first upstreaming version.
>
> Fu Wei (3):
>   ACPI: add GTDT table parse driver into ACPI driver
>   clocksource: simplify ACPI code in arm_arch_timer.c
>   clocksource: add memory-mapped timer support in arm_arch_timer.c
>
>  drivers/acpi/Kconfig                 |   9 +
>  drivers/acpi/Makefile                |   1 +
>  drivers/acpi/gtdt.c                  | 367 +++++++++++++++++++++++++++++++++++
>  drivers/clocksource/arm_arch_timer.c | 176 +++++++++++++----
>  include/clocksource/arm_arch_timer.h |  19 ++
>  include/linux/acpi.h                 |  17 ++
>  6 files changed, 554 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/acpi/gtdt.c
>
> --
> 2.4.3
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
