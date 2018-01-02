Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:37451 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeABJSE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 2 Jan 2018 04:18:04 -0500
Received: by mail-io0-f194.google.com with SMTP id n14so25108865iob.4
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jan 2018 01:18:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ff1871fe837aa3a520fefe2602f8f1e13e1db244.1514475654.git.vilhelm.gray@gmail.com>
References: <cover.1514475654.git.vilhelm.gray@gmail.com> <ff1871fe837aa3a520fefe2602f8f1e13e1db244.1514475654.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2018 10:18:03 +0100
Message-ID: <CACRpkdbYiG7TOOvBa3kWtocae8NikXCdDQkR6LyPd6Umt=DHTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 28, 2017 at 5:02 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
> driver. The ISA bus driver does not perform any hardware interaction,
> and is instead just a thin layer of software abstraction to eliminate
> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
> has no dependencies and does not jeopardize the integrity of the system
> when enabled, drivers should select it when the ISA bus driver
> functionality is needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
