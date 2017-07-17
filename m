Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35959 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdGQTAC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 15:00:02 -0400
Date: Mon, 17 Jul 2017 14:00:00 -0500
From: Rob Herring <robh@kernel.org>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, linux@roeck-us.net,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com
Subject: Re: [PATCH v5 3/8] dt-bindings: bus: Add documentation for the
 Technologic Systems NBUS
Message-ID: <20170717190000.n2lifnduqzgp4b6g@rob-hp-laptop>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170714203218.14409-4-sebastien.bourdelin@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714203218.14409-4-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 14, 2017 at 04:32:13PM -0400, Sebastien Bourdelin wrote:
> Add binding documentation for the Technologic Systems NBUS that is used
> to interface with peripherals in the FPGA of the TS-4600 SoM.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v4 -> v5:
>   - fix missing signed off
> 
> Changes v3 -> v4:
>   - rebase on master
>   - fix vendor prefixes for dts properties (suggested by Rob Herring)
>   - v3 was acked by Linus Walleij
> 
> Changes v2 -> v3:
>   - rebase on master
>   - fix typo (suggested by Rob Herring)
> 
> Changes v1 -> v2:
>   - rebase on master
>   - remove the simple-bus compatibility as the root node will now
>   populate child nodes (suggested by Rob Herring)
>   - use the ts vendor prefix for gpios (suggested by Rob Herring)
> ---
>  Documentation/devicetree/bindings/bus/ts-nbus.txt | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt

Acked-by: Rob Herring <robh@kernel.org>

