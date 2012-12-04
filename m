Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
        "Lin, JM" <JM.Lin@atmel.com>
Subject: RE: [PATCH 03/11] watchdog/at91sam9_wdt: change the wdt_read and
 wdt_write macro to the inline function
Date: Tue, 4 Dec 2012 03:13:09 +0000
Message-ID: <B256D81BAE5131468A838E5D7A2436413A01CE7D@penmbx01>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
 <1352877369-19740-4-git-send-email-wenyou.yang@atmel.com>
 <20121116134901.GH4398@game.jcrosoft.org>
In-Reply-To: <20121116134901.GH4398@game.jcrosoft.org>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi JC,

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj@jcrosoft.com]
> Sent: 2012Äê11ÔÂ16ÈÕ 21:49
> To: Yang, Wenyou
> Cc: linux-arm-kernel@lists.infradead.org; wim@iguana.be;
> linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org; Ferre, Nicolas; Lin,
> JM
> Subject: Re: [PATCH 03/11] watchdog/at91sam9_wdt: change the wdt_read and
> wdt_write macro to the inline function
> 
> On 15:16 Wed 14 Nov     , Wenyou Yang wrote:
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >  drivers/watchdog/at91sam9_wdt.c |   28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> > index 31c914a..98e7d5a 100644
> > --- a/drivers/watchdog/at91sam9_wdt.c
> > +++ b/drivers/watchdog/at91sam9_wdt.c
> > @@ -34,11 +34,6 @@
> >
> >  #define DRV_NAME "AT91SAM9 Watchdog"
> >
> > -#define wdt_read(field) \
> > -	__raw_readl(at91wdt_private.base + field)
> > -#define wdt_write(field, val) \
> > -	__raw_writel((val), at91wdt_private.base + field)
> > -
> >  /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
> >   * use this to convert a watchdog
> >   * value from/to milliseconds.
> > @@ -75,13 +70,24 @@ struct at91wdt_drvdata {
> >
> >  /* ......................................................................... */
> >
> > +static inline unsigned int wdt_read(struct at91wdt_drvdata *driver_data,
> > +					unsigned int field)
> > +{
> > +	return __raw_readl(driver_data->base + field);
> > +}
> > +
> > +static inline void wdt_write(struct at91wdt_drvdata *driver_data,
> > +				unsigned int field, unsigned int val)
> > +{
> > +	__raw_writel((val), driver_data->base + field);
> > +}
> use relaxed version

Thanks, I will change it.
> 
> Best Regrds,
> J.

Best Regards,
Wenyou Yang
ÿôèº{.nÇ+‰·Ÿ®‰­†+%ŠËÿ±éİ¶¥Šwÿº{.nÇ+‰·¥Š{±şG«éÿŠ{ayº
Ê‡Ú™ë,j­¢f£¢·hšïêÿ‘êçz_è®(­éšŠİ¢j"ú¶m§ÿÿ¾«şG«éÿ¢¸?™¨è­Ú&£ø§~á¶iO•æ¬z·švØ^¶m§ÿÿÃ
ÿ¶ìÿ¢¸?–I¥
