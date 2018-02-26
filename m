Return-Path: <arndbergmann@gmail.com>
Return-path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180226032227.14615-3-jerry.hoemann@hpe.com>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com> <20180226032227.14615-3-jerry.hoemann@hpe.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 15:11:01 +0100
Message-ID: <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rwright@hpe.com, maurice.a.saldivar@hpe.com,
	Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
	Josh Poimboeuf <jpoimboe@redhat.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> Gen8 and prior Proliant systems supported the "CRU" interface
> to firmware.  This interfaces allows linux to "call back" into firmware
> to source the cause of an NMI.  This feature isn't fully utilized
> as the actual source of the NMI isn't printed, the driver only
> indicates that the source couldn't be determined when the call
> fails.
>
> With the advent of Gen9, iCRU replaces the CRU. The call back
> feature is no longer available in firmware.  To be compatible and
> not attempt to call back into firmware on system not supporting CRU,
> the SMBIOS table is consulted to determine if it is safe to
> make the call back or not.
>
> This results in about half of the driver code being devoted
> to either making CRU calls or determing if it is safe to make
> CRU calls.  As noted, the driver isn't really using the results of
> the CRU calls.
>
> Furthermore, as a consequence of the Spectre security issue, the
> BIOS/EFI calls are being wrapped into Spectre-disabling section.
> Removing the call back in hpwdt_pretimeout assists in this effort.
>
> As the CRU sourcing of the NMI isn't required for handling the
> NMI and there are security concerns with making the call back, remove
> the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
> the system had the CRU interface.
>
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

This avoids a warning in mainline kernels, so that's great:

drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
found in RETPOLINE build

I wonder what we do about stable kernels. Are both this patch and the patch
that added the objtool warning message candidates for backports to
stable kernels?

       Arnd
