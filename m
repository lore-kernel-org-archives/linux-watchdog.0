Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        "Lin, JM" <JM.Lin@atmel.com>, Wim Van Sebroeck <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [v3 PATCH 7/9] watchdog/at91sam9_wdt: Use
 module_platform_driver()
Date: Wed, 16 Jan 2013 05:22:12 +0000
Message-ID: <B256D81BAE5131468A838E5D7A2436413A05DCFE@penmbx02>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
 <1357353529-20901-8-git-send-email-wenyou.yang@atmel.com>
 <CAHkwnC8CTFxrJ8F=u=MqKW=cZ88SeoT+rA_hzW38jL8ffT9D2Q@mail.gmail.com>
In-Reply-To: <CAHkwnC8CTFxrJ8F=u=MqKW=cZ88SeoT+rA_hzW38jL8ffT9D2Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fabio Porcedda,

> -----Original Message-----
> From: Fabio Porcedda [mailto:fabio.porcedda@gmail.com]
> Sent: 2013Äê1ÔÂ8ÈÕ 18:18
> To: Yang, Wenyou
> Cc: linux-arm-kernel@lists.infradead.org; Ferre, Nicolas; Jean-Christophe
> PLAGNIOL-VILLARD; Lin, JM; Wim Van Sebroeck;
> linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org; Geert
> Uytterhoeven
> Subject: Re: [v3 PATCH 7/9] watchdog/at91sam9_wdt: Use
> module_platform_driver()
> 
> On Sat, Jan 5, 2013 at 3:38 AM, Wenyou Yang <wenyou.yang@atmel.com>
> wrote:
> > Using module_platform_driver() replaces module_init() and module_exit()
> > and makes the code simpler.
> >
> > Remove '__init' annotation from the function 'at91wdt_probe'
> > since the driver becomes hot-plug aware now.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: wim@iguana.be
> > Cc: linux-watchdog@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/watchdog/at91sam9_wdt.c |   16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/watchdog/at91sam9_wdt.c
> b/drivers/watchdog/at91sam9_wdt.c
> > index 94be9d6..7c13dda 100644
> > --- a/drivers/watchdog/at91sam9_wdt.c
> > +++ b/drivers/watchdog/at91sam9_wdt.c
> > @@ -204,7 +204,7 @@ static struct watchdog_device at91wdt_wdd = {
> >         .ops = &at91wdt_ops,
> >  };
> >
> > -static int __init at91wdt_probe(struct platform_device *pdev)
> > +static int at91wdt_probe(struct platform_device *pdev)
> >  {
> >         struct at91wdt_drvdata *driver_data;
> >         struct resource *r;
> > @@ -273,6 +273,7 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> >  #endif
> >
> >  static struct platform_driver at91wdt_driver = {
> > +       .probe          = at91wdt_probe,
> >         .remove         = __exit_p(at91wdt_remove),
> >         .driver         = {
> >                 .name   = "at91_wdt",
> > @@ -281,18 +282,7 @@ static struct platform_driver at91wdt_driver = {
> >         },
> >  };
> >
> > -static int __init at91sam_wdt_init(void)
> > -{
> > -       return platform_driver_probe(&at91wdt_driver, at91wdt_probe);
> > -}
> > -
> > -static void __exit at91sam_wdt_exit(void)
> > -{
> > -       platform_driver_unregister(&at91wdt_driver);
> > -}
> > -
> > -module_init(at91sam_wdt_init);
> > -module_exit(at91sam_wdt_exit);
> > +module_platform_driver(at91wdt_driver);
> >
> >  MODULE_AUTHOR("Renaud CERRATO <r.cerrato@til-technologies.fr>");
> >  MODULE_DESCRIPTION("Watchdog driver for Atmel AT91SAM9x
> processors");
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> The module_platform_driver isn't a substitute of platform_driver_probe,
> because module_platform_driver  use platform_driver_register/unregister.
> Using that macro we lose the advantage of platform_driver_probe,
> as stated in:
> 
> https://lkml.org/lkml/2012/1/10/335
I just referred to the commit 6b761b2902c56b468370e0ee1691c37e0dae042a.
Didn't think more about it.
I will remove this patch in the next version.

> On Tue, Jan 10, 2012 at 21:47, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote:
> > [...]
> >Still, setting up platform_driver.probe and removing __init from all probe
> >functions is not the right thing to do, as this make (non-__init) kernel code
> >size bigger, while none of these devices are hotpluggable and thus cannot
> >appear after bootup. That's why we have platform_driver_probe() in the
> >first place. So I think all of this should be reverted for non-hotpluggable
> >drivers.
> > [...]

You said is reasonable, watchdog is not hotpluggable.
> 
> Best regards
> 
> --
> Fabio Porcedda

Best Regards,
Wenyou Yang
ÿôèº{.nÇ+‰·Ÿ®‰­†+%ŠËÿ±éİ¶¥Šwÿº{.nÇ+‰·¥Š{±şG«éÿŠ{ayº
Ê‡Ú™ë,j­¢f£¢·hšïêÿ‘êçz_è®(­éšŠİ¢j"ú¶m§ÿÿ¾«şG«éÿ¢¸?™¨è­Ú&£ø§~á¶iO•æ¬z·švØ^¶m§ÿÿÃ
ÿ¶ìÿ¢¸?–I¥
