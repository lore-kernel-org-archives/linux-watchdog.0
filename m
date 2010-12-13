Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47776 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0LMLqj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Dec 2010 06:46:39 -0500
Date: Mon, 13 Dec 2010 12:46:35 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
Message-ID: <20101213114635.GG6017@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com> <20101210131837.GA3783@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101210131837.GA3783@infomag.iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 10, 2010 at 02:18:37PM +0100, Wim Van Sebroeck wrote:
> Hi All,
> 
> > Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Since this looks more arch specific, can this go via the arm kernel tree?

Yes, please. I already scheduled this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
