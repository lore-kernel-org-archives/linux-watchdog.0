Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56498 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbaEZTRi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 15:17:38 -0400
Date: Mon, 26 May 2014 21:17:34 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Xiubo Li <Li.Xiubo@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] watchdog: imx2_wdt: convert to watchdog core api
Message-ID: <20140526191734.GA21962@spo001.leaseweb.com>
References: <1397199434-6551-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397199434-6551-1-git-send-email-agust@denx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Anatolij

> Convert the imx2_wdt driver to the new watchdog core api.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> NOTE: This patch applies on top of the imx2_wdt regmap-mmio support
> patch series http://comments.gmane.org/gmane.linux.kernel/1677735
> 
> Changes since first version:
>  - simplify return in imx2_wdt_is_running()
>  - fix "WARNING: quoted string split across lines"
> 
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/imx2_wdt.c |  292 ++++++++++++++++++-------------------------
>  2 files changed, 123 insertions(+), 170 deletions(-)
> 

This patch has been added to linux-watchog-next.

Kind regards,
Wim.

