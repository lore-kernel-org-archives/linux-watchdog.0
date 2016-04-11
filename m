Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36684 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbcDKG7P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Apr 2016 02:59:15 -0400
Received: by mail-oi0-f44.google.com with SMTP id y204so196820505oie.3
        for <linux-watchdog@vger.kernel.org>; Sun, 10 Apr 2016 23:59:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
Date: Mon, 11 Apr 2016 08:59:13 +0200
Message-ID: <CACRpkdY5j8Qq83pQVYGBJvgfN0MC51aq3UM-7T1Z7+R_dzJjXw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Use the ISA bus driver for PC/104 and ISA devices
From: Linus Walleij <linus.walleij@linaro.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexandre Courbot <gnurou@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 7, 2016 at 4:47 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> Two new ISA bus driver macros are introduced in this patchset:
> module_isa_driver and max_num_isa_dev.
(...)
>   gpio: 104-dio-48e: Utilize the ISA bus driver
>   gpio: 104-idi-48: Utilize the ISA bus driver
>   gpio: 104-idio-16: Utilize the ISA bus driver
>   gpio: ws16c48: Utilize the ISA bus driver

For these:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

So if the driver core maintainers want to merge this as part
of the series, go ahead.

Yours,
Linus Walleij
