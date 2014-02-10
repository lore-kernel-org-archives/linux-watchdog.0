Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <groeck@juniper.net>
To: "monstr@monstr.eu" <monstr@monstr.eu>, Guenter Roeck <linux@roeck-us.net>
CC: Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 01/10] watchdog: xilinx: Convert driver to the watchdog
 framework
Date: Mon, 10 Feb 2014 17:18:11 +0000
Message-ID: <c5f221694e2041519cabeef0b7552aac@CO1PR05MB523.namprd05.prod.outlook.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <52F7DF2F.5060001@roeck-us.net> <52F879CF.8080906@monstr.eu>
In-Reply-To: <52F879CF.8080906@monstr.eu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

> -----Original Message-----
> From: Michal Simek [mailto:monstr@monstr.eu]
> Sent: Sunday, February 09, 2014 11:04 PM
> To: Guenter Roeck
> Cc: Michal Simek; linux-kernel@vger.kernel.org; Wim Van Sebroeck;
> linux-watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 01/10] watchdog: xilinx: Convert driver to the
> watchdog framework
> 
> On 02/09/2014 09:03 PM, Guenter Roeck wrote:
> > On 01/31/2014 06:18 AM, Michal Simek wrote:
> >> - Remove uneeded headers, fops functions
> >> - Use xilinx_wdt prefix in start/stop/keepalive functions
> >>    and in new structures
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >
> > Hi Michal,
> >
> >>   static int xwdt_probe(struct platform_device *pdev)
> >>   {
> >>       int rc;
> >> @@ -314,7 +184,7 @@ static int xwdt_probe(struct platform_device
> *pdev)
> >>                       "xlnx,wdt-enable-once", NULL);
> >>       if (tmptr == NULL) {
> >>           pr_warn("Parameter \"xlnx,wdt-enable-once\" not found in
> device tree!\n");
> >> -        xdev.nowayout = WATCHDOG_NOWAYOUT;
> >> +        watchdog_set_nowayout(&xilinx_wdt_wdd, true);
> >
> > Sure you want to set this to always true instead of using
> WATCHDOG_NOWAYOUT ?
> 
> I have checked it and
> option CONFIG_WATCHDOG_NOWAYOUT - Disable watchdog shutdown on close
> 
> with this part in the header
> 
> 100 #ifdef CONFIG_WATCHDOG_NOWAYOUT
> 101 #define WATCHDOG_NOWAYOUT               1
> 102 #define WATCHDOG_NOWAYOUT_INIT_STATUS   (1 << WDOG_NO_WAY_OUT)
> 103 #else
> 104 #define WATCHDOG_NOWAYOUT               0
> 105 #define WATCHDOG_NOWAYOUT_INIT_STATUS   0
> 106 #endif
> 
> enable once is hardware option and it means when this option is setup
> in hw you can't stop watchdog. That's why I think that setting up true
> instead of WATCHDOG_NOWAYOUT is correct.
> 

Ok, makes sense.

Guenter
