Return-path: <vilhelm.gray@gmail.com>
Date: Fri, 8 Apr 2016 08:03:38 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/10] watchdog: ebc-c384_wdt: Utilize the ISA bus driver
Message-ID: <20160408120338.GA18202@sophia>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
 <1f5bf2e21006f0fd4f10ab3948cf69a737c0b039.1460040201.git.vilhelm.gray@gmail.com>
 <20160408003535.GA10211@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160408003535.GA10211@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Apr 07, 2016 at 05:35:35PM -0700, Guenter Roeck wrote:
>I am a bit concerend that the newly introduced ISA_BUS is not automatically
>enabled. Effectively this means that all drivers depending on it will
>be disabled until someone enables ISA_BUS in the distribution.
>
>Is this a concern for anyone but me ?
>
>Anyway, since you are the driver maintainer, I assume that you are ok
>with it, so
>
>Acked-by: Guenter Roeck <linux@roeck-us.net>
>
>Side note for Wim: ISA_BUS was introduced with commit b3c1be1b789c
>("base: isa: Remove X86_32 dependency") in -next.
>
>Guenter

Since the ISA bus lacks standardized probing functionality, and the
majority of ISA devices I've encountered expect the user to start
writing to the device's I/O port addresses from the get-go, I think
ISA_BUS should remain an explicit dependency rather than become selected
when a user chooses a driver. That is to say, it is more appropriate for
a user to explicitly enable ISA_BUS if their system has an ISA bus;
otherwise a user may enable a driver with the expectation of a device
probe, whereas the driver will simply start writing to I/O port
addresses unexpectedly.

William Breathitt Gray
