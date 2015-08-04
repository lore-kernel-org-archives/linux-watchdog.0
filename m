Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45829 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbHDCNq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Aug 2015 22:13:46 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/8] watchdog: Add support for keepalives triggered by infrastructure
Date: Mon,  3 Aug 2015 19:13:26 -0700
Message-Id: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog infrastructure is currently purely passive, meaning
it only passes information from user space to drivers and vice versa.

Since watchdog hardware tends to have its own quirks, this can result
in quite complex watchdog drivers. A number of scanarios are especially common.

- A watchdog is always active and can not be disabled, or can not be disabled
  once enabled. To support such hardware, watchdog drivers have to implement
  their own timers and use those timers to trigger watchdog keepalives while
  the watchdog device is not or not yet opened.
- A variant of this is the desire to enable a watchdog as soon as its driver
  has been instantiated, to protect the system while it is still booting up,
  but the watchdog daemon is not yet running.
- Some watchdogs have a very short maximum timeout, in the range of just a few
  seconds. Such low timeouts are difficult if not impossible to support from
  user space. Drivers supporting such watchdog hardware need to implement
  a timer function to augment heartbeats from user space.

This patch set solves the above problems while keeping changes to the
watchdog core minimal.

- A new status flag, WDOG_RUNNING, informs the watchdog subsystem that a
  watchdog is running, and that the watchdog subsystem needs to generate
  heartbeat requests while the associated watchdog device is closed.
- A new parameter in the watchdog data structure, max_hw_timeout_ms, informs
  the watchdog subsystem about a maximum hardware timeout. The watchdog
  subsystem uses this information together with the configured timeout
  and the maximum permitted timeout to determine if it needs to generate
  additional heartbeat requests.

Patch #1 is a preparatory patch.

Patch #2 adds timer functionality to the watchdog core. It solves the problem
of short maximum hardware timeouts by augmenting heartbeats triggered from
user space with internally triggered heartbeats.

Patch #3 adds functionality to generate heartbeats while the watchdog device is
closed. It handles situation where where the watchdog is running after
the driver has been instantiated, but the device is not yet opened,
and post-close situations necessary if a watchdog can not be stopped.

Patch #4 makes the set_timeout function optional. This is now possible since
timeout changes can now be completely handled in the watchdog core, for
example if the hardware watchdog timeout is fixed.

Patch #5 to #8 are example conversions of some watchdog drivers.
Those patches will require testing.

This patch set does not solve all limitations of the watchdog subsystem.
Specifically, it does not add support for the following features.

- It is desirable to be able to specify a maximum early timeout,
  from booting the system to opening the watchdog device.
- Some watchdogs may require a minimum period of time between
  heartbeats. Examples are DA9062 and possibly AT91SAM9x.

This and other features will be adddessed with subsequent patches.

The patch set is inspired by an earlier patch set from Timo Kokonnen.
