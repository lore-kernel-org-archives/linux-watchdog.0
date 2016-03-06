Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:48863 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751230AbcCFKuA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Mar 2016 05:50:00 -0500
Date: Sun, 6 Mar 2016 11:49:56 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v8 0/10] watchdog: Add support for keepalives triggered by infrastructure
Message-ID: <20160306104956.GA2282@spo001.leaseweb.nl>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> The watchdog infrastructure is currently purely passive, meaning
> it only passes information from user space to drivers and vice versa.
> 
> Since watchdog hardware tends to have its own quirks, this can result
> in quite complex watchdog drivers. A number of scanarios are especially common.
> 
> - A watchdog is always active and can not be disabled, or can not be disabled
>   once enabled. To support such hardware, watchdog drivers have to implement
>   their own timers and use those timers to trigger watchdog keepalives while
>   the watchdog device is not or not yet opened.
> - A variant of this is the desire to enable a watchdog as soon as its driver
>   has been instantiated, to protect the system while it is still booting up,
>   but the watchdog daemon is not yet running.
> - Some watchdogs have a very short maximum timeout, in the range of just a few
>   seconds. Such low timeouts are difficult if not impossible to support from
>   user space. Drivers supporting such watchdog hardware need to implement
>   a timer function to augment heartbeats from user space.
> 
> This patch set solves the above problems while keeping changes to the
> watchdog core minimal.
> 
> - A new status flag, WDOG_HW_RUNNING, informs the watchdog subsystem that
>   a watchdog is running, and that the watchdog subsystem needs to generate
>   heartbeat requests while the associated watchdog device is closed.
> - A new parameter in the watchdog data structure, max_hw_heartbeat_ms, informs
>   the watchdog subsystem about a maximum hardware heartbeat. The watchdog
>   subsystem uses this information together with the configured timeout
>   and the maximum permitted timeout to determine if it needs to generate
>   additional heartbeat requests.
> 
> As part of this patchset, the semantics of the 'timeout' variable and of
> the WDOG_ACTIVE flag are changed slightly.
> 
> Per the current watchdog kernel API, the 'timeout' variable is supposed
> to reflect the actual hardware watchdog timeout. WDOG_ACTIVE is supposed
> to reflect if the hardware watchdog is running or not.
> 
> Unfortunately, this does not always reflect reality. In drivers which solve
> the above mentioned problems internally, 'timeout' is the watchdog timeout
> as seen from user space, and WDOG_ACTIVE reflects that user space is expected
> to send keepalive requests to the watchdog driver.
> 
> After this patch set is applied, this so far inofficial interpretation
> is the 'official' semantics for the timeout variable and the WDOG_ACTIVE
> flag. In other words, both values no longer reflect the hardware watchdog
> status, but its status as seen from user space.
> 
> Patch #1 makes the set_timeout function optional.
> 
> Patch #2 adds timer functionality to the watchdog core. It solves the problem
> of short maximum hardware heartbeats by augmenting heartbeats triggered from
> user space with internally triggered heartbeats.
> 
> Patch #3 adds functionality to generate heartbeats while the watchdog device
> is closed. It handles situation where where the watchdog is running after
> the driver has been instantiated, but the device is not yet opened,
> and post-close situations necessary if a watchdog can not be stopped.
> 
> Patch #4 makes the stop function optional.
> 
> Patch #5 adds code to ensure that the minimum time between heartbeats meets
> constraints provided by the watchdog driver.
> 
> Patch #6 to #10 are example conversions of some watchdog drivers.
> Out of those, patches #6 (dw_wdt) and #7 (imx2) have been tested.
> Patches #8 to #10 will require testing and are marked as RFT.
> 
> The patch series is also available in branch watchdog-timer of
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.
> The series is curently based on top of v4.5-rc5.
> 
> The patch series was inspired by an earlier patch set from Timo Kokonnen.
> 
> v8:
> - max_hw_timeout_ms -> max_hw_heartbeat_ms
> - Rebased to v4.5-rc5
> - The patch to make the set_timeout function optional is now the first
>   patch of the series.
> - Separate code making the stop function optional into a separate patch.
> - Dropped all Acked-by: and Tested-by: tags. Even though there are no
>   functional changes, I concluded that the changes are too substantial
>   to warrant maintaining previously provided tags.
>   Note: while the patch series was rearranged, correctness was ensured
>   by implementing the max_hw_timeout_ms -> max_hw_heartbeat_ms changes
>   separately on top of the original series and comparing the results.
> v7:
> - Rebased to v4.5-rc1.
> - Moved new variables to local data structure
> - Fixed typos in documentation (hw_max_timeout_ms -> max_hw_timeout_ms).
> - Enforce that max_hw_timeout_ms must be set if the stop function is
>   not implemented by a driver.
> - Set max_hw_timeout_ms in converted drivers.
> v6:
> - Added patch #9, converting the dw_wdt driver.
> - Set last_keepalive more accurately when starting the watchdog.
> - Rebased to v4.4-rc2.
> - Renamed WDOG_RUNNING to WDOG_HW_RUNNING and watchdog_running() to
>   watchdog_hw_running().
> v5:
> - Patches #1 and #2 of the original patch series are now in mainline
>   and have been dropped.
> - Rebased to v4.4-rc1. 
> - Added patch to simplify watchdog_update_worker().
> v4:
> - Rebased to v4.3-rc3
> - Rearranged patch sequence
> - Dropped gpio driver patch. The driver was changed since v4.2,
>   and merging the changes turned out to be too difficult.
> - Various other cleanups as listed in individual patches
> v3:
> - Rebased to v4.2-rc8
> - Reworked and cleaned up some of the functions.
> - No longer call the worker update function if all that is needed is to stop
>   the worker.
> - max_timeout will now be ignored if max_hw_timeout_ms is provided.
> - Added patch 9/9.
> v2:
> - Rebased to v4.2-rc5
> - Improved and hopefully clarified documentation.
> - Rearranged variables in struct watchdog_device such that internal variables
>   come last.
> - The code now ensures that the watchdog times out <timeout> seconds after
>   the most recent keepalive sent from user space.
> - The internal keepalive now stops silently and no longer generates a
>   warning message. Reason is that it will now stop early, while there
>   may still be a substantial amount of time for keepalives from user space
>   to arrive. If such keepalives arrive late (for example if user space
>   is configured to send keepalives just a few seconds before the watchdog
>   times out), the message would just be noise and not provide any value.

Patches 1 till 7 of this series has been added to linux-watchdog-next.

Kind regards,
Wim.

