Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42392 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758758AbaJaNHs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Oct 2014 09:07:48 -0400
Date: Fri, 31 Oct 2014 14:07:35 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 0/4] Make Armada 375 use the reference clock when
 possible
Message-ID: <20141031140735.76d46212@free-electrons.com>
In-Reply-To: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Sat, 25 Oct 2014 11:48:38 -0300, Ezequiel Garcia wrote:

> Ezequiel Garcia (4):
>   clocksource: armada-370-xp: Add missing clock enable
>   watchdog: orion: Use the reference clock on Armada 375 SoC
>   clocksource: armada-370-xp: Use the reference clock on A375 SoC
>   ARM: mvebu: Enable the reference clock for timer and watchdog on
>     Armada 375 SoC
> 
>  .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
>  .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
>  arch/arm/boot/dts/armada-375.dtsi                  | 12 +++++--
>  drivers/clocksource/time-armada-370-xp.c           | 30 ++++++++++++++++
>  drivers/watchdog/orion_wdt.c                       | 40 +++++++++++++++++++++-
>  5 files changed, 98 insertions(+), 6 deletions(-)

For the entire series:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I've tested on an Armada 375 A0 platform. Before this series, due to
the SSCG, I had a lot of drift in the system time. With this series,
the platform now uses the 25 Mhz timer not affected by the SSCG, and
I'm no longer experiencing any drift.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
