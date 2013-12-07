Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:50413 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3LGGxX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Dec 2013 01:53:23 -0500
Date: Sat, 7 Dec 2013 10:52:58 +0400
From: Alexander Shiyan <shc_work@mail.ru>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3] watchdog: GPIO-controlled watchdog
Message-Id: <20131207105258.b9597225842794cadd15e08f@mail.ru>
In-Reply-To: <1385798072-3886-1-git-send-email-shc_work@mail.ru>
References: <1385798072-3886-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 30 Nov 2013 11:54:32 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

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
...

Ping.

-- 
Alexander Shiyan <shc_work@mail.ru>
