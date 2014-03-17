Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:41462 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaCQTLG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Mar 2014 15:11:06 -0400
Message-ID: <532748C2.9030009@gmail.com>
Date: Mon, 17 Mar 2014 20:10:58 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
CC: Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/15/2014 07:17 PM, Ezequiel Garcia wrote:
> Fourth round of the patchset adding support for watchdog on Armada 375 and
> Armada 38x SoCs.
>
> The new Armada 375/385 SoCs have two registers for the watchdog RSTOUT:
>
>   1. It has a dedicated register (similar to the one in A370/XP)
>   2. Also has a bit in a shared RSTOUT register.
>
> Therefore, in order to support this two-folded RSTOUT, we extend the 'reg'
> property in the watchdog devicetree and require a new pair of cells to specify
> the shared RSTOUT.
>
> On the driver side, we need to implement per-SoC stop() and enabled()
> functions. Such somewhat complex infrastructure is needed to ensure the driver
> performs proper reset of the watchdog timer, by masking and disabling the
> RSTOUT before the interrupt is enabled.
>
> I've pushed a branch so people can test this easily, e.g. ensuring
> no regressions on Dove, Kirkwood and A370/XP:

Ezequiel,

Although, I just saw below that you actually already tested on Dove,
you can add my

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_a385_a375_v4
>
> Series based on today's mvebu for-next. Will send a rebased version on top of
> v3.15-rc1. Tested on A375-DB, A385-DB, A370-RD and Dove Cubox.

Sebastian

