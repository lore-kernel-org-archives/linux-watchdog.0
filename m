Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:50876 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdH1LXv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 28 Aug 2017 07:23:51 -0400
Date: Mon, 28 Aug 2017 13:23:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 03/16] spi: spi-falcon: drop check of boot select
Message-ID: <20170828112327.GA15640@linux-mips.org>
References: <20170819221823.13850-1-hauke@hauke-m.de>
 <20170819221823.13850-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170819221823.13850-4-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Aug 20, 2017 at 12:18:10AM +0200, Hauke Mehrtens wrote:

> Do not check which flash type the SoC was booted from before
> using this driver. Assume that the device tree is correct and use this
> driver when it was added to device tree. This also removes a build
> dependency to the SoC code.
> 
> All device trees I am aware of only have one correct flash device entry
> in it. The device tree is anyway bundled with the kernel in all systems
> using device tree I know of.
> 
> The boot mode can be specified with some pin straps and will select the
> flash type the rom code will boot from. One SPI, NOR or NAND flash chip
> can be connect to the EBU and used to load the first stage boot loader
> from.

I think other than this patch we finally have all the acks necessary so
I merged the series except this patch which shouldn't be strictly necessary.

  Ralf
