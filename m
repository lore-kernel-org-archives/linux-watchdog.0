Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61127 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbEOJQy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 05:16:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
Date: Fri, 15 May 2015 11:16:47 +0200
Message-ID: <5740260.iFKebBHUuJ@wuerfel>
In-Reply-To: <5555347D.7050106@codeaurora.org>
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <55553291.3050009@roeck-us.net> <5555347D.7050106@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 14 May 2015 18:49:17 Timur Tabi wrote:
> Guenter Roeck wrote:
> >
> > We still don't know if the registers are in host byte order or in little
> > endian
> > order. If registers are in host byte order, there is no need for a
> > conversion.
> 
> Well, if I compile and boot a big-endian ARM64 kernel, then I don't 
> expect the hardware devices to magically switch all their registers into 
> big endian.  The devices will remain little-endian.
> 
> I presume that this is true on all ARM and ARM64 systems.  Switching the 
> CPU into big-endian mode (when it normally would run in little-endian) 
> does not also switch the hardware registers.
> 
> Therefore, if we want to support big-endian kernels on ARM64, then every 
> readl/writel in every driver must use cpu_to_le32/etc.
> 
> I think this conversation has gone off-track.  I don't see how the SBSA 
> watchdog device is any different from any other device on an ARM64 platform.
> 
> I think it's safe to say that the endian order is not specified 
> anywhere, but on my hardware, everything is little-endian.

Then please remove the double-swap. If the device works like any other
device in the system, then the byteswap that is implied by readl/writel
will do the right thing, and swapping twice will break big-endian
kernels.

	Arnd
