Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:57749 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751878AbbCETlg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 14:41:36 -0500
Message-ID: <1425584493.24292.236.camel@x220>
Subject: Re: [PATCH v4 6/9] ARM: at91: time: move the system timer driver to
 drivers/clocksource
From: Paul Bolle <pebolle@tiscali.nl>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Date: Thu, 05 Mar 2015 20:41:33 +0100
In-Reply-To: <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 2015-03-05 at 16:49 +0100, Alexandre Belloni wrote:
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 1c2506f68122..d1d15985a4ec 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -138,6 +138,10 @@ config ATMEL_PIT
>  	select CLKSRC_OF if OF
>  	def_bool SOC_AT91SAM9 || SOC_SAMA5
>  
> +config ATMEL_ST
> +	select CLKSRC_OF if OF
> +	def_bool SOC_AT91RM9200

If you swap these two lines you'll make the set of people that probably
only includes me a bit happier.

> +
>  config CLKSRC_METAG_GENERIC
>  	def_bool y if METAG
>  	help

Thanks,


Paul Bolle

