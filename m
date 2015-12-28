Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43900 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752500AbbL1VES (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 16:04:18 -0500
Date: Mon, 28 Dec 2015 22:03:32 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Carlo Caione <carlo@caione.org>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com, Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v3 0/4] watchdog: meson: Add meson8b watchdog
Message-ID: <20151228210332.GA660@spo001.leaseweb.nl>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446985137-25498-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Carlo

> From: Carlo Caione <carlo@endlessm.com>
> 
> Patchset to add support for the watchdog found on the Amlogic meson8b SoCs.
> DTS and documentation are also updated.
> 
> Changelog:
>    - V1 -> V2:
>      * Do not calculate mask at runtime
>      * Fix few style problems
>      * Remove useless typecase
> 
>    - V2 -> V3:
>      * Changed description for [PATCH 1/4]
>      * Default timeout is not set as min(default, max)
> 
> Carlo Caione (4):
>   watchdog: meson: Enable meson SoC specific data
>   watchdog: meson: Add meson8b SoC specific data
>   Documentation: watchdog: Add new bindings for meson8b
>   ARM: dts: meson8b: Add watchdog node
> 
>  .../devicetree/bindings/watchdog/meson-wdt.txt     | 13 +++++
>  .../devicetree/bindings/watchdog/meson6-wdt.txt    | 13 -----
>  arch/arm/boot/dts/meson8b.dtsi                     |  6 ++
>  drivers/watchdog/meson_wdt.c                       | 65 ++++++++++++++++------
>  4 files changed, 67 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
> 
> -- 
> 1.9.1
> 

patches 1 and 2 have been added to linux-watchdog-next.

Kind regards,
Wim.

