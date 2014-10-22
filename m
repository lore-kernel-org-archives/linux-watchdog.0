Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52760 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752057AbaJVNyN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:54:13 -0400
Date: Wed, 22 Oct 2014 15:54:10 +0200
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
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 3/4] clocksource: armada-370-xp: Use the reference clock
 on A375 SoC
Message-ID: <20141022155410.0cc36e4c@free-electrons.com>
In-Reply-To: <1413984884-20273-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1413984884-20273-4-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 10:34:43 -0300, Ezequiel Garcia wrote:

> +static void __init armada_375_timer_init(struct device_node *np)
> +{
> +	struct clk *clk;
> +
> +	clk = of_clk_get_by_name(np, "fixed");
> +	if (!IS_ERR(clk)) {
> +		clk_prepare_enable(clk);
> +		timer_clk = clk_get_rate(clk);
> +	} else {
> +
> +		/*
> +		 * This fallback is required in order to retain proper
> +		 * devicetree backwards compatibility.
> +		 */
> +		clk = of_clk_get(np, 0);
> +
> +		/* Must have at least a clock */
> +		BUG_ON(IS_ERR(clk));
> +		clk_prepare_enable(clk);
> +		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
> +		timer25Mhz = false;
> +	}

Maybe we could re-use a bit more existing code, don't know if it makes
things clearer though:

	clk = of_clk_get_by_name(np, "fixed");
	if (!IS_ERR(clk))
		armada_xp_timer_init(np);
	else
		armada_370_timer_init(np);

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
