Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33144 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755397Ab3IPMAP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Sep 2013 08:00:15 -0400
Date: Mon, 16 Sep 2013 14:00:01 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Arnd Bergmann <arnd@arndb.de>,
	Domenico Andreoli <domenico.andreoli@linux.com>,
	Olof Johansson <olof@lixom.net>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
Message-ID: <20130916120001.GE401@spo001.leaseweb.com>
References: <20130914152032.401907974@gmail.com> <201309152009.26462.arnd@arndb.de> <20130915185220.GA32054@glitch> <201309152210.36738.arnd@arndb.de> <20130916071821.GA18210@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130916071821.GA18210@glitch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> On Sun, Sep 15, 2013 at 10:10:36PM +0200, Arnd Bergmann wrote:
> > On Sunday 15 September 2013, Domenico Andreoli wrote:
> > > issue here is that there is already a proper watchdog driver, the sp805.
> > > 
> > > so I guess now the task shifts to adding restart hook support to it, right?
> > 
> > Yes, correct.
> > 
> > There is an interesting question however: we have to deal with the same driver
> > being used in some machines that need to use it as the only way to reset the
> > system, as well as the case where you actually want to use some other method.
> 
> in a certain sense, there is space for a generic watchdog based restart
> hook mechanism but the current watchdog ops do not provide the necessary
> guarantees in atomic context.

I remember that the Cobalt Devices have no ability to reboot themselves.
That's why the driver uses the reboot_notifier for rebooting the device.
See drivers/watchdog/alim7101_wdt.c .

I'll have a look to have an extra ops that adds this functionality in the framework.

Kind regards,
Wim.

