Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43985 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573AbbHLIQI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:16:08 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 0/7] watchdog: mpc8xxx: several cleanups
Date: Wed, 12 Aug 2015 10:15:51 +0200
Message-Id: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

this is the reviewed series of some cleanups to the mpc8xxx watchdog driver.
v1 was sent starting with Message-Id:
1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de .

Patch 6 "watchdog: mpc8xxx: use better error code when watchdog cannot
be enabled" is new. This fixed a checkpatch warning that is reported for
patch 4. The finding is wrong though, because this patch only does
some code rearrangements and doesn't introduce the warning.

Also I split patch "watchdog: mpc8xxx: make use of
of_device_get_match_data" from v1 to really only do that and the
remaining cleanup done there is now in a separate patch (the
devm_ioremap_resource one).

Also I fixed the wording in the last patch as pointed out by Guenter.

Uwe Kleine-König (7):
  watchdog: mpc8xxx: remove dead code
  watchdog: mpc8xxx: simplify registration
  watchdog: mpc8xxx: make use of of_device_get_match_data
  watchdog: mpc8xxx: use devm_ioremap_resource to map memory
  watchdog: mpc8xxx: use dynamic memory for device specific data
  watchdog: mpc8xxx: use better error code when watchdog cannot be
    enabled
  watchdog: mpc8xxx: allow to compile for MPC512x

 drivers/watchdog/Kconfig       |   2 +-
 drivers/watchdog/mpc8xxx_wdt.c | 156 +++++++++++++++++------------------------
 2 files changed, 67 insertions(+), 91 deletions(-)

-- 
2.4.6

