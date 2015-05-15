Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58528 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161137AbbEONUJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 09:20:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Timur Tabi <timur@codeaurora.org>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
Date: Fri, 15 May 2015 15:20:02 +0200
Message-ID: <3313221.o1XjNEFgtv@wuerfel>
In-Reply-To: <5555E310.7040009@codeaurora.org>
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <5740260.iFKebBHUuJ@wuerfel> <5555E310.7040009@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 15 May 2015 07:14:08 Timur Tabi wrote:
> Arnd Bergmann wrote:
> > Then please remove the double-swap. If the device works like any other
> > device in the system, then the byteswap that is implied by readl/writel
> > will do the right thing, and swapping twice will break big-endian
> > kernels.
> 
> Should I still keep the __le32 in the structs?

Not sure about that. Most people use offsets with a void * pointer,
so they would not care.

Do you get a sparse warning if you either leave the __le32, or if you
turn it into u32? The correct behavior is probably to leave __le32
here, and ensure that readl() produces a sparse warning when fed with
a pointer to u32, but not void* or __le32*. It would need some
experimenting to find if that catches real bugs or just starts warning
about correct code and not about incorrect code.

FWIW, the drivers you cited that use le32_to_cpu(readl(p)) are probably
all wrong, and it would be nice to have a sparse warning for that.

	Arnd
