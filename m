Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:55228 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932412AbbJ0PNM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 11:13:12 -0400
Date: Tue, 27 Oct 2015 16:13:08 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Justin Chen <justinpopo6@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 0/2] watchdog: driver for BCM7038 and newer chips.
Message-ID: <20151027151308.GA27264@spo001.leaseweb.nl>
References: <1441044163-16563-1-git-send-email-justinpopo6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441044163-16563-1-git-send-email-justinpopo6@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Justin,

> This driver is for a watchdog block contained in all Broadcom Set-top
> Box chips since BCM7038. BCM7038 was made public during the 2004 CES,
> and since then, many chips use this watchdog block including some cable
> modem chips.
> 
> Changes since v2:
> Added clk_disable_unprepare if watchdog fails to register.
> 
> Changes since v1:
> Removed clock-frequency because it brought unnecessary complexity to the
> driver.
> Renamed a few variables.
> 
> Patch 1: watchdog device tree binding documentation
> 
> Patch 2: watchdog driver
> 
> Justin Chen (2):
>   watchdog: bcm7038: add device tree binding documentation
>   watchdog: Watchdog driver for Broadcom Set-Top Box
> 
>  .../bindings/watchdog/brcm,bcm7038-wdt.txt         |  19 ++
>  drivers/watchdog/Kconfig                           |   8 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/bcm7038_wdt.c                     | 237 +++++++++++++++++++++
>  4 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
>  create mode 100644 drivers/watchdog/bcm7038_wdt.c

Patches added to linux-watchdog-next.

Kind regards,
Wim.

