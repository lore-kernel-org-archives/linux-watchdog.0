Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36323 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdGGOKm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 10:10:42 -0400
Date: Fri, 7 Jul 2017 09:10:40 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
Message-ID: <20170707141040.nidxo4qn2a5uyr6u@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-8-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-8-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 03, 2017 at 12:40:42AM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
> 
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

Acked-by: Rob Herring <robh@kernel.org>
