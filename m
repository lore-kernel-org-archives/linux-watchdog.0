Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53270 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbaJWPYb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Oct 2014 11:24:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
	wim@iguana.be, linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	David Paris <david.paris@st.com>, kernel@stlinux.com
Subject: Re: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
Date: Thu, 23 Oct 2014 17:23:55 +0200
Message-ID: <8501493.uUGsNVQOhe@wuerfel>
In-Reply-To: <1414077524-6469-5-git-send-email-lee.jones@linaro.org>
References: <1414077524-6469-1-git-send-email-lee.jones@linaro.org> <1414077524-6469-5-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 23 October 2014 16:18:44 Lee Jones wrote:
> +config ST_WATCHDOG
> +       tristate "STMicroelectronics LPC Watchdog"
> +       depends on ARCH_STI && OF
> +       depends on !RTC_DRV_ST_LPC
> +       select WATCHDOG_CORE
> +       help
> +        Say Y here to include Watchdog timer support for the watchdog
> +        existing in the LPC of STMicroelectronics SOCs.
> +        !!! BE CARREFUL !!!
> +        This driver shares hardware resources with RTC Alarm part of the
> +        LPC. Both LPC Watchdog driver and LPC RTC driver cannot be
> +        used together.
> +
> +        To compile this driver as a module, choose M here: the
> +        module will be called st-wdt.
> +
> 

How is this ensured by the code? Do both drivers try to bind to the
same device node? Would it make more sense to have a single driver
that registers both to the rtc and the watchdog subsystems?

	Arnd
