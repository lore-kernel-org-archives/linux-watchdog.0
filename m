Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60759 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbaITCvG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 22:51:06 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVAlO-003fC3-18
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 02:51:06 +0000
Message-ID: <541CEB71.5060800@roeck-us.net>
Date: Fri, 19 Sep 2014 19:50:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Subject: Re: [PATCH v3 0/4] ARM: meson: watchdog driver
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
In-Reply-To: <1411158989-8075-1-git-send-email-carlo@caione.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/19/2014 01:36 PM, Carlo Caione wrote:
> This patchset adds support for the watchdog found on Amlogic MesonX SoCs. The
> watchdog is used also to reboot the device.
>
> DTSI and multi_v7_defconfig are updated and proper documentation is added.
>
> No documentation is provided by Amlogic, the code is reverse-engineered by the
> code available at http://openlinux.amlogic.com:8000/download/
>
> This patchset depends on:
> [1] [PATCH 0/6] ARM: meson: initial support for MesonX SoCs
> [2] [PATCH 0/2] ARM: meson: add clocksource support
>
> Changes since v2:
> * changed compatible to "amlogic,meson6-wdt"
> * removed useless code
> * code refactored
>
> Changes since v1:
> * added restart handler support
>
> [1] http://www.spinics.net/lists/arm-kernel/msg362521.html
> [2] http://www.spinics.net/lists/arm-kernel/msg362483.html
>
> Carlo Caione (4):
>    ARM: docs: add documentation binding for meson watchdog
>    ARM: meson: add watchdog driver
>    ARM: DTS: meson: update DTSI to add watchdog node
>    ARM: defconfig: update multi_v7_defconfig
>
>   .../devicetree/bindings/watchdog/meson6-wdt.txt    |  13 ++
>   arch/arm/boot/dts/meson.dtsi                       |   5 +
>   arch/arm/configs/multi_v7_defconfig                |   1 +
>   drivers/watchdog/Kconfig                           |  10 +
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/meson_wdt.c                       | 235 +++++++++++++++++++++
>   6 files changed, 265 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>   create mode 100644 drivers/watchdog/meson_wdt.c
>
For the series:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

