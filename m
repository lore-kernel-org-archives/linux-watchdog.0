Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 0/8] watchdog: Add support for keepalives triggered by infrastructure
Date: Sun, 22 Nov 2015 19:20:57 -0800
Message-Id: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

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

Patch #1 adds timer functionality to the watchdog core. It solves the problem
of short maximum hardware timeouts by augmenting heartbeats triggered from
user space with internally triggered heartbeats.

Patch #2 adds functionality to generate heartbeats while the watchdog device is
closed. It handles situation where where the watchdog is running after
the driver has been instantiated, but the device is not yet opened,
and post-close situations necessary if a watchdog can not be stopped.

Patch #3 makes the set_timeout function optional. This is now possible since
timeout changes can now be completely handled in the watchdog core, for
example if the hardware watchdog timeout is fixed.

Patch #4 adds code to unconditionally ensure that the minimum timeout meets
constraints provided by the watchdog driver.

Patch #5 simplifies the watchdog_update_worker() function introduced with
patch #1 to only take a single argument, and always cancel any pending work
if a worker is not or no longer needed. This patch is kept as separate
patch on purpose, to enable dropping or reverting it easily if it causes
any problems. It should not cause any problems; this is just out of an
abundance of caution.

Patch #6 to #8 are example conversions of some watchdog drivers.
Those patches will require testing and are marked as RFT.

The patch set is also available in branch watchdog-timer of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.
In this branch, the series is rebased on top of the watchdog-next branch
in the same repository. This was done since other pending changes in the
watchdog subsystem cause merge conflicts, and we want to be able to test
all pending changes together.

The patch set was inspired by an earlier patch set from Timo Kokonnen.

v5:
- Patches #1 and #2 of the original patch series are now in mainline
  and have been dropped.
- Rebased to v4.4-rc1. 
- Added patch to simplify watchdog_update_worker().
v4:
- Rebased to v4.3-rc3
- Rearranged patch sequence
- Dropped gpio driver patch. The driver was changed since v4.2,
  and merging the changes turned out to be too difficult.
- Various other cleanups as listed in individual patches
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
