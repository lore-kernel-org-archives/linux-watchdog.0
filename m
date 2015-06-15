Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:50729 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbbFOUJF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 16:09:05 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [RESEND PATCH 0/3] watchdog: MAX63xx cleanup and platform settings
Date: Mon, 15 Jun 2015 15:58:38 -0400
Message-Id: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The first version of this patchset from January, 29 [1] got no feedback
from the maintainer. 1/4 [2] was applied to watchdog-next on May, 30
though. A concern about constants removal was raised in the preliminary
2/4 cleanup patch, the explanation has been added to the related commit
message.

Thus, resend the patchset. Below come the details about the changes:

The purpose of this patchset is to add a platform data structure for the
max63xx_wdt driver in order to setup the device in a platform code. This is
especially handy if the driver is built-in and/or the device registers
aren't memory mapped.

First, clean up the driver to help distinguish different device connections
and ease the introduction of new features. Then, add new platform settings
to support GPIO wired MAX63xx devices, and a different heartbeat.

Tested with a GPIO wired MAX6373 on an Atom platform, with a built-in
driver.

[1] https://lkml.org/lkml/2015/1/29/753
[2] https://lkml.org/lkml/2015/1/29/752

Vivien Didelot (3):
  watchdog: max63xx: cleanup
  watchdog: max63xx: add GPIO support
  watchdog: max63xx: add heartbeat to platform data

 drivers/watchdog/Kconfig                  |   9 +-
 drivers/watchdog/max63xx_wdt.c            | 297 +++++++++++++++++++-----------
 include/linux/platform_data/max63xx_wdt.h |  29 +++
 3 files changed, 226 insertions(+), 109 deletions(-)
 create mode 100644 include/linux/platform_data/max63xx_wdt.h

-- 
2.4.2

