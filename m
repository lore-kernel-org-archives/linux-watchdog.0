Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.linux-watchdog.org ([185.87.125.42]:47156 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeIANAQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Sep 2018 09:00:16 -0400
Date: Sat, 1 Sep 2018 10:28:36 +0200
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [GIT PULL REQUEST] watchdog - v4.19-rc2
Message-ID: <20180901082836.GA21742@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.19 release cycle.

This pull contains:
* renesas-wdt: Document support for r8a774a1

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit 3f16503b7d2274ac8cbab11163047ac0b4c66cfe:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2018-08-28 16:11:34 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.19-rc2

for you to fetch changes up to 74081c9f16a213f8f2681c175dc6ad7d17ad16ba:

  dt-bindings: watchdog: renesas-wdt: Document r8a774a1 support (2018-08-29 20:32:04 +0200)

----------------------------------------------------------------
linux-watchdog 4.19-rc2 tag

----------------------------------------------------------------
Fabrizio Castro (1):
      dt-bindings: watchdog: renesas-wdt: Document r8a774a1 support

 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

----------------------------------------------------------------

Kind regards,
Wim.
