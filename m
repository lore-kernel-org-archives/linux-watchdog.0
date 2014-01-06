Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:50690 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756184AbaAFVLA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Jan 2014 16:11:00 -0500
Date: Mon, 6 Jan 2014 22:10:58 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3] watchdog: GPIO-controlled watchdog
Message-ID: <20140106211058.GA16886@spo001.leaseweb.com>
References: <1385798072-3886-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1385798072-3886-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> This patch adds a watchdog driver for devices controlled through GPIO,
> (Analog Devices ADM706, Maxim MAX823, National NE555 etc).
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/watchdog/gpio-wdt.txt      |  23 ++
>  drivers/watchdog/Kconfig                           |   8 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/gpio_wdt.c                        | 254 +++++++++++++++++++++
>  4 files changed, 286 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>  create mode 100644 drivers/watchdog/gpio_wdt.c

Patch added to linux-watchdog-next.

Kind regards,
Wim.

