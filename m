Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64742 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2LLL4Y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Dec 2012 06:56:24 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so592528oag.19
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Dec 2012 03:56:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DmV5dKQxeK20h-up9M8BQT6RkQ1KXaWj3f+U4ePsDNtQ@mail.gmail.com>
References: <1341264782-19098-1-git-send-email-festevam@gmail.com>
	<CAOMZO5DiV8io9v2v=6L9zpEY1M+Df3UZGYmSdTofq0FoxVe14Q@mail.gmail.com>
	<20120730034904.GE30774@S2101-09.ap.freescale.net>
	<CAOMZO5DmV5dKQxeK20h-up9M8BQT6RkQ1KXaWj3f+U4ePsDNtQ@mail.gmail.com>
Date: Wed, 12 Dec 2012 09:56:23 -0200
Message-ID: <CAOMZO5DiKo=bCO+WzRD073Vf-nLw_oTw7c4WffnxfSaSrtzzqw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: imx2_wdt: Select the driver via ARCH_MXC
From: Fabio Estevam <festevam@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: wim@iguana.be, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wim,

Ping?

On Wed, Nov 28, 2012 at 2:07 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Wim,
>
> On Mon, Jul 30, 2012 at 12:49 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Sat, Jul 28, 2012 at 04:35:46PM -0300, Fabio Estevam wrote:
>>> On Mon, Jul 2, 2012 at 6:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>> > From: Fabio Estevam <fabio.estevam@freescale.com>
>>> >
>>> > With device tree support in place, we should not use IMX_HAVE_PLATFORM_IMX2_WDT
>>> > as a dependency for selecting the imx2_wdt driver.
>>> >
>>> > Use ARCH_MXC symbol instead, so that the driver can be even selected by a device-tree
>>> > only SoC, such as i.MX6.
>>> >
>>> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> Sascha/Shawn,
>>>
>>> Any comments?
>>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>
>
> Could this one be applied, please?
>
> Regards,
>
> Fabio Estevam
