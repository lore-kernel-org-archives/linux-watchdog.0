Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35883 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227AbbEVPBv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 11:01:51 -0400
Date: Fri, 22 May 2015 08:01:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, vgandhi@codeaurora.org, wim@iguana.be,
	jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150522150145.GA2930@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-7-git-send-email-fu.wei@linaro.org>
 <555F4236.7040206@linaro.org>
 <4095167.UOriXdSu53@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4095167.UOriXdSu53@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 22, 2015 at 04:55:04PM +0200, Arnd Bergmann wrote:
> On Friday 22 May 2015 22:50:30 Hanjun Guo wrote:
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index e5e7c55..25a0df1 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -152,6 +152,18 @@ config ARM_SP805_WATCHDOG
> > >         ARM Primecell SP805 Watchdog timer. This will reboot your system when
> > >         the timeout is reached.
> > >
> > > +config ARM_SBSA_WATCHDOG
> > > +     tristate "ARM SBSA Generic Watchdog"
> > > +     depends on ARM || ARM64 || COMPILE_TEST
> > 
> > SBSA is for ARMv8-A based (64-bit) servers, no need to depends on ARM,
> > and why we depends on COMPILE_TEST?
> > 
> 
> I think it's a reasonable assumption that someone will sooner or later
> put that hardware into an ARM32 machine, or run a 32-bit kernel on
> a chip that has it.
> 
> While SBSA requires this watchdog device, nothing prevents SoC
> manufacturers from using the same design in something that is not
> a server.
> 
Tricky, though. Since teh driver uses arm specific clock functions,
I don't think this can compile on a non-arm machine.

Guenter
