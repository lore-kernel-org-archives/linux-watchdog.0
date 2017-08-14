Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36464 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdHNMgg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 08:36:36 -0400
Received: by mail-oi0-f52.google.com with SMTP id g131so82379986oic.3
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Aug 2017 05:36:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502680096.14932.8.camel@aj.id.au>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com> <1502680096.14932.8.camel@aj.id.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Aug 2017 14:36:35 +0200
Message-ID: <CACRpkdZwiXJypWQ+qGG+ZTFgma4gyRsz9b1=NSbTAPZ5pp1JoA@mail.gmail.com>
Subject: Re: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
To: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 14, 2017 at 5:08 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> There are two series on the lists expanding driver support for the Aspeed
> watchdog, one from Chris Bostic and another from myself:
>
> 1. [PATCH v5 0/2] Add ASPEED watchdog device tree properties:
>
>         https://lkml.org/lkml/2017/7/17/777

Looks all right. The SoC vs whole chip reset signal big is an
Aspeed-specific extension AFAICT.

>
> 2. [PATCH 0/2] watchdog: aspeed: External reset signal properties:
>
>         https://www.spinics.net/lists/kernel/msg2570666.html

The external reset exists also in the Faraday FTWDT010 block, in the
same bit. (No coincidence...) but neither the Gemini or the MOXA ART
is using it as far as I know.

> I don't have the datasheets for either the Moxa or Faraday SoCs, so I can't
> assess how the support I've added for the external pulse properties on Aspeed
> hardware impacts/is impacted by the merge.

It's no big deal, I can rewrite the patches in the end of the series on top
of that stuff also adding this functionality.

> Chris' changes on the otherhand look
> like they could be generalised. At least, the vendor prefix on the devicetree
> properties he defined could perhaps be changed from aspeed to faraday.

The "aspeed,reset-type" is fine since it is Aspeed-only.

External reset is part of the Faraday IP block so it should be
"faraday,external-reset-signal" or so.

I will try to see if I can find the patches and comment directly.

Yours,
Linus Walleij
