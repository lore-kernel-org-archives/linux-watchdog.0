Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:60819 "EHLO
	smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115AbbFZNbk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 09:31:40 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] watchdog: dw_wdt: allow only one probe + various fixes
Date: Fri, 26 Jun 2015 14:21:08 +0100
Message-Id: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The dw_wdt watchdog driver supports a single DesignWare watchdog device
using a statically allocated variable 'dw_wdt' to manage it, but there
are some bits of hardware containing two such devices.  If the "probe"
is called for more than one device, the 'dw_wdt' variable gets
clobbered, generally resulting in a kernel crash.  Change it to reject
additional probed devices.

We probably don't expect the "remove" function to get called, but if it
does, make sure the Linux timer used by device gets unqueued.

The timer also gets unqueued if the watchdog device is closed by the
user process unexpectedly.  However, this is not currently done
asynchronously and the timer function normally requeues the timer.  If
it manages to requeue the timer, the next call of the timer function
will behave as though the close was expected and continue patting the
dog every half a second when it should have stopped doing so.  Unqueue
the timer synchronously to avoid that.

NOTE: There is another potential problem that I haven't bothered to fix.
If the "remove" function is called while the watchdog device is still
open, any in-progress or future file operations are likely to screw
things up.

1) watchdog: dw_wdt: prepare for more atomic bits
2) watchdog: dw_wdt: reject additional device probes
3) watchdog: dw_wdt: only unregister restart handler if registered
4) watchdog: dw_wdt: unqueue timer on device removal
5) watchdog: dw_wdt: unqueue timer synchronously on unexpected close

 drivers/watchdog/dw_wdt.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)
