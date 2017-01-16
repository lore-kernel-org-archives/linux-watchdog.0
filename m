Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33543 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdAPSf1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 13:35:27 -0500
Received: by mail-ot0-f196.google.com with SMTP id f9so7158324otd.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Jan 2017 10:35:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de> <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Jan 2017 16:35:26 -0200
Message-ID: <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
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
> Only i.MX35 and newer feature a WMCR register that should be written to. =
Older
> SoCs hang when this address is written.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Only a minor nit: Subject could: ARM: dts: imx: teach...
