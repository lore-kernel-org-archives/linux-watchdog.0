Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35953 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdAPSeB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 13:34:01 -0500
Received: by mail-ot0-f194.google.com with SMTP id 36so7158266otx.3
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Jan 2017 10:34:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109095039.11979-2-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de> <20170109095039.11979-2-u.kleine-koenig@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Jan 2017 16:34:00 -0200
Message-ID: <CAOMZO5Bd8_R8i7SeoKuaVJ2EEFD-DA3PJ=QOmcnPtSdXqd+zHQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] watchdog: imx2: Only i.MX35 and later have a WMCR register
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
> Commit 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on
> boot") introduced a write to the WMCR register that doesn't exist on
> i.MX21, i.MX27 and i.MX31 and so makes the SoC hang during probe.
>
> So teach the driver to differentiate between these two types. Note that
> this effectively undoes commit 5fe65ce7ccbb for machines using dt until
> their dtb is updated accordingly. This is critical iff the bootloader
> doesn't disable the power down counter and the #WDOG signal actually
> does something to the machine.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
