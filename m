Return-path: <akshay.bhat@timesys.com>
Subject: Re: [PATCH v5 1/2] watchdog: imx2_wdt: add external reset support via
 dt prop
To: Tim Harvey <tharvey@gateworks.com>, linux-watchdog@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>
References: <1459523804-11390-1-git-send-email-tharvey@gateworks.com>
 <1459523804-11390-2-git-send-email-tharvey@gateworks.com>
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@iguana.be>, Stefan Roese <sr@denx.de>,
 Iain Paton <ipaton0@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
From: Akshay Bhat <akshay.bhat@timesys.com>
Message-ID: <56FEA26A.5020805@timesys.com>
Date: Fri, 1 Apr 2016 12:31:38 -0400
MIME-Version: 1.0
In-Reply-To: <1459523804-11390-2-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 04/01/2016 11:16 AM, Tim Harvey wrote:
> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltage for
> the CPU when coming out of reset at 800Mhz.
>
> This uses a new device-tree property 'fsl,ext-reset-output' to indicate the
> board has such a reset and to cause the watchdog to be configured to assert
> WDOG_B instead of an internal reset both on a watchdog timeout and in
> system_restart.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Iain Paton <ipaton0@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Akshay Bhat <akshay.bhat@timesys.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> v5:
>   - rename property to 'fsl,ext-reset-output'
> v4:
>   - change Property to Properties in documentation
> v3:
>   - mandate use of 'either' internal or external reset but not both
>     simultaneously
> v2:
>   - rename property to 'ext-reset-output' based on ML feedback
>   - simplify setting SRS bit if external-reset
>   - update comments and commit msg
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---

Tested-by: Akshay Bhat <akshay.bhat@timesys.com>
