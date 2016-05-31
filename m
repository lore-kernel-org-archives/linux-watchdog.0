Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36672 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbcEaIlu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 May 2016 04:41:50 -0400
Received: by mail-oi0-f49.google.com with SMTP id j1so292264610oih.3
        for <linux-watchdog@vger.kernel.org>; Tue, 31 May 2016 01:41:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
	<61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
Date: Tue, 31 May 2016 10:41:49 +0200
Message-ID: <CACRpkdaOzZ1DvEUKtomBU=GH1kYfjKJjUfM-=45PhdzZA=dPgg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] gpio: Allow PC/104 devices on X86_64
From: Linus Walleij <linus.walleij@linaro.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexandre Courbot <gnurou@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, May 28, 2016 at 12:08 AM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
> drivers may be built for X86_64 architectures. This patch changes the
> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
> allowing them to build for X86_64 as they are expected to.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Or should I apply this directly to the GPIO tree?

Yours,
Linus Walleij
