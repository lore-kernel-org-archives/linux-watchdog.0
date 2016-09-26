Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:51629 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932259AbcIZEe1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Sep 2016 00:34:27 -0400
Date: Mon, 26 Sep 2016 07:34:19 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] ARM: i.MX: dts: add fsl, imx25-wdt compatible to
 all relevant watchdog nodes
Message-ID: <20160926043419.wljnbmopmfy4kor4@tarshish>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-3-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474850361-20884-3-git-send-email-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Vladimir,

On Mon, Sep 26, 2016 at 03:39:21AM +0300, Vladimir Zapolskiy wrote:
> Watchdog device controller found on all modern SoCs from i.MX series
> and firstly introduced in i.MX25 is not one in one compatible with the
> watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
> controlles don't have WICR (and pretimeout notification support) and
> WMCR registers. To get benefit from the more advanced watchdog device
> and to avoid operations over non-existing registers on legacy SoCs add
> fsl,imx25-wdt compatible to descriptions of all i.MX25 compatible
> watchdog controllers.

Maybe also update Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt? 
In a separate patch.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
