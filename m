Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54982 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbFVQcI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 12:32:08 -0400
Date: Mon, 22 Jun 2015 09:32:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [2/2] watchdog: imx2_wdt: Disable previously acquired clock on
 error path
Message-ID: <20150622163205.GA699@roeck-us.net>
References: <1434946579-9674-2-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434946579-9674-2-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 22, 2015 at 01:16:19AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> If watchdog_register_device() fails we should disable the previously
> acquired wdev->clk clock on error path.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
