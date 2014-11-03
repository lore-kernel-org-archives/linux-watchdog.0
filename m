Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54705 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752326AbaKCQvQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Nov 2014 11:51:16 -0500
Message-ID: <5457B279.5060106@free-electrons.com>
Date: Mon, 03 Nov 2014 17:51:05 +0100
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] clocksource: armada-370-xp: Use the reference
 clock on A375 SoC
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com> <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Ezequiel,

On 25/10/2014 16:48, Ezequiel Garcia wrote:
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
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
