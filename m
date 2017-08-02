Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35756 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdHBIU4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 04:20:56 -0400
Received: by mail-it0-f42.google.com with SMTP id h199so20109756ith.0
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Aug 2017 01:20:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714203218.14409-5-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com> <20170714203218.14409-5-sebastien.bourdelin@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:20:54 +0200
Message-ID: <CACRpkdazo22+xLkyjM5w9K-SmRSm4Hr1GfC5LN2s3M7wrYJ+RA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] bus: add driver for the Technologic Systems NBUS
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>,
        Rob Herring <robh@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Featherston <mark@embeddedarm.com>, kris@embeddedarm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 14, 2017 at 10:32 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> This driver implements a GPIOs bit-banged bus, called the NBUS by
> Technologic Systems. It is used to communicate with the peripherals in
> the FPGA on the TS-4600 SoM.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v4 -> v5:
>   - fix missing signed off

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
