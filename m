Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57189 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbH2Tcr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Aug 2015 15:32:47 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 0/9] watchdog: Add support for keepalives triggered by infrastructure
Date: Sat, 29 Aug 2015 12:32:29 -0700
Message-Id: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
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

As part of this patchset, the semantics of the 'timeout' variable and of
the WDOG_ACTIVE flag are changed slightly.

Per the current watchdog kernel API, the 'timeout' variable is supposed
to reflect the actual hardware watcdog timeout. WDOG_ACTIVE is supposed
to reflect if the hardware watchdog is running or not.

Unfortunately, this does not always reflect reality. In drivers which solve
the above mentioned problems internally, 'timeout' is the watchdog timeout
as seen from user space, and WDOG_ACTIVE reflects that user space is expected
to send keepalive requests to the watchdog driver.

After this patch set is applied, this so far inofficial interpretation
is the 'official' semantics for the timeout variable and the WDOG_ACTIVE
flag. In other words, both values no longer reflect the hardware watchdog
status, but its status as seen from user space.

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

Patch #9 adds code to unconditionally ensure that the minimum timeout meets
the constraints provided by the watchdog driver.

The patch set is also available in branch watchdog-timer of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.

This patch set does not solve all limitations of the watchdog subsystem.
Specifically, it does not add support for the following features.

- It is desirable to be able to specify a maximum early timeout,
  from booting the system to opening the watchdog device.
- Some watchdogs may require a minimum period of time between
  heartbeats. Examples are DA9062 and possibly AT91SAM9x.

This and other features will be addressed with subsequent patches.

The patch set is inspired by an earlier patch set from Timo Kokonnen.

v3:
- Rebased to v4.2-rc8
- Reworked and cleaned up some of the functions.
- No longer call the worker update function if all that is needed is to stop
  the worker.
- max_timeout will now be ignored if max_hw_timeout_ms is provided.
- Added patch 9/9.
v2:
- Rebased to v4.2-rc5
- Improved and hopefully clarified documentation.
- Rearranged variables in struct watchdog_device such that internal variables
  come last.
- The code now ensures that the watchdog times out <timeout> seconds after
  the most recent keepalive sent from user space.
- The internal keepalive now stops silently and no longer generates a
  warning message. Reason is that it will now stop early, while there
  may still be a substantial amount of time for keepalives from user space
  to arrive. If such keepalives arrive late (for example if user space
  is configured to send keepalives just a few seconds before the watchdog
  times out), the message would just be noise and not provide any value.
