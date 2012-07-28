Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55118 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2G1Tfr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Jul 2012 15:35:47 -0400
Received: by obbuo13 with SMTP id uo13so6268487obb.19
        for <linux-watchdog@vger.kernel.org>; Sat, 28 Jul 2012 12:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1341264782-19098-1-git-send-email-festevam@gmail.com>
References: <1341264782-19098-1-git-send-email-festevam@gmail.com>
Date: Sat, 28 Jul 2012 16:35:46 -0300
Message-ID: <CAOMZO5DiV8io9v2v=6L9zpEY1M+Df3UZGYmSdTofq0FoxVe14Q@mail.gmail.com>
Subject: Re: [PATCH] watchdog: imx2_wdt: Select the driver via ARCH_MXC
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: shawn.guo@linaro.org, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 2, 2012 at 6:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> With device tree support in place, we should not use IMX_HAVE_PLATFORM_IMX2_WDT
> as a dependency for selecting the imx2_wdt driver.
>
> Use ARCH_MXC symbol instead, so that the driver can be even selected by a device-tree
> only SoC, such as i.MX6.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Sascha/Shawn,

Any comments?

Regards,

Fabio Estevam
