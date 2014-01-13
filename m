Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:52217 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752034AbaAMTVT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jan 2014 14:21:19 -0500
Date: Mon, 13 Jan 2014 20:21:16 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Anson Huang <b20788@freescale.com>
Cc: shawn.guo@linaro.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: disable watchdog timer during low power mode
Message-ID: <20140113192116.GA22713@spo001.leaseweb.com>
References: <1389614314-8987-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389614314-8987-1-git-send-email-b20788@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Anson,

> We should set watchdog timer to be disabled in low power mode,
> as there is no service running in background, otherwise, system
> will reset unexpected.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Added to linux-watchdog-next.

Kind regards,
Wim.

