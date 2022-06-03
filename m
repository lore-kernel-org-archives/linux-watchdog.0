Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A2C43334
	for <linux-watchdog@archiver.kernel.org>; Fri,  3 Jun 2022 22:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiFCWRe (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiFCWRd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Jun 2022 18:17:33 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA351837B
        for <linux-watchdog@vger.kernel.org>; Fri,  3 Jun 2022 15:17:29 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v22so16087840ybd.5
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Jun 2022 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxzrEA8REDaWwoEI9SXIgLGpIqpF9GSswLISAQIrJrw=;
        b=i0f4i2hSBuOwU6Z41zZp12Xn6+SOGWUZoafYmhtlRSD81/YGKiB1a3m9qdHb90RuKw
         qVRQ9b2yETSdL7OWP0uGpezSJSoI1oKCTTrN4ZsFqGvUDpToHAVB4Qpv/GsVsDDF8Wx2
         eJQ0KBbU3MkUuanKZ+0Bs8ScSTt7loYEkVUyfdYbXrOLue05KM0lxYKXm6UJV4GGXRrb
         EX+zfLF3pDx5Llz75rqxEW7Y4X7BV+ZZhiCDfugMQiZ10IYeDO9mX9vNM1hSaH4NuRzK
         3K1yZswoM1W83g6r0fQRP4EgkK7wT79byzWjUbX/MRrrqbb9CW5UNK08uOiKje6SRTOw
         myRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxzrEA8REDaWwoEI9SXIgLGpIqpF9GSswLISAQIrJrw=;
        b=mIA1Kvb9AShdVqMz3Nr5GyxlIomPYMWWG4UFgqPKOxzmD3tjvQeNcTgEjDEs3kuMTI
         LVzPKA1C3nS8KsMOxHIA57Nhk697qFUFqjFMWh2jrgecgx4oSiRuVLgPvtZ00/k3tnPk
         B20hy6P1uk3IjxtjvZerBadxWja9N5ABkNhtnPm4INSO6gVkI0m/7DaHx6mJ0/AuF1wj
         V6Uur6kyGwBsC2zoSfpvdkaGfiiVoC0SCl+6eAEeg3ykHrNYtoJMjLQSA/A6kXWbsDY9
         5VGU7iShnaMXWRBSFQpsBckBPM9luttk4AF6f0hjCbSE5Wv/Qp8fPRqLUmJ/N6F7sVuh
         9fzw==
X-Gm-Message-State: AOAM530X3EBen9O+Z2fdF4IdcnrHws1Ml7fFKMvKroDKVMGwhcM/UB3j
        1/jteGfgw9uhaiGLzh1c1QhW//eEZzx1ynrctK2K2w==
X-Google-Smtp-Source: ABdhPJwY0Fv0WkN3GP24DF4ef8lrbyIIqDa/jyBs+8pVca4YN0rLWkYrK6fB3G72aScon/VocRlxYEWULbwUdPCqnb8=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr13248417ybp.492.1654294648626; Fri, 03
 Jun 2022 15:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220526014127.2872254-1-robh@kernel.org>
In-Reply-To: <20220526014127.2872254-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Jun 2022 00:17:17 +0200
Message-ID: <CACRpkdYRumCbt4tQs2+KeMdVjEt07J=0hAUynTHKeQ3mC1o5kQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: faraday: Fix typo in example
 'timeout-sec' property
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, May 26, 2022 at 3:41 AM Rob Herring <robh@kernel.org> wrote:

> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
>
> The correct common watchdog property is 'timeout-sec', not 'timeout-secs'.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This kind of stuff is exactly what we wanted schema to find and fix.
And now it is delivering. Success!

Yours,
Linus Walleij
