Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33555 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab3GPHVE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 03:21:04 -0400
Date: Tue, 16 Jul 2013 09:20:59 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org, wim@iguana.be,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716092059.237ea729@skate>
In-Reply-To: <20130716065952.GA25043@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20130716065952.GA25043@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Andrew Lunn,

On Tue, 16 Jul 2013 08:59:52 +0200, Andrew Lunn wrote:

> Maybe i'm missing something here. You are making use of
> orion_timer_ctrl_clrset() from time-orion.c. How will this work on
> 370/XP which has a different clocksource driver?

I *think* the idea is that the Armada 370/XP driver will expose the
same function, so from the point of view of the watchdog driver, it
will just work. This set of patches is just some preparation patches on
the Orion watchdog driver, to later make it usable on Armada 370/XP.
The patches enabling its usage on Armada 370/XP will follow.

But Ezequiel will confirm all that, we had a discussion together about
this yesterday, so I guess what I said should be the plan, but it's
better if Ezequiel confirms, obviously :)

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
