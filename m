Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37545 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbbGWRhG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 13:37:06 -0400
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>
Subject: Re: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable wdt if enabled
Date: Thu, 23 Jul 2015 19:37:03 +0200
Message-ID: <1488521.5eJqASov2O@ubix>
In-Reply-To: <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com> <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday, July 23, 2015 01:49:11 PM Eddie Huang wrote:
> From: Greta Zhang <greta.zhang@mediatek.com>
> 
> Without .shutdown(), watchdog might reset the system during power off.
> For example, if watchdog's timeout is set to 30s, then it is reset to
> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
> but watchdog is still running and may trigger reset.
> 
> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/watchdog/mtk_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
