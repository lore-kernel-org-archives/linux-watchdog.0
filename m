Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34290 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcEaLXP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 May 2016 07:23:15 -0400
Date: Tue, 31 May 2016 07:23:06 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v5 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160531112251.GA5674@sophia>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
 <61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
 <CACRpkdaOzZ1DvEUKtomBU=GH1kYfjKJjUfM-=45PhdzZA=dPgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdaOzZ1DvEUKtomBU=GH1kYfjKJjUfM-=45PhdzZA=dPgg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 31, 2016 at 10:41:49AM +0200, Linus Walleij wrote:
>On Sat, May 28, 2016 at 12:08 AM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
>> drivers may be built for X86_64 architectures. This patch changes the
>> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
>> allowing them to build for X86_64 as they are expected to.
>>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
>Or should I apply this directly to the GPIO tree?
>
>Yours,
>Linus Walleij

Greg K-H,

Would you be able to pick up this entire patchset via driver-core; I
figure that tree is the most appropriate to receive any core ISA bus
driver changes (unless you see a more fitting path to take).

If possible, I'd like this patchset to find its way into one of the
coming release candidates in order to resolve the regression mentioned
in the cover letter: as of 4.7-rc1, the drivers which switched to
utilize the ISA bus driver are now restricted to X86_32 despite being
allowed in X86_64 in the 4.6 release.

Thanks,

William Breathitt Gray
