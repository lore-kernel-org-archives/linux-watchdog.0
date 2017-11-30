Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34647 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdK3SiL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Nov 2017 13:38:11 -0500
Date: Thu, 30 Nov 2017 10:38:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: wim@iguana.be, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: Re: [PATCH v2] watchdog: stm32: Fix copyright
Message-ID: <20171130183809.GB20343@roeck-us.net>
References: <20171130084804.23693-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130084804.23693-1-benjamin.gaignard@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 30, 2017 at 09:48:04AM +0100, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> CC: Yannick Fertre <yannick.fertre@st.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/stm32_iwdg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index be64a8699de3..c97ad5619cb0 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -1,12 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for STM32 Independent Watchdog
>   *
> - * Copyright (C) Yannick Fertre 2017
> - * Author: Yannick Fertre <yannick.fertre@st.com>
> + * Copyright (C) STMicroelectronics 2017
> + * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
>   *
>   * This driver is based on tegra_wdt.c
>   *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>  
>  #include <linux/clk.h>
> -- 
> 2.15.0
> 
