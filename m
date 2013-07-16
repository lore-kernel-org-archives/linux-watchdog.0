Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:35555 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347Ab3GPHTV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 03:19:21 -0400
Date: Tue, 16 Jul 2013 08:59:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716065952.GA25043@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 15, 2013 at 08:32:33PM -0300, Ezequiel Garcia wrote:
> This patchset introduces a bunch of fixes that removes the direct use of
> the shared timer control register, and also removes the need to include
> a mach-specific header.
> 
> With this changes the driver can be included in multiplatforms builds,
> and in particular be used for the Armada 370/XP SoC.

Hi Ezequiel

Maybe i'm missing something here. You are making use of
orion_timer_ctrl_clrset() from time-orion.c. How will this work on
370/XP which has a different clocksource driver?

Thanks
	Andrew
