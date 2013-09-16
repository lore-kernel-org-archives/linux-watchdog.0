Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52886 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab3IPIpY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Sep 2013 04:45:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
Date: Mon, 16 Sep 2013 10:45:16 +0200
Cc: Domenico Andreoli <domenico.andreoli@linux.com>,
	Olof Johansson <olof@lixom.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
References: <20130914152032.401907974@gmail.com> <201309152210.36738.arnd@arndb.de> <20130916071821.GA18210@glitch>
In-Reply-To: <20130916071821.GA18210@glitch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201309161045.17069.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 16 September 2013, Domenico Andreoli wrote:
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

It sounds like a good idea. I see another problem there, which is that registering
a restart hook is architecture specific at the moment, so it would also require
generalizing that, or alternatively keeping watchdog based restart specific to
ARM and any architecture that adds support in a similar way.

> > An easy way to handle this would be a boolean device tree property that
> > tells the driver whether or not to register, but we might want to
> > come up with a more sophisticated way to have multiple reset handlers
> > registered an prioritized so we try the "best" one first. Maybe someone
> > else has an opinion on this. If not, just do the property.
> 
> the simplest solution I see is adding a DT option to the sp805 driver so
> that it registers the restart hook when asked to do so.
> 
> need to investigate whether the sp805 DT support is provided by some generic
> AMBA mechanism or is completely missing.

I think it should just work if you put the right properties into DT: it only
uses one memory resource (from "reg" property) and one clk (from "clocks"
property), and those are automatically there for AMBA devices. If the hardware
does not fill the correct primecell ID, you may have to add a
"arm,primecell-periphid=<0x00141805>" property.

	Arnd
