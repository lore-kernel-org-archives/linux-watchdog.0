Return-Path: <wim@iguana.be>
Return-path: <wim@iguana.be>
Date: Sun, 17 Dec 2017 11:55:58 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.15 Fixes
Message-ID: <20171217105558.GA6260@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

here are 4 fixes for the watchdog device drivers.
Please pull.

Kind regards,
Wim.

The following changes since commit f3b5ad89de16f5d42e8ad36fbdf85f705c1ae051:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2017-12-16 13:43:08 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git 

for you to fetch changes up to c42cbe41727a138905a28f8e0b00c147be77ee93:

  watchdog: hpwdt: SMBIOS check (2017-12-17 11:01:49 +0100)

----------------------------------------------------------------
Guenter Roeck (2):
      watchdog: Fix potential kref imbalance when opening watchdog
      watchdog: Fix kref imbalance seen if handle_boot_enabled=0

Jerry Hoemann (1):
      watchdog: hpwdt: SMBIOS check

Matt Redfearn (1):
      watchdog: indydog: Add dependency on SGI_HAS_INDYDOG

 drivers/watchdog/Kconfig        |  2 +-
 drivers/watchdog/hpwdt.c        |  2 +-
 drivers/watchdog/watchdog_dev.c | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)
