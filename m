Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56127 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbbELPzW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 May 2015 11:55:22 -0400
Date: Tue, 12 May 2015 17:55:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lee Jones <lee.jones@linaro.org>
cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
	wim@iguana.be, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	linux@roeck-us.net, kernel@stlinux.com
Subject: Re: [PATCH v2 02/12] clocksource: sti: Provide support for the ST
 LPC Clocksource IP
In-Reply-To: <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
Message-ID: <alpine.DEB.2.11.1505121751560.4225@nanos>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org> <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 12 May 2015, Lee Jones wrote:
> +static void st_clksrc_reset(void)

__init

> +static int st_clksrc_setup_clk(struct device_node *np)

__init

> +static void __init st_clksrc_of_register(struct device_node *np)
> +{
> +	int ret;
> +	uint32_t mode;
> +
> +	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> +	if (ret) {
> +		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
> +		return;
> +	}
> +
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> +	if (mode != ST_LPC_MODE_CLKSRC)
> +		return;
> +
> +	ddata.base = of_iomap(np, 0);
> +	if (!ddata.base) {
> +		pr_err("clksrc-st-lpc: Unable to map iomem\n");
> +		return;
> +	}
> +
> +	if (st_clksrc_setup_clk(np)) {
> +		iounmap(ddata.base);
> +		return;
> +	}
> +
> +	if (st_clksrc_init()) {

Keeps the clock enabled.

> +		iounmap(ddata.base);
> +		return;

Thanks,

	tglx
