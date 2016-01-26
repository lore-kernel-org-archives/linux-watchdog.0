Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60212 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755631AbcAZIJJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 03:09:09 -0500
Date: Tue, 26 Jan 2016 09:09:04 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <patchwork@patchwork.roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 0/9] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20160126080904.GV3338@pengutronix.de>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On Mon, Jan 25, 2016 at 06:53:07PM -0800, Guenter Roeck wrote:
> Patch #1 adds timer functionality to the watchdog core. It solves the problem
> of short maximum hardware timeouts by augmenting heartbeats triggered from
> user space with internally triggered heartbeats.
> 
> Patch #2 adds functionality to generate heartbeats while the watchdog device
> is closed. It handles situation where where the watchdog is running after
> the driver has been instantiated, but the device is not yet opened,
> and post-close situations necessary if a watchdog can not be stopped.
> 
> Patch #3 makes the set_timeout function optional. This is now possible since
> timeout changes can now be completely handled in the watchdog core, for
> example if the hardware watchdog timeout is fixed.
> 
> Patch #4 adds code to ensure that the minimum time between heartbeats meets
> constraints provided by the watchdog driver.
> 
> Patch #5 simplifies the watchdog_update_worker() function introduced with
> patch #1 to only take a single argument, and to always cancel any pending
> work if a worker is not or no longer needed. This patch is kept as separate
> patch on purpose, to enable dropping or reverting it easily if it causes
> any problems. It should not cause any problems; this is just out of an
> abundance of caution.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> for patches
1-5.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
