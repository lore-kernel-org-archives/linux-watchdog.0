Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:50878 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbdDALCk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Apr 2017 07:02:40 -0400
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zoltan Boszormenyi <zboszor@pr.hu>
Subject: [PATCH 0/3, resend] Fix sp5100_tco watchdog driver regression
Date: Sat,  1 Apr 2017 13:02:20 +0200
Message-Id: <20170401110223.12056-1-zboszor@pr.hu>
In-Reply-To: <20170401100609.9054-1-zboszor@pr.hu>
References: <20170401100609.9054-1-zboszor@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


My name with Hungarian accented characters from the Signed-off-by line
is also used in cc: by git send-email but it gets rejected by
mailer damons. Why only patch 2/3 was rejected is a mystery.
Resending with my name in 7-bit ASCII.

Three drivers are accessing the same I/O ports (0xcd6 / 0xcd7) on
AMD SB800 based machines without synchronization or with excluding
each other out:
* the USB quirk for isochronous transfers on SB800 (no locking)
* sp5100_tco (request_region)
* i2c-piix4 (request_region)

Historically, the sp5100_tco watchdog driver used request_region()
for these I/O ports but an i2c-piix4 improvement for SB800 in
Linux 4.4-rc4 also added a request_region() call. Because of this
and the load order, this cause a regression and the watchdog function
became non-functional. The commit that caused the regression is:

commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
Author: Christian Fetzer <fetzer.ch@gmail.com>
Date:   Thu Nov 19 20:13:48 2015 +0100

    i2c: piix4: Add support for multiplexed main adapter in SB800

I was informed by Guenter Roeck <linux@roeck-us.net> that the
alternative, i.e. using request_muxed_region() can fail, either
because of a resource allocation failure, which is quite possible
with long uptimes, or because there are no guarantees that an as yet
unknown driver would also use request_muxed_region() consistently.

Because of this, a solution using a common mutex was chosen to
synchronize I/O port accesses and request_region() calls are removed
from both i2c-piix4 and sp5100_tco to make the code uniform.

This patch series implements this and restores the watchdog function.

Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>

 drivers/i2c/busses/i2c-piix4.c | 59 ++++++++++++--------------------------
 drivers/usb/host/pci-quirks.c  | 14 ++++++---
 drivers/watchdog/sp5100_tco.c  | 24 +++++++---------
 drivers/watchdog/sp5100_tco.h  | 10 ++++---
 include/linux/sb800.h          | 15 ++++++++++
 5 files changed, 61 insertions(+), 61 deletions(-)

