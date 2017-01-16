Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33310 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdAPShA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 13:37:00 -0500
Received: by mail-oi0-f65.google.com with SMTP id j15so13274335oih.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Jan 2017 10:37:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109095039.11979-4-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de> <20170109095039.11979-4-u.kleine-koenig@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Jan 2017 16:36:54 -0200
Message-ID: <CAOMZO5DKtWMuYxOzuwkvVC5nqVRqHFj06X_vLxxkJ5i3hrpO4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] watchdog: imx2: add compatibility for new i.MX35 type watchdog
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> When the watchdog driver learned about the i.MX35 type watchdog a new
> compatibility string was introduced. Older dtb continue to use the
> old fsl,imx21-wdt string and so stop writing the WMCR register which is
> critical iff the machine powers off when WDOG becomes active and the
> bootloader doesn't stop the power down counter.
>
> It's unknown which boards are affected and I guess most of them are not.

At least imx31 pdk is affected.

> Also note this is only an issue if a new kernel is operated with an old
> dtb as the SoC dtsi files are fixed accordingly.
>
> XXX: the XXX introduced needs to be changed to HEAD~2 when got a stable c=
ommit id.

This comment should not be here.


Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
