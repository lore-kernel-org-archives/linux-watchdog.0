Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42032 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbaH3QxC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 30 Aug 2014 12:53:02 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [Patch v3] 0/7] Remove mach-kirkwood
Date: Sat, 30 Aug 2014 18:46:05 +0200
Message-Id: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is mostly a resend of these patches, removing mach-kirkwood.  Not
all maintainers picked up there patches, which has resulted in some
dead kernel configuration in v3.17-rcX.

The patch set has been rebased on v3.17-rc2, and it is intended that
Jason Cooper will submit them for inclusion in an RC. Subsystem
maintainers do not need to do anything.

The last patch "cpufreq: Remove ARCH_KIRKWOOD dependency" is new,
since what it is removing was added during v3.16-rcX. It follows the
pattern of all the other patches.

Andrew Lunn (7):
  cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
  ata: Remove ARCH_KIRKWOOD dependency
  thermal: Remove ARCH_KIRKWOOD dependency
  leds: Remove ARCH_KIRKWOOD dependency
  rtc: Remove ARCH_KIRKWOOD dependency
  watchdog: Remove ARCH_KIRKWOOD dependency
  cpufreq: Remove ARCH_KIRKWOOD dependency

 drivers/ata/Kconfig         | 2 +-
 drivers/cpufreq/Kconfig.arm | 2 +-
 drivers/cpuidle/Kconfig.arm | 2 +-
 drivers/leds/Kconfig        | 4 ++--
 drivers/rtc/Kconfig         | 2 +-
 drivers/thermal/Kconfig     | 2 +-
 drivers/watchdog/Kconfig    | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

--
2.1.0

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
