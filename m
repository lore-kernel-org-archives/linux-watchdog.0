Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62108 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaHWQfK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 Aug 2014 12:35:10 -0400
Date: Sat, 23 Aug 2014 09:35:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 00/11] kernel: Add support for restart handler call
 chain
Message-ID: <20140823163505.GA25900@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 19, 2014 at 05:45:27PM -0700, Guenter Roeck wrote:
> Various drivers implement architecture and/or device specific means
> to restart (reset) the system. Various mechanisms have been implemented
> to support those schemes. The best known mechanism is arm_pm_restart,
> which is a function pointer to be set either from platform specific code
> or from drivers. Another mechanism is to use hardware watchdogs to issue
> a reset; this mechanism is used if there is no other method available
> to reset a board or system. Two examples are alim7101_wdt, which currently
> uses the reboot notifier to trigger a reset, and moxart_wdt, which registers
> the arm_pm_restart function. Several other restart drivers for arm, all
> directly calling arm_pm_restart, are in the process of being integrated
> into the kernel. All those drivers would benefit from the new API.
> 
> The existing mechanisms have a number of drawbacks. Typically only one scheme
> to restart the system is supported (at least if arm_pm_restart is used).
> At least in theory there can be multiple means to restart the system, some of
> which may be less desirable (for example one mechanism may only reset the CPU,
> while another may reset the entire system). Using arm_pm_restart can also be
> racy if the function pointer is set from a driver, as the driver may be in
> the process of being unloaded when arm_pm_restart is called.
> Using the reboot notifier is always racy, as it is unknown if and when
> other functions using the reboot notifier have completed execution
> by the time the watchdog fires.
> 
> Introduce a system restart handler call chain to solve the described problems.
> This call chain is expected to be executed from the architecture specific
> machine_restart() function. Drivers providing system restart functionality
> (such as the watchdog drivers mentioned above) are expected to register
> with this call chain. By using the priority field in the notifier block,
> callers can control restart handler execution sequence and thus ensure that
> the restart handler with the optimal restart capabilities for a given system
> is called first.
> 
> Since the first revision of this patchset, a number of separate patch
> submissions have been made which either depend on it or could make use of it.
> 
> http://www.spinics.net/linux/lists/arm-kernel/msg344796.html
> 	registers three notifiers.
> https://lkml.org/lkml/2014/7/8/962
> 	would benefit from it.
> 
> Patch 1 of this series implements the restart handler function. Patches 2 and 3
> implement calling the restart handler chain from arm and arm64 restart code.
> 
> Patch 4 modifies the restart-poweroff driver to no longer call arm_pm_restart
> directly but machine_restart. This is done to avoid calling arm_pm_restart
> from more than one place. The change makes the driver architecture independent,
> so it would be possible to drop the arm dependency from its Kconfig entry.
> 
> Patch 5 and 6 convert existing restart handlers in the watchdog subsystem
> to use the restart handler. Patch 7 unexports arm_pm_restart to ensure
> that no one gets the idea to implement a restart handler as module.
> 
> The entire patch series, including additional patches depending on it,
> is available from
> https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git/
> in branch 'restart-staging'.
> 
Hi Andrew,

I think this series is ready for upstream integration. Question now
is how we should proceed to get it actually integrated.

I can see a number of options:
- You take patch #1, the rest goes in through maintainer trees.
- You take all patches after we get missing maintainer Acks.
- I send a pull request directly to Linus after we get missing
  maintainer Acks.

What do you think would be the best way to proceed ?

Thanks,
Guenter
