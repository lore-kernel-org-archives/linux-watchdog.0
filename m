Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Lin, JM" <JM.Lin@atmel.com>,
        "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wim@iguana.be" <wim@iguana.be>,
        "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>
Subject: RE: [v2 PATCH 6/8] watchdog/at91sam9_wdt: Use
 module_platform_driver()
Date: Fri, 7 Dec 2012 07:12:54 +0000
Message-ID: <B256D81BAE5131468A838E5D7A2436413A01DF81@penmbx01>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
 <1354671267-19277-7-git-send-email-wenyou.yang@atmel.com>
 <50C0E0E8.3020809@mvista.com>
In-Reply-To: <50C0E0E8.3020809@mvista.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: 2012Äê12ÔÂ7ÈÕ 2:16
> To: Yang, Wenyou
> Cc: linux-arm-kernel@lists.infradead.org; linux-watchdog@vger.kernel.org; Lin, JM;
> Ferre, Nicolas; linux-kernel@vger.kernel.org; wim@iguana.be;
> plagnioj@jcrosoft.com
> Subject: Re: [v2 PATCH 6/8] watchdog/at91sam9_wdt: Use
> module_platform_driver()
> 
> Hello.
> 
> On 12/05/2012 04:34 AM, Wenyou Yang wrote:
> 
> > Using module_platform_driver() replaces module_init() and module_exit()
> > and makes the code simpler.
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: wim@iguana.be
> > Cc: linux-watchdog@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/watchdog/at91sam9_wdt.c |   14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> > index 5afd3fb..a7c0881 100644
> > --- a/drivers/watchdog/at91sam9_wdt.c
> > +++ b/drivers/watchdog/at91sam9_wdt.c
> > @@ -278,6 +278,7 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> >  #endif
> >
> >  static struct platform_driver at91wdt_driver = {
> > +	.probe		= at91wdt_probe,
> 
>    You also need to remove '__init' annotation from that function since the
> driver becomes hot-plug aware now.
Thanks, I got it.
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
ÿôèº{.nÇ+‰·Ÿ®‰­†+%ŠËÿ±éİ¶¥Šwÿº{.nÇ+‰·¥Š{±şG«éÿŠ{ayº
Ê‡Ú™ë,j­¢f£¢·hšïêÿ‘êçz_è®(­éšŠİ¢j"ú¶m§ÿÿ¾«şG«éÿ¢¸?™¨è­Ú&£ø§~á¶iO•æ¬z·švØ^¶m§ÿÿÃ
ÿ¶ìÿ¢¸?–I¥
