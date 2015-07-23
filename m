Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36723 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbbGWRg6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 13:36:58 -0400
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Roger Lu <roger.lu@mediatek.com>
Subject: Re: [PATCH v2 1/2] watchdog: add wdt suspend/resume support
Date: Thu, 23 Jul 2015 19:36:53 +0200
Message-ID: <3323583.jRovLkk8YW@ubix>
In-Reply-To: <1437630551-39650-2-git-send-email-eddie.huang@mediatek.com>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com> <1437630551-39650-2-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday, July 23, 2015 01:49:10 PM Eddie Huang wrote:
> From: Greta Zhang <greta.zhang@mediatek.com>
> 
> add wdt driver suspend/resume support
> 
> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/watchdog/mtk_wdt.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
