Return-path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <eb31f2d10c9cc199d69eca2fe16cf31b9417c5ef.1464380034.git.vilhelm.gray@gmail.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
	<eb31f2d10c9cc199d69eca2fe16cf31b9417c5ef.1464380034.git.vilhelm.gray@gmail.com>
Date: Sat, 28 May 2016 12:35:08 -0700
Message-ID: <CA+55aFxOzwKE8jJCWuZHCvUAdjRHZJmaJwMroXP3XYH2q3wynw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] isa: Allow ISA-style drivers on modern systems
From: Linus Torvalds <torvalds@linux-foundation.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"the arch/x86 maintainers" <x86@kernel.org>, linux-next <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, May 27, 2016 at 3:08 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> Several modern devices, such as PC/104 cards, are expected to run on
> modern systems via an ISA bus interface. Since ISA is a legacy interface
> for most modern architectures, ISA support should remain disabled in
> general. Support for ISA-style drivers should be enabled on a per driver
> basis.
>
> To allow ISA-style drivers on modern systems, this patch introduces the
> ISA_BUS_API and ISA_BUS Kconfig options. The ISA bus driver will now
> build conditionally on the ISA_BUS_API Kconfig option, which defaults to
> the legacy ISA Kconfig option. The ISA_BUS Kconfig option allows the
> ISA_BUS_API Kconfig option to be selected on architectures which do not
> enable ISA (e.g. X86_64).
>
> The ISA_BUS Kconfig option is currently only implemented for X86
> architectures. Other architectures may have their own ISA_BUS Kconfig
> options added as required.
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

This version seems fine and safe. I didn't see the other patches in
the series (not cc'd to me), but at least this one would seem to do
the right thing and expose part of the ISA code without causing other
architectures to possibly lose it.

              Linus
