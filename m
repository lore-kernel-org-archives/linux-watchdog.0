Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:33810 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751268AbaLRByb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Dec 2014 20:54:31 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 756C628FE63
	for <linux-watchdog@vger.kernel.org>; Thu, 18 Dec 2014 01:47:51 +0000 (UTC)
Message-ID: <1418867265.28384.6.camel@perches.com>
Subject: Re: [PATCH v3 1/2] watchdog: Add driver for Mediatek watchdog
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	heiko@sntech.de, yingjoe.chen@gmail.com, ibanezchen@gmail.com,
	greta.zhang@mediatek.com, eddie.huang@mediatek.com, wens@csie.org
Date: Wed, 17 Dec 2014 17:47:45 -0800
In-Reply-To: <20141218013717.GA9855@roeck-us.net>
References: <1418851085-17787-1-git-send-email-matthias.bgg@gmail.com>
	 <1418851085-17787-2-git-send-email-matthias.bgg@gmail.com>
	 <20141218013717.GA9855@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2014-12-17 at 17:37 -0800, Guenter Roeck wrote:
> On Wed, Dec 17, 2014 at 10:18:04PM +0100, Matthias Brugger wrote:
> > This patch adds a driver for the Mediatek SoC integrated
> > watchdog. This driver supports watchdog and software reset
> > for mt65xx and mt81xx SoCs.
[]
> > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
[]
> > +static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
> > +				void *cmd)
> > +{
> > +	struct mtk_wdt_dev *mtk_wdt = container_of(this,
> > +						       struct mtk_wdt_dev,
> > +						       restart_handler);

> I don't really understand the indentation logic you are using.
> Can you make it consistent ?
> 
> I would suggest to align with '(' in the previous line.

Another way is to separate the declaration and the set

	struct mtk_wdt_dev *mtk_wdt;
	void __iomem *wdt_base;

	mtk_wdt = container_of(this, struct mtk_wdt_dev, restart_handler);
	wdt_base = mtk_wdt->wdt_base;



