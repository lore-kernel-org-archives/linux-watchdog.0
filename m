Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:34245 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbdHBId5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 04:33:57 -0400
Received: by mail-it0-f47.google.com with SMTP id m34so10067490iti.1
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Aug 2017 01:33:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714203218.14409-4-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com> <20170714203218.14409-4-sebastien.bourdelin@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:33:55 +0200
Message-ID: <CACRpkdbhQoDY6aKxLjEfU0ydUocCd_qXBSvJqz96MKU9cSQXVA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: bus: Add documentation for the
 Technologic Systems NBUS
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

> Add binding documentation for the Technologic Systems NBUS that is used
> to interface with peripherals in the FPGA of the TS-4600 SoM.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v4 -> v5:
>   - fix missing signed off

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
