Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64610 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbEOS5y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 14:57:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Timur Tabi <timur@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Linaro-acpi] [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
Date: Fri, 15 May 2015 20:57:45 +0200
Message-ID: <6745558.xPJvXDnxj5@wuerfel>
In-Reply-To: <55561CF1.9090308@codeaurora.org>
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <3313221.o1XjNEFgtv@wuerfel> <55561CF1.9090308@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 15 May 2015 11:21:05 Timur Tabi wrote:
> On 05/15/2015 08:20 AM, Arnd Bergmann wrote:
> 
> > Do you get a sparse warning if you either leave the __le32, or if you
> > turn it into u32?
> 
> After removing the cpu_to_le32 calls, but keeping the __le32 in the 
> structs, I get no sparse warnings on my driver.

Ok, good. I've also checked the readl() definition and found that it
has a (__force __le32) cast, while __raw_readl() takes a const volatile
void __iomem *addr) pointer, so it sparse won't warn either way, but
that's probably ok.


	Arnd
