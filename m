Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34465 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbdHOHB0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Aug 2017 03:01:26 -0400
Received: by mail-wr0-f176.google.com with SMTP id l9so491341wrl.1
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Aug 2017 00:01:25 -0700 (PDT)
Date: Tue, 15 Aug 2017 08:01:22 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] mfd: dm355evm_msp: move header file out of I2C
 realm
Message-ID: <20170815070122.m6mesqzqbilnwrab@dell>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170814163424.2197-2-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 14 Aug 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Change since V1:
> 
> * rebased to v4.13-rc5, no changes needed
> * acks added. I think none are missing.
> 
>  drivers/input/misc/dm355evm_keys.c        | 2 +-
>  drivers/mfd/dm355evm_msp.c                | 2 +-
>  drivers/rtc/rtc-dm355evm.c                | 2 +-
>  include/linux/{i2c => mfd}/dm355evm_msp.h | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
