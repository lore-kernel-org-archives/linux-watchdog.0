Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:54988 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdBCP4r (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 10:56:47 -0500
Subject: Re: [PATCH 4/6] bus: add driver for the Technologic Systems NBUS
To: Linus Walleij <linus.walleij@linaro.org>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYHHrYY-fAPnNmV94ejFJ36rhSF0SqSVHkTNq+YCRNNZw@mail.gmail.com>
 <7bc0871f-ac0a-e8a0-0c84-a0e61b3991a8@savoirfairelinux.com>
 <CACRpkdbAYyxTOq_ZAwjSJAhCbrzTaUMSG9N7t8Wq1ifTDFBLrQ@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>,
        Mark Featherston <mark@embeddedarm.com>, kris@embeddedarm.com,
        Simon Horman <horms+renesas@verge.net.au>,
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
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <3f3cd438-63dc-dea8-e17b-7eb3e588cc36@savoirfairelinux.com>
Date: Fri, 3 Feb 2017 10:56:34 -0500
MIME-Version: 1.0
In-Reply-To: <CACRpkdbAYyxTOq_ZAwjSJAhCbrzTaUMSG9N7t8Wq1ifTDFBLrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

On 02/03/2017 08:51 AM, Linus Walleij wrote:
> Your child nodes I guess will be instatiated as devices as well.
> 
> These devices will have the NBUS driver as .parent in their
> struct device I guess. Else the design of this bus is tilted.
> 
> If the NBUS driver use dev_set_drvdata(dev, state_container_cookie)
> the children can use dev_get_drvdata(dev->parent); to get a pointer to
> the same cookie.
> 
> The subdrivers don't even need to know the members of the state
> container as long as you're just passing a pointer to it. It's
> enough if you forward-declare it as a "pointer to some struct":
> 
> struct foo;
> 
> {
>    struct foo *fooptr = dev_get_drvdata(dev->parent);
>    write(fooptr, 0x10);
> 
> etc

Thanks a lot, this is perfect!

Best Regards,
Sebastien.
