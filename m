Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:59346 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750702AbbGWEpb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 00:45:31 -0400
Message-ID: <1437626725.10821.2.camel@mtksdaap41>
Subject: Re: [PATCH 1/2] watchdog: add wdt suspend/resume support
From: Eddie Huang <eddie.huang@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	"Roger Lu" <roger.lu@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Greta Zhang <greta.zhang@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>
Date: Thu, 23 Jul 2015 12:45:25 +0800
In-Reply-To: <55AF11CD.3070801@roeck-us.net>
References: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
	 <1437535610-51314-2-git-send-email-eddie.huang@mediatek.com>
	 <55AF11CD.3070801@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2015-07-21 at 20:45 -0700, Guenter Roeck wrote:
> On 07/21/2015 08:26 PM, Eddie Huang wrote:
> > From: Greta Zhang <greta.zhang@mediatek.com>
> >
> > add wdt driver suspend/resume support
> >
> > Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >   drivers/watchdog/mtk_wdt.c | 38 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > index 938b987..5ef3910 100644
> > --- a/drivers/watchdog/mtk_wdt.c
> > +++ b/drivers/watchdog/mtk_wdt.c
> > @@ -65,6 +65,7 @@ struct mtk_wdt_dev {
> >   	struct watchdog_device wdt_dev;
> >   	void __iomem *wdt_base;
> >   	struct notifier_block restart_handler;
> > +	bool started;
> 
> Any reason why you can not use watchdog_active() ?

Will change to use watchdog_active()

> 
> >   };
> >
> >   static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
> > @@ -125,6 +126,8 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
> >   	reg &= ~WDT_MODE_EN;
> >   	iowrite32(reg, wdt_base + WDT_MODE);
> >
> > +	mtk_wdt->started = false;
> > +
> >   	return 0;
> >   }
> >
> > @@ -135,6 +138,8 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
> >   	void __iomem *wdt_base = mtk_wdt->wdt_base;
> >   	int ret;
> >
> > +	mtk_wdt->started = true;
> > +
> >   	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> >   	if (ret < 0)
> >   		return ret;
> > @@ -174,6 +179,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
> >
> >   	platform_set_drvdata(pdev, mtk_wdt);
> >
> > +	mtk_wdt->started = false;
> > +
> >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   	mtk_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
> >   	if (IS_ERR(mtk_wdt->wdt_base))
> > @@ -221,6 +228,35 @@ static int mtk_wdt_remove(struct platform_device *pdev)
> >   	return 0;
> >   }
> >
> > +#ifdef CONFIG_PM
> > +static int mtk_wdt_suspend(struct platform_device *pdev, pm_message_t state)
> > +{
> > +	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
> > +
> > +	if (mtk_wdt->started) {
> > +		mtk_wdt_stop(&mtk_wdt->wdt_dev);
> > +		mtk_wdt->started = true;
> 
> ?????
> 
Because mtk_wdt_stop() change mtk_wdt->started to false, so set
mtk_wdt->started back to true here. This code is not necessary if use
watchdog_active()

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_wdt_resume(struct platform_device *pdev)
> > +{
> > +	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
> > +
> > +	if (mtk_wdt->started) {
> > +		mtk_wdt_start(&mtk_wdt->wdt_dev);
> > +		mtk_wdt_ping(&mtk_wdt->wdt_dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +#else
> > +#define	mtk_wdt_suspend	NULL
> > +#define	mtk_wdt_resume	NULL
> > +#endif
> > +
> >   static const struct of_device_id mtk_wdt_dt_ids[] = {
> >   	{ .compatible = "mediatek,mt6589-wdt" },
> >   	{ /* sentinel */ }
> > @@ -230,6 +266,8 @@ MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
> >   static struct platform_driver mtk_wdt_driver = {
> >   	.probe		= mtk_wdt_probe,
> >   	.remove		= mtk_wdt_remove,
> > +	.suspend	= mtk_wdt_suspend,
> > +	.resume		= mtk_wdt_resume,
> >   	.driver		= {
> >   		.name		= DRV_NAME,
> >   		.of_match_table	= mtk_wdt_dt_ids,
> 
> Typically drivers would use struct dev_pm_ops and
>                  .pm = &mtk_wdt_pm_ops,
> 
> Any reason for not using the same mechanism ?
> 
Will change to use dev_pm_ops

Eddie
Thanks

