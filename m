Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:60960 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751971Ab1KWMQp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Nov 2011 07:16:45 -0500
Date: Wed, 23 Nov 2011 13:13:29 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Marc Vertes <marc.vertes@sigfox.com>,
	broonie@opensource.wolfsonmicro.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	HaraldWelte@viatech.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <20111123121329.GM23376@infomag.iguana.be>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com> <20111122112212.GD2734@pengutronix.de> <4ecbd66c.8a87vIwdu0Z+quuZ%marc.vertes@sigfox.com> <20111122173227.GK6624@sirena.org.uk> <20111122184051.GA30941@pengutronix.de> <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com> <20111123104926.GB4063@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111123104926.GB4063@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> @Wim: Would you accept drivers which can only ping a watchdog but
> neither start/stop it?

Will look the driver in more detail later this week.

To answer this question though: Userspace needs to be able to stop
and start watchdog devices. That's why we have the solution with the
timer. I will look up the example that I created in the past (as part
of the documentation) and add it to linux-next (so that it is available
as an example for everyone) and either sent it to Marc or sent Marc an
updated version of his code so that he can test it.

Bottom line: Yes, there is hardware available that can only be pinged
and not be stopped, but No, Userspace needs the start/stop and ping
functionality so that a watchdog daemon can work correctly (which is
important because some watchdog daemons also do application testing.

I prefer to add this driver first with the timer build into the driver.
We should indeed think about putting the timer in the framework, but
we need to think about how we can do this when we have multiple devices
(where some need it and others don't). The roadmap should be first
multiple devices and then the timer so that we don't create an extra
hurdle for the future.

Marc: I hope to sent you something still today.

Kind regards,
Wim.

