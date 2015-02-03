Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:59194 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965356AbbBCTE6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 14:04:58 -0500
Date: Tue, 3 Feb 2015 20:04:50 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, paul@crapouillou.net
Subject: Re: [PATCH_V3 0/2] watchdog: jz4740: Add DT support
Message-ID: <20150203190449.GF2875@spo001.leaseweb.nl>
References: <1422959148-38075-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422959148-38075-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Zubair,

> Here are two simple patches that add DT support to the jz4740 watchdog driver.
> 
> Patches are based on 3.19-rc7. Quite disjoint and stay within jz4740
> so should apply easily on other trees.
> 
> If you would like to have them rebased to a different tree, please tell.
> 
> V3 Changed
> Added Reviewed-by: Guenter Roeck <linux@roeck-us.net> 
> Typo in commit message.
> Rebased to rc7
> 
> V2 Changes
> Renamed binding to jz4740 instead of jz47xx
> Removed clk bindings. They can be added later when the clock tree is fixed.
> Rather than add bindings now and change later.
> 
> Added MODULE_DEVICE_TABLE()
> 
> Thank-you
> 
> ZubairLK
> 
> Zubair Lutfullah Kakakhel (2):
>   dt: watchdog: Add DT binding documentation for jz4740 watchdog timer
>   watchdog: jz4740: Add DT support
> 
>  .../devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt      | 12 ++++++++++++
>  drivers/watchdog/jz4740_wdt.c                                | 10 ++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

Both patches have been added to linux-watchdog-next.

Kind regards,
Wim.

