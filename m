Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33789 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933154AbdK2Pyq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Nov 2017 10:54:46 -0500
Date: Wed, 29 Nov 2017 07:54:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: wim@iguana.be, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: Re: [PATCH] watchdog: stm32: Fix copyright
Message-ID: <20171129155445.GB17729@roeck-us.net>
References: <20171129142753.23681-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129142753.23681-1-benjamin.gaignard@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 29, 2017 at 03:27:53PM +0100, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Yannick Fertre <yannick.fertre@st.com>
> ---
>  drivers/watchdog/stm32_iwdg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index be64a8699de3..c6c8351f1598 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -1,8 +1,8 @@
>  /*
>   * Driver for STM32 Independent Watchdog
>   *
> - * Copyright (C) Yannick Fertre 2017
> - * Author: Yannick Fertre <yannick.fertre@st.com>
> + * Copyright (C) STMicroelectronics SA 2017
> + * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.

This will require an Ack from Yannick.

Guenter
