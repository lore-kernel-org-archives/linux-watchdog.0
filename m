Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36364 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbdHBIT6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 04:19:58 -0400
Received: by mail-it0-f42.google.com with SMTP id 77so20083797itj.1
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Aug 2017 01:19:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714200853.10362-6-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com> <20170714200853.10362-6-sebastien.bourdelin@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:19:56 +0200
Message-ID: <CACRpkdbYibgBPFQJGSX0YaewheXzqQfLQ_h7J=bQ_wZeKF+WWA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] ARM: dts: TS-4600: add NBUS support
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

On Fri, Jul 14, 2017 at 10:08 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> This commit enables the NBUS on the TS-4600, using the ts-nbus driver.
>
> ---
> Changes v3 -> v4:
>   - rebase on master
>   - fix vendor prefixes for dts properties (suggested by Rob Herring)
>   - v3 was acked by Linus Walleij

I ACK this too.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
