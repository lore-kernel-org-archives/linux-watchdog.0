Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        Shawn Guo <Shawn.Guo@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: FW: [PATCHv2 0/2] Add big endian support
Date: Fri, 28 Mar 2014 04:15:51 +0000
Message-ID: <6dce4e998c8448cc83826ee7ccb29e9a@BY2PR03MB505.namprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>


Forward to Shawn.

Thanks,

> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Wednesday, March 26, 2014 10:22 AM
> To: wim@iguana.be; w.sang@pengutronix.de; linux-watchdog@vger.kernel.org;
> linux@roeck-us.net
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCHv2 0/2] Add big endian support
> 
> This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
> in BE mode.
> 
> And this has been test on Vybird.
> 
> Changes in V2:
> - Add the detail information in the commit comment.
> - 'big-endians' --> 'big-endian'.
> 
> 
> Xiubo Li (2):
>   watchdog: imx2_wdt: Sort the header files alphabetically
>   watchdog: imx2_wdt: Add big-endian support
> 
>  drivers/watchdog/imx2_wdt.c | 52 ++++++++++++++++++++++++++++++++------------
> -
>  1 file changed, 37 insertions(+), 15 deletions(-)
> 
> --
> 1.8.4
> 
