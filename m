Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53143 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbaBQRWA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Feb 2014 12:22:00 -0500
Message-ID: <53024532.9070908@roeck-us.net>
Date: Mon, 17 Feb 2014 09:21:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: kbuild test robot <fengguang.wu@intel.com>,
	Andrew Chew <achew@nvidia.com>
CC: kbuild-all@01.org, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [hwmon:watchdog-next 28/34] drivers/watchdog/tegra_wdt.c:74:12:
 error: 'heartbeat' redeclared as different kind of symbol
References: <5301a643.p3rnCjyaZE81E0je%fengguang.wu@intel.com>
In-Reply-To: <5301a643.p3rnCjyaZE81E0je%fengguang.wu@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/16/2014 10:03 PM, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-next
> head:   222fc2298fc0be6ee62cfed67aeb7b28231bbd3f
> commit: 1a3a7c2eb7d3df4a56f7fe981c0fca9d47ab39ff [28/34] watchdog: Add tegra watchdog
> config: make ARCH=microblaze allyesconfig
>
> All error/warnings:
>
>>> drivers/watchdog/tegra_wdt.c:74:12: error: 'heartbeat' redeclared as different kind of symbol
>      static int heartbeat = WDT_HEARTBEAT;
>                 ^
>     In file included from arch/microblaze/include/asm/processor.h:15:0,
>                      from arch/microblaze/include/asm/thread_info.h:21,
>                      from include/linux/thread_info.h:54,
>                      from include/asm-generic/preempt.h:4,
>                      from arch/microblaze/include/generated/asm/preempt.h:1,
>                      from include/linux/preempt.h:18,
>                      from include/linux/spinlock.h:50,
>                      from include/linux/seqlock.h:35,
>                      from include/linux/time.h:5,
>                      from include/linux/stat.h:18,
>                      from include/linux/module.h:10,
>                      from drivers/watchdog/tegra_wdt.c:15:
>     arch/microblaze/include/asm/setup.h:28:6: note: previous declaration of 'heartbeat' was here
>      void heartbeat(void);
>           ^
>
> vim +/heartbeat +74 drivers/watchdog/tegra_wdt.c
>
>      68		struct watchdog_device	wdd;
>      69		void __iomem		*wdt_regs;
>      70		void __iomem		*tmr_regs;
>      71	};
>      72	
>      73	#define WDT_HEARTBEAT 120
>    > 74	static int heartbeat = WDT_HEARTBEAT;
>      75	module_param(heartbeat, int, 0);
>      76	MODULE_PARM_DESC(heartbeat,
>      77		"Watchdog heartbeats in seconds. (default = "
>

[ I really like Fengguang's build robots ... ]

I think this should be fixed in the microblaze code - heartbeat not the best
name for a global function, and static 'heartbeat' variables are used all
over the place in the watchdog subsystem.

I'll submit a patch for it.

Thanks,
Guenter

