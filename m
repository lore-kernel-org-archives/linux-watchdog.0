Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36046 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbcL1VeX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Dec 2016 16:34:23 -0500
Received: by mail-oi0-f66.google.com with SMTP id u15so52616268oie.3
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Dec 2016 13:33:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161228205419.la74jr4rfes7fa4v@pengutronix.de>
References: <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com> <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com> <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com> <20161223100113.s57bi7257yero7f7@pengutronix.de>
 <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com> <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
 <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com> <20161228205419.la74jr4rfes7fa4v@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Dec 2016 19:33:26 -0200
Message-ID: <CAOMZO5BD3Y6vXwt7_bdv_KyGvKSYru1vzDowsD81fzEbM4gHPA@mail.gmail.com>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 28, 2016 at 6:54 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> I'd do it the other way around and so get more and simpler patches:
>
>  - make driver aware of i.MX35
>  - fix dtsi to use i.MX35 type where applicable

This would not work for old dtb's as they are not aware of the  i.mx35 type=
.
