Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33668 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdCNNX7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Mar 2017 09:23:59 -0400
Received: by mail-io0-f181.google.com with SMTP id f84so102819390ioj.0
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Mar 2017 06:23:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <82dfdbb8-58fc-45b4-685c-98be11341e45@savoirfairelinux.com>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170203194729.20995-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYfGmVBYgAc4KZGN6634WM_EyzNj_SBbALEs4WYipXRQA@mail.gmail.com> <82dfdbb8-58fc-45b4-685c-98be11341e45@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Mar 2017 14:23:57 +0100
Message-ID: <CACRpkdbjANV+kiO_W9+=OL=fzPtTVwH2CpWDmNa50t3JaHTFkQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] bus: add driver for the Technologic Systems NBUS
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>,
        Rob Herring <robh@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Featherston <mark@embeddedarm.com>, kris@embeddedarm.com,
        Simon Horman <horms+renesas@verge.net.au>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>,
        damien.riegel@savoirfairelinux.com,
        Lucile Quirion <lucile.quirion@savoirfairelinux.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 22, 2017 at 5:56 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:
> On 02/04/2017 05:14 AM, Linus Walleij wrote:

>>> +       gpiod_set_array_value_cansleep(gpios->ndescs, gpios->desc, values);
>>
>> This can also fail and you should check the return code and print an error
>> message if it does.
>>
> As far as i understood, the "gpiod_set_array_value_cansleep(...)"
> function doesn't return
> anything, it will return immediately if gpios->desc is null but nothing
> else.
> Did i miss something?

No I did, sorry about that.

We *should* make these functions return errors but currently they do not.

>> Error codes?
>>
> Same question here, these functions only make call to
> "gpiod_set_value_cansleep(...)",
> which as far as i understood doesn't return any error code.

Yeah, forget that.

>>> +               gpiod_set_value_cansleep(ts_nbus->csn, 1);
>>
>> Here too.
>>
> Same question, doesn't seem to have an error code.

That too.

Yours,
Linus Walleij
