Return-path: <vilhelm.gray@gmail.com>
Date: Sat, 9 Apr 2016 09:50:50 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, gregkh@linuxfoundation.org,
	tglx@linutronix.de, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: stx104: Change STX104 dependency to ISA_BUS
Message-ID: <20160409135050.GA10418@sophia>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
 <783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
 <20160408004503.GB10211@roeck-us.net>
 <20160408123158.GB18202@sophia>
 <5707AF91.5010704@roeck-us.net>
 <20160408150922.GA28058@sophia>
 <20160408182801.GB7083@roeck-us.net>
 <20160408192723.GA31687@sophia>
 <20160409135814.359e24d6@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160409135814.359e24d6@lxorguk.ukuu.org.uk>
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Apr 09, 2016 at 01:58:14PM +0100, One Thousand Gnomes wrote:
>> I believe this is the source of the issues I encountered on my initial
>> attempt to decouple the X86_32 dependency from the ISA option. I suspect
>> if I add an explicit X86_32 dependency to the PNPBIOS driver, I will be
>> able to remove the X86_32 dependency from the ISA option without
>> incident from the other drivers.
>
>That would be correct. PnPBIOS is obsoleted by ACPI so a 64bit x86
>platform shouldn't be using PnPBIOS nor anything non x86. Strictly
>speaking PnpBIOS is not ISA, it's onboard devices.
>
>ISA devices that can be enumerated are usually enumerated via ISAPnP
>which is platform independent.
>
>Quite a few of the ISA drivers if you review them more carefully have
>other endian and size assumptions, IRQ assumptions and probably fun bugs
>because they've simply never been run on anything else even when it is
>possible.
>
>Alan

It looks like I'm in quite a pickle. Even if the patch for the PnPBIOS
driver removes the errors and warnings, there may be runtime bugs in
other drivers expecting X86_32. The only way I can see to prevent that
is to audit all the drivers which depend on the ISA option -- a behemoth
undertaking which would be far too impractical and error-prone for me to
do.

The alternative then is to do as Guenter Roeck suggests and
introduce/select ISA_BUS in the various other architectures which lack
it. In this scenario, I would expect the ISA option to be avoided for
new drivers, wherefore the ISA_BUS option can be used regardless of
architecture configuration.

I would prefer for a single ISA configuration option, but not at the
expense on breaking existing drivers; therefore, I will work instead on
adding the necessary ISA_BUS code to the various areas which require
them. If there are problems with this plan too, let me know.

William Breathitt Gray
