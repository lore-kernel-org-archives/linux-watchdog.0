Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35987 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbdBCNvR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 08:51:17 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so11572482itd.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Feb 2017 05:51:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7bc0871f-ac0a-e8a0-0c84-a0e61b3991a8@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYHHrYY-fAPnNmV94ejFJ36rhSF0SqSVHkTNq+YCRNNZw@mail.gmail.com> <7bc0871f-ac0a-e8a0-0c84-a0e61b3991a8@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 Feb 2017 14:51:15 +0100
Message-ID: <CACRpkdbAYyxTOq_ZAwjSJAhCbrzTaUMSG9N7t8Wq1ifTDFBLrQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] bus: add driver for the Technologic Systems NBUS
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 1, 2017 at 8:56 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:
> On 12/30/2016 02:58 AM, Linus Walleij wrote:

>>> +static struct ts_nbus *ts_nbus;
>>
>> Nopes. No singletons please.
>>
>> Use the state container pattern:
>> Documentation/driver-model/design-patterns.txt
>
> I understand the idea but have problem to find a good way to implement it.
>
> Other drivers using the NBUS which are child nodes in the device tree
> will use the ts_nbus_write() and ts_nbus_read() functions, it means these
> drivers should have a pointer to the allocated ts_nbus and pass it to
> the write() and read() functions as an argument if i'm not using a
> singleton here.
> But i'm lacking knowledge on how to properly share this pointer when
> initializing the NBUS driver with the child nodes.

Your child nodes I guess will be instatiated as devices as well.

These devices will have the NBUS driver as .parent in their
struct device I guess. Else the design of this bus is tilted.

If the NBUS driver use dev_set_drvdata(dev, state_container_cookie)
the children can use dev_get_drvdata(dev->parent); to get a pointer to
the same cookie.

The subdrivers don't even need to know the members of the state
container as long as you're just passing a pointer to it. It's
enough if you forward-declare it as a "pointer to some struct":

struct foo;

{
   struct foo *fooptr = dev_get_drvdata(dev->parent);
   write(fooptr, 0x10);

etc

Yours,
Linus Walleij
