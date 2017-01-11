Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33389 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756366AbdAKPs0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 10:48:26 -0500
Received: by mail-qt0-f171.google.com with SMTP id v23so198802247qtb.0
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Jan 2017 07:48:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484091325-9199-11-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net> <1484091325-9199-11-git-send-email-linux@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Jan 2017 16:48:25 +0100
Message-ID: <CACRpkdakLhH1Te85deJ3Gmwo0VNSrTspcFjBA75N_vgYwESc+Q@mail.gmail.com>
Subject: Re: [PATCH 10/62] watchdog: coh901327_wdt: Convert to use device
 managed functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 11, 2017 at 12:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Use devm_clk_get() if the device parameter is not NULL
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Replace request_irq, request_threaded_irq, and request_any_context_irq
>   with their device managed equivalent
> - Replace &pdev->dev with dev if 'struct device *dev' is a declared
>   variable
> - Use devm_watchdog_register_driver() to register watchdog device
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
