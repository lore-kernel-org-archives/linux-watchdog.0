Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Dajun <dajun.chen@diasemi.com>,
        "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>
Date: Mon, 25 Jul 2011 17:07:34 +0530
Subject: RE: [PATCH 07/11] Watchdog: DA9052 watchdog support v1
Message-ID: <E2CAE7F7B064EA49B5CE7EE9A4BB167D18F7404D65@KCINPUNHJCMS01.kpit.com>
References: <1309872103.960.79.camel@L-0532.kpit.com>
	 <1310630232.284.16.camel@L-0532.kpit.com>
 <20110714102928.GL3834@infomag.iguana.be>
In-Reply-To: <20110714102928.GL3834@infomag.iguana.be>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>


> -----Original Message-----
> From: Wim Van Sebroeck [mailto:wim@iguana.be]
> Sent: Thursday, July 14, 2011 3:59 PM
> To: Ashish Jangam
> Cc: linux-kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; Dajun;
> linaro-dev@lists.linaro.org
> Subject: Re: [PATCH 07/11] Watchdog: DA9052 watchdog support v1
> 
> Hi Ashish, Dajun,
> 
> > > This driver adds support for the watchdog functionality provided by the
> Dialog
> > > Semiconductor DA9052 PMIC chip.
> > >
> > > Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> > > Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
> > > ---
> > If there are no comments then can you ACK this patch?
> 
> I remain with my comment of Wed 26 Jan 2011:
> > The ioctl WDIOC_SETOPTIONS call is not in line with the watchdog API.
> > the supported options are:
> > #define WDIOS_DISABLECARD       0x0001  /* Turn off the watchdog timer */
> > #define WDIOS_ENABLECARD        0x0002  /* Turn on the watchdog timer */
> > #define WDIOS_TEMPPANIC         0x0004  /* Kernel panic on temperature trip
> */
> > Your options are:
> > #define DA9052_STROBING_FILTER_ENABLE   0x0001
> > #define DA9052_STROBING_FILTER_DISABLE  0x0002
> > #define DA9052_SET_STROBING_MODE_MANUAL 0x0004
> > #define DA9052_SET_STROBING_MODE_AUTO   0x0008
> >
> > Please explain what you want to do.
> 
> FYI: this is how the code looks now:
> +       case WDIOC_SETOPTIONS:
> +               if (get_user(new_value, p))
> +                       return -EFAULT;
> +               if (new_value == DA9052_ENABLE || new_value == DA9052_DISABLE)
> +                       da9052_sm_set_strobing_filter(wdt, new_value);
> +               else
> +                       wdt->pwdt->sm_strobe_mode_flag = new_value;
> +               return 0;
> 
> Since the code is still not in line with the watchdog API and since I did not
> get
> an answer yet on what you (or Dajun) want to do, there is definitely NO ACK
> yet.
> If there is a good reasoning behind your needs, we might conclude that this is
> indeed
> worthwhile and extend the API in a proper way. But as it is now, it's not
> correct.
If strobe filter is "Enable" (set/reset thru ioctl) then only a new wdt time window is set 
else if strobe filter is "Disable", new wdt time window is set to a min value or wdt is
disabled depending upon condition.
If the logic is complex then I will simplify it.
> 
> Kind regards,
> Wim.
> 



ÿôèº{.nÇ+‰·Ÿ®‰­†+%ŠËÿ±éİ¶¥Šwÿº{.nÇ+‰·¥Š{±şG«éÿŠ{ayº
Ê‡Ú™ë,j­¢f£¢·hšïêÿ‘êçz_è®(­éšŠİ¢j"ú¶m§ÿÿ¾«şG«éÿ¢¸?™¨è­Ú&£ø§~á¶iO•æ¬z·švØ^¶m§ÿÿÃ
ÿ¶ìÿ¢¸?–I¥
