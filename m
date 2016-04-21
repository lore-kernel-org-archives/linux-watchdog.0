Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34881 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcDUOwZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Apr 2016 10:52:25 -0400
Subject: Re: watchdoug group ping
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>,
	linux-watchdog@vger.kernel.org,
	"Dirk.Behme" <Dirk.Behme@de.bosch.com>
References: <57172B7C.4060407@de.bosch.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5718E924.2030103@roeck-us.net>
Date: Thu, 21 Apr 2016 07:52:20 -0700
MIME-Version: 1.0
In-Reply-To: <57172B7C.4060407@de.bosch.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/20/2016 12:10 AM, fixed-term.Oleksij.Rempel wrote:
> Hallo all,
>
> my target is to provide pretimout support for devices which do not have
> this functionality.
>
> Pre-requirement is this patchset (i contacted the author to rebase it
> against latest watchdog core branch):
> https://www.mail-archive.com/linux-watchdog@vger.kernel.org/msg02394.html
>
> The idea is to use different watchdogs/timers or what ever as one group
> - one virtual device.
> One driver will be responsible for reseting the system, other for
> generating an interrupt on pre-timout.
> It can be also useful for systems which require redundant watchdogs -
> two or more watchdog pinged over one /dev/watchdog
>
> I assume i would need to create a master virtual watchdog driver to
> bypass/broadcast all pings to child devices.
>
> Do you have some ideas or suggestions?
>
Seems to add a lot of complexity. It might be much simpler to add support
for a 'soft' pretimeout in such situations, ie a timer which fires at the
correct interval and results in a reset. It might even be possible to use
the new internal heartbeat function for this purpose.

Guenter

