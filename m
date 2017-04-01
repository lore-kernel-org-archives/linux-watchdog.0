Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:39681 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdDAKHX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Apr 2017 06:07:23 -0400
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
To: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
Subject: [PATCH 0/3] Fix sp5100_tco watchdog driver regression
Date: Sat,  1 Apr 2017 12:06:06 +0200
Message-Id: <20170401100609.9054-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Three drivers are accessing the same I/O ports (0xcd6 / 0xcd7) on
AMD SB800 based machines without synchronization or with excluding
each other out:
* the USB quirk for isochronous transfers on SB800 (no locking)
* sp5100_tco (request_region)
* i2c-piix4 (request_region)

Historically, the sp5100_tco watchdog driver used request_region()
for these I/O ports but an i2c-piix4 improvement for SB800 in
Linux 4.4-rc4 also added a request_region() call. Because of this
and the load order of these drivers, this caused a regression and
the watchdog function became non-functional. The commit that caused
the regression is:

commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
Author: Christian Fetzer <fetzer.ch@gmail.com>
Date:   Thu Nov 19 20:13:48 2015 +0100

    i2c: piix4: Add support for multiplexed main adapter in SB800

I was informed by Guenter Roeck <linux@roeck-us.net> that the
alternative, i.e. using request_muxed_region() can fail, either
because of a resource allocation failure, which is quite possible
with long uptimes, or because there are no guarantees that an as yet
unknown driver would also use request_muxed_region() consistently.

Because of this, a common mutex across these driver was chosen to
synchronize I/O port accesses and request_region() calls are removed
from both i2c-piix4 and sp5100_tco to make the code uniform.

This patch series implements this and restores the watchdog function.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>

 drivers/i2c/busses/i2c-piix4.c | 59 ++++++++++++--------------------------
 drivers/usb/host/pci-quirks.c  | 14 ++++++---
 drivers/watchdog/sp5100_tco.c  | 24 +++++++---------
 drivers/watchdog/sp5100_tco.h  | 10 ++++---
 include/linux/sb800.h          | 15 ++++++++++
 5 files changed, 61 insertions(+), 61 deletions(-)

