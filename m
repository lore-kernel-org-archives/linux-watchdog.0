Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48877 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbcLWTkR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Dec 2016 14:40:17 -0500
Date: Fri, 23 Dec 2016 11:40:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.10 merge window
Message-ID: <20161223194004.GA25072@roeck-us.net>
References: <20161223100754.GA19660@spo001.leaseweb.nl>
 <CA+55aFzmP72eO+oQroCHqaKirZxBS8OqbBRua93URY9b7rPz1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzmP72eO+oQroCHqaKirZxBS8OqbBRua93URY9b7rPz1w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 23, 2016 at 10:22:06AM -0800, Linus Torvalds wrote:
> On Fri, Dec 23, 2016 at 2:07 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> > Hi Linus,
> >
> > Due to time constraints and personal issues Guenter and I decided that this window will be a pull from another location.
> > So please pull from 'watchdog-for-linus-v4.10' branch of
> 
> No shortlog, no diffstat. I won't be pulling, because I have no way to
> validate what I actually get.
> 


FWIW:

------

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-linus-v4.10

for you to fetch changes up to 067161281f428aa7c6e153e06aab7b5fe1ed1e98:

  watchdog: it87_wdt: add IT8620E ID (2016-12-16 06:53:56 -0800)

----------------------------------------------------------------
Watchdog updates for v4.10

New driver for Add Loongson1 SoC.
Minor cleanup and fixes in various drivers.

----------------------------------------------------------------
Alexander Usyskin (1):
      watchdog: mei_wdt: request stop on reboot to prevent false positive event

Amit Kushwaha (1):
      watchdog: cpwd: remove memory allocate failure message

Andy Shevchenko (2):
      intel-mid_wdt: make sure watchdog is not running at startup
      intel-mid_wdt: Error code is just an integer

Christian Lamparter (1):
      watchdog: qcom: fix kernel panic due to external abort on non-linefetch

Corentin Labbe (2):
      watchdog: octeon: Remove unneeded linux/miscdevice.h include
      watchdog: mpc8xxx: Remove unneeded linux/miscdevice.h include

Javier Martinez Canillas (3):
      watchdog: bcm7038_wdt: fix module autoload
      watchdog: max77620_wdt: fix module autoload
      watchdog: meson: Remove unneeded platform MODULE_ALIAS

Jimmy Vance (1):
      watchdog: hpwdt: changed maintainer information

Maciej S. Szmigiero (1):
      watchdog: it87_wdt: add IT8620E ID

Rasmus Villemoes (1):
      watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when appropriate

Robert P. J. Day (1):
      watchdog: Standardize leading tabs and spaces in Kconfig file

Stephen Boyd (1):
      watchdog: jz4740: Fix modular build

Steve Twiss (1):
      watchdog: da9062/61: watchdog driver

Tero Kristo (1):
      watchdog: davinci: add support for deferred probing

Yang Ling (1):
      watchdog: loongson1: Add Loongson1 SoC watchdog driver

 MAINTAINERS                        |   2 +-
 drivers/watchdog/Kconfig           |  49 ++++++-----
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/bcm2835_wdt.c     |  20 +++++
 drivers/watchdog/bcm7038_wdt.c     |   1 +
 drivers/watchdog/cpwd.c            |  23 ++---
 drivers/watchdog/da9062_wdt.c      |  12 ++-
 drivers/watchdog/davinci_wdt.c     |   6 +-
 drivers/watchdog/intel-mid_wdt.c   |  22 ++---
 drivers/watchdog/it87_wdt.c        |   4 +-
 drivers/watchdog/jz4740_wdt.c      |   2 +-
 drivers/watchdog/loongson1_wdt.c   | 170 +++++++++++++++++++++++++++++++++++++
 drivers/watchdog/max77620_wdt.c    |   1 +
 drivers/watchdog/mei_wdt.c         |   2 +
 drivers/watchdog/meson_gxbb_wdt.c  |   1 -
 drivers/watchdog/mpc8xxx_wdt.c     |   1 -
 drivers/watchdog/octeon-wdt-main.c |   1 -
 drivers/watchdog/qcom-wdt.c        |   2 +-
 18 files changed, 262 insertions(+), 58 deletions(-)
 create mode 100644 drivers/watchdog/loongson1_wdt.c
