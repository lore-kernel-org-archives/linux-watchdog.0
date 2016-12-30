Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35839 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbcL3IBY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Dec 2016 03:01:24 -0500
Received: by mail-qk0-f179.google.com with SMTP id u25so280961274qki.2
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Dec 2016 00:01:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214231237.17496-6-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com> <20161214231237.17496-6-sebastien.bourdelin@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Dec 2016 09:01:22 +0100
Message-ID: <CACRpkdbLnDEo-7k1rsD6NT6U165CHjTyZwT9eqv+w7MVHYgNEA@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: TS-4600: add NBUS support
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>, mark@embeddedarm.com,
        kris@embeddedarm.com, Simon Horman <horms+renesas@verge.net.au>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        damien.riegel@savoirfairelinux.com,
        Lucile Quirion <lucile.quirion@savoirfairelinux.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 15, 2016 at 12:12 AM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> This commit enables the NBUS on the TS-4600, using the ts-nbus driver.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

> +       nbus {
> +               compatible = "technologic,ts-nbus", "simple-bus";
> +               pinctrl-0 = <&nbus_pins>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               pwms = <&pwm 2 83>;
> +               data-gpios   = <&gpio0 0 GPIO_ACTIVE_HIGH
> +                               &gpio0 1 GPIO_ACTIVE_HIGH
> +                               &gpio0 2 GPIO_ACTIVE_HIGH
> +                               &gpio0 3 GPIO_ACTIVE_HIGH
> +                               &gpio0 4 GPIO_ACTIVE_HIGH
> +                               &gpio0 5 GPIO_ACTIVE_HIGH
> +                               &gpio0 6 GPIO_ACTIVE_HIGH
> +                               &gpio0 7 GPIO_ACTIVE_HIGH>;
> +               csn-gpios    = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +               txrx-gpios   = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> +               strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
> +               ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +               rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;

devm_gpiod_get(&pdev->dev, "csn", GPIOD_OUT_HIGH); etc will get these
from the spawned
platform device.

Yours,
Linus Walleij
