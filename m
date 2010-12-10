Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42833 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab0LJNwx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Dec 2010 08:52:53 -0500
Date: Fri, 10 Dec 2010 14:52:47 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
Message-ID: <20101210135246.GJ17441@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 07, 2010 at 02:16:04PM -0200, Fabio Estevam wrote:
> Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
