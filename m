Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34462 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcEYGiS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 02:38:18 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/7] watchdog: softdog: cleanups
Date: Wed, 25 May 2016 08:37:42 +0200
Message-Id: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

While working on another series where I need the softdog, this series already
came out of it. It gets the driver prepared for the interesting stuff (coming
later today hopefully) but is orthogonal from that.

Buildbot is happy, branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/softdog_cleanup

Please review, comment, apply...

Thanks,

   Wolfram

Wolfram Sang (7):
  watchdog: softdog: remove obsolete comments
  watchdog: softdog: use watchdog core to init timeout value
  watchdog: softdog: consistently use softdog_ prefix
  watchdog: softdog: remove forward declaration
  watchdog: softdog: sort includes to avoid duplicates
  watchdog: softdog: drop superfluous set_timeout callback
  watchdog: softdog: improve coding style

 drivers/watchdog/softdog.c | 92 +++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 71 deletions(-)

-- 
2.8.1

