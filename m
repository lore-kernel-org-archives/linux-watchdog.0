Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755299AbdCGLsk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Mar 2017 06:48:40 -0500
Date: Tue, 7 Mar 2017 12:48:19 +0100
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, fabio.estevam@nxp.com,
        mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, kernel@pengutronix.de,
        linux@armlinux.org.uk, wim@iguana.be, mark.rutland@arm.com,
        damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 1/6] of: documentation: add bindings documentation for
 TS-4600
Message-ID: <20170307114818.GB6585@x250>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170203194729.20995-2-sebastien.bourdelin@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203194729.20995-2-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 03, 2017 at 02:47:24PM -0500, Sebastien Bourdelin wrote:
> This adds the documentation for the TS-4600 by Technologic Systems.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes v1 -> v2:
>   - rebase on master
>   - add ack by Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

Your SoB should be put before the first '---'.  Otherwise, it will get
lost during patch applying.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/technologic.txt | 5 +++++
>  1 file changed, 5 insertions(+)
