Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33946 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaITPbC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 11:31:02 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVMco-0027ql-Bm
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 15:31:02 +0000
Message-ID: <541D9D94.2010400@roeck-us.net>
Date: Sat, 20 Sep 2014 08:30:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Subject: Re: [PATCH v3 2/4] ARM: meson: add watchdog driver
References: <1411158989-8075-1-git-send-email-carlo@caione.org> <1411158989-8075-3-git-send-email-carlo@caione.org>
In-Reply-To: <1411158989-8075-3-git-send-email-carlo@caione.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/19/2014 01:36 PM, Carlo Caione wrote:
> This patch adds the watchdog driver for the Amlogic Meson SoCs used also
> to reboot the device.
>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
[ ... ]
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +

Checkpatch says:

WARNING: quoted string split across lines
#295: FILE: drivers/watchdog/meson_wdt.c:231:
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Please fix.

Thanks,
Guenter

