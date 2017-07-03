Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33750 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbdGCHvw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Jul 2017 03:51:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170702224051.15109-11-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de> <20170702224051.15109-11-hauke@hauke-m.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Jul 2017 10:51:51 +0300
Message-ID: <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> The reset controllers (on xRX200 and newer SoCs have two of them) are
> provided by the RCU module. This was initially implemented as a simple
> reset controller. However, the RCU module provides more functionality
> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> The old reset controller driver implementation from
> arch/mips/lantiq/xway/reset.c did not honor this fact.
>
> For some devices the request and the status bits are different.

> +Required properties:
> +- compatible           : Should be one of
> +                               "lantiq,danube-reset"
> +                               "lantiq,xrx200-reset"
> +- offset-set           : Offset of the reset set register
> +- offset-status                : Offset of the reset status register

Just one side comment (I'm fine with either choice, just for your
information). Recently I have reviewed at24 patch which adds a
property for getting MAC offset and my reseach ends up with the naming
pattern mac-offset (as many others are doing this way). So, perhaps in
your case it might make sense to do that way? Anyway, it's a matter of
a (bit of a) chaos in DT bindings, whatever you decide users will live
with.

-- 
With Best Regards,
Andy Shevchenko
