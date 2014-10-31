Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42365 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758615AbaJaNG1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Oct 2014 09:06:27 -0400
Date: Fri, 31 Oct 2014 14:06:12 +0100
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
Subject: Re: [PATCH v2 3/4] clocksource: armada-370-xp: Use the reference
 clock on A375 SoC
Message-ID: <20141031140612.0818eae6@free-electrons.com>
In-Reply-To: <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Sat, 25 Oct 2014 11:48:41 -0300, Ezequiel Garcia wrote:
> The 25 MHz reference clock has better stability so its use is preferred over the
> core clock.
> 
> This commit takes advantage of the already introduced Armada 375 devicetree
> compatible string and adds a new timer initialization. If available, the timer
> will use the reference clock (named as 'fixed'). Otherwise, it falls back to the
> previous behavior.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 ++++---
>  drivers/clocksource/time-armada-370-xp.c           | 28 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
