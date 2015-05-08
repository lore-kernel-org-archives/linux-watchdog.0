Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb3-smtp-cloud3.xs4all.net ([194.109.24.30]:50473 "EHLO
	lb3-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303AbbEHKKD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 06:10:03 -0400
Message-ID: <1431079797.13593.28.camel@x220>
Subject: Re: [PATCH 02/12] clocksource: sti: Provide support for the ST LPC
 Clocksource IP
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Date: Fri, 08 May 2015 12:09:57 +0200
In-Reply-To: <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
	 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig

> +config CLKSRC_ST_LPC
> +	bool
> +	depends on ARCH_STI

By itself this does nothing. You can't set this symbol to 'y', even if
ARCH_STI is 'y', right? Of course, ARCH_STI will select this symbol (see
11/12) otherwise it would be inert. But as ARCH_STI selects
CLKSRC_ST_LPC I'd say this dependency isn't actually needed.

Are other selects of CLKSRC_ST_LPC expected to be added in the future?
If not, CLKSRC_ST_LPC should operate in lockstep with ARCH_STI. In that
case you might as well not bother with CLKSRC_ST_LPC and use ARCH_STI
directly. (But that forces you to move the select statement below into
the ARCH_STI entry, which might be ugly.)

> +	select CLKSRC_OF if OF
> +	help
> +	  Enable this option to use the Low Power controller timer
> +	  as clocksource.

(Please add an empty line.)

>  endmenu

Thanks,


Paul Bolle

