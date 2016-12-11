Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35144 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcLKI6f (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 03:58:35 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so7429569wjc.2
        for <linux-watchdog@vger.kernel.org>; Sun, 11 Dec 2016 00:58:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161211010648.6591-1-vz@mleia.com>
References: <20161211010648.6591-1-vz@mleia.com>
From: Magnus Lilja <lilja.magnus@gmail.com>
Date: Sun, 11 Dec 2016 09:58:33 +0100
Message-ID: <CAM=E1R4Mr_QG1H9S8vriBvMRrWE8frYgQpXB2EZ=1d2U-pRaiA@mail.gmail.com>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi

Excellent!

On 11 December 2016 at 02:06, Vladimir Zapolskiy <vz@mleia.com> wrote:
> Power down counter enable/disable bit switch is located in WMCR
> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
> i.MX31 SoCs don't have this register. As a result of writing data to
> the non-existing register on driver probe the SoC hangs up, to fix the
> problem add more OF compatible strings and on this basis get
> information about availability of the WMCR register.
>
> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Tested-by: Magnus Lilja <lilja.magnus@gmail.com>

(Tested on i.MX31 without device tree)

/Magnus
