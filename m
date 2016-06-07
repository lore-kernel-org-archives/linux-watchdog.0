Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52417 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbcFGNW4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 09:22:56 -0400
Subject: Re: [PATCH] watchdog: sirf: fix __iomem * warnings
To: Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk
References: <1465300387-20629-1-git-send-email-ben.dooks@codethink.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Barry Song <baohua@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5756CA9B.8090200@roeck-us.net>
Date: Tue, 7 Jun 2016 06:22:35 -0700
MIME-Version: 1.0
In-Reply-To: <1465300387-20629-1-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/07/2016 04:53 AM, Ben Dooks wrote:
> Fix the following warnings from sparse due to casting to/from an __iomem
> annotated variable:
>
> drivers/watchdog/sirfsoc_wdt.c:48:18: warning: incorrect type in assignment (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:48:18:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:48:18:    got void *
> drivers/watchdog/sirfsoc_wdt.c:64:18: warning: incorrect type in assignment (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:64:18:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:64:18:    got void *
> drivers/watchdog/sirfsoc_wdt.c:82:54: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:82:54:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:82:54:    got void *
> drivers/watchdog/sirfsoc_wdt.c:99:54: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:99:54:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:99:54:    got void *
> drivers/watchdog/sirfsoc_wdt.c:153:44: warning: incorrect type in argument 2 (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:153:44:    expected void *data
> drivers/watchdog/sirfsoc_wdt.c:153:44:    got void [noderef] <asn:2>*[assigned] base
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

