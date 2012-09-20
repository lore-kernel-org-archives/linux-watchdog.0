Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:53899 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829Ab2ITFr7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Sep 2012 01:47:59 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 48851FF94D2
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Sep 2012 07:37:50 +0200 (CEST)
Date: Thu, 20 Sep 2012 07:29:28 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/2] ARM: at91: add at91sam9_wdt driver to
 at91sam9260
Message-ID: <20120920052928.GE17667@game.jcrosoft.org>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
 <1348055861-7857-3-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1348055861-7857-3-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 13:57 Wed 19 Sep     , Fabio Porcedda wrote:
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 66389c1..680b1c8 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -233,6 +233,12 @@
>  					trigger-external;
>  				};
>  			};
> +
> +			watchdog@fffffd40 {
disable dy default
> +				compatible = "atmel,at91sam9-wdt";
> +				reg = <0xfffffd40 0x10>;
> +			};
> +

Best Regards,
J.
