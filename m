Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:12618 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756169Ab0LJNSj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Dec 2010 08:18:39 -0500
Date: Fri, 10 Dec 2010 14:18:37 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
Message-ID: <20101210131837.GA3783@infomag.iguana.be>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Since this looks more arch specific, can this go via the arm kernel tree?

Thanks in advance,
Wim.

