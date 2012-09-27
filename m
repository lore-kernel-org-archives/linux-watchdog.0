Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:41322 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754747Ab2I0F7G (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 01:59:06 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id E53C3FFA4AD
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2012 08:05:08 +0200 (CEST)
Date: Thu, 27 Sep 2012 07:56:36 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] watchdog: at91sam9_wdt: add device tree support
Message-ID: <20120927055636.GP17667@game.jcrosoft.org>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-2-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1348568704-28304-2-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..5947929
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,19 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9260-wdt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Optional properties:
> +- heartbeat: contains the watchdog heartbeats in seconds.
more I read this binding more it's seems wrong

Today we do not use yet the watchdog framework which we will so we need to
use the same binding as the watchdog framework

So when we switch the DT will not change

Best Regards,
J.
