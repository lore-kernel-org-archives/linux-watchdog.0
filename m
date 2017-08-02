Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36281 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdHBIYF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 04:24:05 -0400
Received: by mail-io0-f181.google.com with SMTP id g35so17618383ioi.3
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Aug 2017 01:24:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170708003330.GA15374@embeddedgus>
References: <20170708003330.GA15374@embeddedgus>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:24:03 +0200
Message-ID: <CACRpkda3N-taTuBXJu626r8UCU34vOkvXFqQXvGnwkha_ywTbg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: coh901327_wdt: constify watchdog_ops structure
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 8, 2017 at 2:33 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:

> Check for watchdog_ops structures that are only stored in the ops field of
> a watchdog_device structure. This field is declared const, so watchdog_ops
> structures that have this property can be declared as const also.
>
> This issue was detected using Coccinelle and the following semantic patch:
>
> @r
> disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i@p = { ... };
>
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops = &i@p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct watchdog_ops i = { ... };
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
