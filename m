Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12812 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754073AbaIIPK5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Sep 2014 11:10:57 -0400
Date: Tue, 9 Sep 2014 11:10:22 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Patch v3] 0/7] Remove mach-kirkwood
Message-ID: <20140909151022.GM30828@titan.lakedaemon.net>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Andrew,

On Sat, Aug 30, 2014 at 06:46:05PM +0200, Andrew Lunn wrote:
> This is mostly a resend of these patches, removing mach-kirkwood.  Not
> all maintainers picked up there patches, which has resulted in some
> dead kernel configuration in v3.17-rcX.
> 
> The patch set has been rebased on v3.17-rc2, and it is intended that
> Jason Cooper will submit them for inclusion in an RC. Subsystem
> maintainers do not need to do anything.
> 
> The last patch "cpufreq: Remove ARCH_KIRKWOOD dependency" is new,
> since what it is removing was added during v3.16-rcX. It follows the
> pattern of all the other patches.
> 
> Andrew Lunn (7):
>   cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
>   ata: Remove ARCH_KIRKWOOD dependency
>   thermal: Remove ARCH_KIRKWOOD dependency
>   leds: Remove ARCH_KIRKWOOD dependency
>   rtc: Remove ARCH_KIRKWOOD dependency
>   watchdog: Remove ARCH_KIRKWOOD dependency
>   cpufreq: Remove ARCH_KIRKWOOD dependency
> 
>  drivers/ata/Kconfig         | 2 +-
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  drivers/cpuidle/Kconfig.arm | 2 +-
>  drivers/leds/Kconfig        | 4 ++--
>  drivers/rtc/Kconfig         | 2 +-
>  drivers/thermal/Kconfig     | 2 +-
>  drivers/watchdog/Kconfig    | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)

Applied to mvebu/fixes for v3.17 with all the various Acks.  Also,
please don't add the extra ']' in the Subject lines, 'git am' threw a
gasket on that so I had to manually edit before applying.  Not a big
deal, just an fyi.

thx,

Jason.
