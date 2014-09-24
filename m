Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55726 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbaIXMfy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Sep 2014 08:35:54 -0400
Received: by mail-ie0-f171.google.com with SMTP id rd18so6639558iec.16
        for <linux-watchdog@vger.kernel.org>; Wed, 24 Sep 2014 05:35:54 -0700 (PDT)
Date: Wed, 24 Sep 2014 13:35:48 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	linux@roeck-us.net, lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, cooloney@gmail.com,
	rpurdie@rpsys.net, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 2/4] drivers/watchdog/menf21bmc_wdt: introduce MEN
 14F021P00 BMC Watchdog driver
Message-ID: <20140924123548.GE32069@lee--X1>
References: <cover.1409161615.git.andreas.werner@men.de>
 <f21b275c79866e0aa9bbc59e195ae5424e538300.1409161615.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <f21b275c79866e0aa9bbc59e195ae5424e538300.1409161615.git.andreas.werner@men.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 27 Aug 2014, Andreas Werner wrote:

> Added driver to support the 14F021P00 BMC Watchdog.
> The BMC is a Board Management Controller including watchdog functiona=
lity.
>=20
> Signed-off-by: Andreas Werner <andreas.werner@men.de>
> ---
>  drivers/watchdog/Kconfig         |  10 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/menf21bmc_wdt.c | 203 +++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/watchdog/menf21bmc_wdt.c

I see no reason to keep this dragging on.  I'm going to apply this
along with the remainder of the set and send a pull-request to all the
other Maintainers.  This branch is currently under test.

Any fix-ups for review comments can go in subsequently.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
