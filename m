Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:56422 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751833Ab2ITGH7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Sep 2012 02:07:59 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id D0F65FF948B
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Sep 2012 07:36:57 +0200 (CEST)
Date: Thu, 20 Sep 2012 07:28:34 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/2] watchdog: at91sam9_wdt: add device tree support
Message-ID: <20120920052834.GD17667@game.jcrosoft.org>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
 <1348055861-7857-2-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1348055861-7857-2-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 13:57 Wed 19 Sep     , Fabio Porcedda wrote:
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..fca76fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,15 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9-wdt"
atmel,at91sam9260-watchdog
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Example:
> +
> +	watchdog@fffffd40 {
> +		compatible = "atmel,at91sam9-wdt";
> +		reg = <0xfffffd40 0x10>;
> +	};

you need to be able to specify the timeout too via DT

Best Regards,
J.
