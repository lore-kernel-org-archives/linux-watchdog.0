Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:46480 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754874Ab2I0F7d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 01:59:33 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id A9445FFA462
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2012 07:58:53 +0200 (CEST)
Date: Thu, 27 Sep 2012 07:50:21 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] ARM: at91: add at91sam9_wdt driver to
 at91sam926x, at91sam9g45
Message-ID: <20120927055021.GO17667@game.jcrosoft.org>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-3-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1348568704-28304-3-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
> Enable the driver for the evk-pro3 board.
> 
> Tested on an at91sam9260 board (evk-pro3).
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
>  arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
>  arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
>  arch/arm/boot/dts/evk-pro3.dts     | 4 ++++
split board and soc

Best Regards,
J.
