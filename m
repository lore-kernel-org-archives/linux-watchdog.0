Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54854 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbbFVQbJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 12:31:09 -0400
Date: Mon, 22 Jun 2015 09:31:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [1/2] watchdog: imx2_wdt: Check for clk_prepare_enable() error
Message-ID: <20150622163104.GA503@roeck-us.net>
References: <1434946579-9674-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434946579-9674-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 22, 2015 at 01:16:18AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
