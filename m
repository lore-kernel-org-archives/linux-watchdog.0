Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Venu Byravarasu <vbyravarasu@nvidia.com>
To: Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michal Simek <monstr@monstr.eu>, Wim Van Sebroeck <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Date: Thu, 30 May 2013 18:00:45 +0530
Subject: RE: [PATCH 1/3] watchdog: xilinx: Fix driver header
Message-ID: <D958900912E20642BCBC71664EFECE3E6E51FD29A4@BGMAIL02.nvidia.com>
References: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
In-Reply-To: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Michal Simek
> Sent: Thursday, May 30, 2013 5:56 PM
> To: linux-kernel@vger.kernel.org
> Cc: Michal Simek; Michal Simek; Wim Van Sebroeck; linux-
> watchdog@vger.kernel.org
> Subject: [PATCH 1/3] watchdog: xilinx: Fix driver header
> 
> * PGP Signed by an unknown key
> 
> - Remove reference for IP version
> - Fix header coding style
> - Remove notes which are visible from the code
> - Fix driver license according to header
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/watchdog/of_xilinx_wdt.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c
> b/drivers/watchdog/of_xilinx_wdt.c
> index 2761ddb..d4a35ab 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -1,23 +1,13 @@
>  /*
> -*   of_xilinx_wdt.c  1.01  A Watchdog Device Driver for Xilinx
> xps_timebase_wdt
> -*
> -*   (C) Copyright 2011 (Alejandro Cabrera <aldaya@gmail.com>)
> -*
> -*       -----------------------
> -*/
> + * Watchdog Device Driver for Xilinx axi/xps_timebase_wdt
> + *
> + * (C) Copyright 2011 (Alejandro Cabrera <aldaya@gmail.com>)

Should year not be updated? 

> + *
> + * This program is free software; you can redistribute it and/or
