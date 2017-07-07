Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33173 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGOL6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 10:11:58 -0400
Date: Fri, 7 Jul 2017 09:11:55 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Message-ID: <20170707141155.tcwhiortc2dqnnwa@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-9-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 03, 2017 at 12:40:43AM +0200, Hauke Mehrtens wrote:
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 31 ++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |  1 +
>  arch/mips/lantiq/xway/reset.c                      |  4 -
>  arch/mips/lantiq/xway/sysctrl.c                    | 41 ----------
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/lantiq/Makefile                        |  1 +
>  drivers/soc/lantiq/fpi-bus.c                       | 87 ++++++++++++++++++++++
>  7 files changed, 121 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/fpi-bus.c
