Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19524 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaKAXIk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Nov 2014 19:08:40 -0400
Date: Sat, 1 Nov 2014 19:08:24 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 3/4] clocksource: armada-370-xp: Use the reference
 clock on A375 SoC
Message-ID: <20141101230824.GJ3698@titan.lakedaemon.net>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Daniel,

On Sat, Oct 25, 2014 at 11:48:41AM -0300, Ezequiel Garcia wrote:
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

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
