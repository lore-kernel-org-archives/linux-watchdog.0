Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43830 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbcGQUWh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:22:37 -0400
Date: Sun, 17 Jul 2016 22:22:35 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 0/3] watchdog: Add Amlogic Meson GXBB Watchdog Timer driver
Message-ID: <20160717202235.GD916@spo001.leaseweb.nl>
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Neil,

> Adds support for the Amlogic Meson GXBB SoC Watchdog Timer.
> It differs from the meson6/meson8b HW, so need for a separate driver.
> The HW provides a divider capable of having a 1ms timebase thus simplifying
> the counter update.
> The restart call is not provided even if the HW is capable of triggering a
> system reset immediately because of the PSCI firmare having such functionnality.
> The watchdog is not expected to be running at boot time since there is a separate
> system-level watchdog running from the SCPI co-processor, but this case would be
> handle in a next driver update.
> 
> Changes since v2 at http://lkml.kernel.org/r/1464943007-18000-1-git-send-email-narmstrong@baylibre.com :
> - Fix set_timeout behaviour
> 
> Changes since v1 at http://lkml.kernel.org/r/1464614948-28247-1-git-send-email-narmstrong@baylibre.com :
> - Update default timeout to 30sec
> - Add separate CONFIG_
> - Remove unused defines & functions
> - Fix indentation
> - Check set_timeout max value
> - Reorder includes alphabetically
> - Switch to human identify string
> - clk_disable_unprepare on probe failure or removal
> 
> Changes since RFC version at http://lkml.kernel.org/r/1464249112-13658-1-git-send-email-narmstrong@baylibre.com :
> - Remove status callback, will re-introduce it later to managed the already-running use case
> - Fix registers defines indentation
> - Fix space between operators
> - Make all callbacks static functions
> - Fix bindings with missing clocks attribute
> - Do not stop/start watchdog on a timeout setup
> - Fix probe device configuration
> 
> Neil Armstrong (3):
>   watchdog: Add Meson GXBB Watchdog Driver
>   dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
>   ARM64: dts: amlogic: meson-gxbb: Add watchdog node
> 
>  .../bindings/watchdog/meson-gxbb-wdt.txt           |  16 ++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/meson_gxbb_wdt.c                  | 270 +++++++++++++++++++++
>  5 files changed, 303 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
>  create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
> 
> -- 
> 2.7.0
> 

This patches have been added to linux-watchdog-next.

Kind regards,
Wim.

