Return-path: <nigel.croxon@hpe.com>
From: "Croxon, Nigel" <nigel.croxon@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH] watchdog: hpwdt: Adjust documentation to match kernel
 module parameters
Date: Fri, 1 Apr 2016 10:19:27 +0000
Message-ID: <A4930445748CDC43B8495613130746F44ECD77DD@G9W0735.americas.hpqcorp.net>
References: <A4930445748CDC43B8495613130746F44ECD7611@G9W0735.americas.hpqcorp.net>
 <20160401000626.GC15892@roeck-us.net>
In-Reply-To: <20160401000626.GC15892@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hello Roeck,

I did the changes, Tom did the review and is in the sign-off-path.

-Nigel


-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net]=20
Sent: Thursday, March 31, 2016 8:06 PM
To: Croxon, Nigel <nigel.croxon@hpe.com>
Cc: wim@iguana.be; linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: hpwdt: Adjust documentation to match kernel =
module parameters

On Thu, Mar 31, 2016 at 10:32:32PM +0000, Croxon, Nigel wrote:
> From: Nigel Croxon <nigel.croxon@hpe.com>
> Date: Thu, 31 Mar 2016 09:54:56 -0400
> Subject: [PATCH] watchdog: hpwdt: Adjust documentation to match latest ke=
rnel module parameters.
>=20
> Adjust documentation to match latest kernel module parameters.
>=20
> Signed-off-by: Nigel Croxon <nigel.croxon@hpe.com>
> Signed-off-by: Thomas Mingarelli <thomas.mingarelli@hpe.com>

Are the two of you in the sign-off path, or did one of you review the chang=
es ?

> ---
>  Documentation/watchdog/hpwdt.txt |   55 ++++++++++++++++++++------------=
------
>  1 files changed, 29 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/watchdog/hpwdt.txt=20
> b/Documentation/watchdog/hpwdt.txt
> index 9488078..0cb6c16 100644
> --- a/Documentation/watchdog/hpwdt.txt
> +++ b/Documentation/watchdog/hpwdt.txt
> @@ -1,64 +1,67 @@
> -Last reviewed: 06/02/2009
> +Last reviewed: 03/31/2016
> =20
> -                     HP iLO2 NMI Watchdog Driver
> -              NMI sourcing for iLO2 based ProLiant Servers
> +                     HPE iLO NMI Watchdog Driver
> +              NMI sourcing for iLO based ProLiant Servers
>                       Documentation and Driver by
> -              Thomas Mingarelli <thomas.mingarelli@hp.com>
> +              Thomas Mingarelli <thomas.mingarelli@hpe.com>
> =20
> - The HP iLO2 NMI Watchdog driver is a kernel module that provides=20
> basic
> + The HPE iLO NMI Watchdog driver is a kernel module that provides=20
> + basic
>   watchdog functionality and the added benefit of NMI sourcing. Both the
>   watchdog functionality and the NMI sourcing capability need to be enabl=
ed
>   by the user. Remember that the two modes are not dependent on one anoth=
er.
>   A user can have the NMI sourcing without the watchdog timer and vice-ve=
rsa.
> + All references to iLO in this document imply it also works on iLO2=20
> + and all subsequent generations.
> =20
>   Watchdog functionality is enabled like any other common watchdog driver=
. That
>   is, an application needs to be started that kicks off the watchdog time=
r. A
>   basic application exists in the Documentation/watchdog/src directory ca=
lled
>   watchdog-test.c. Simply compile the C file and kick it off. If the=20
> system
> - gets into a bad state and hangs, the HP ProLiant iLO 2 timer=20
> register will
> + gets into a bad state and hangs, the HPE ProLiant iLO timer register=20
> + will
>   not be updated in a timely fashion and a hardware system reset (also kn=
own as
>   an Automatic Server Recovery (ASR)) event will occur.
> =20
> - The hpwdt driver also has four (4) module parameters. They are the foll=
owing:
> + The hpwdt driver also has three (3) module parameters. They are the fol=
lowing:
> =20
> - soft_margin - allows the user to set the watchdog timer value
> - allow_kdump - allows the user to save off a kernel dump image after=20
> an NMI
> + soft_margin - allows the user to set the watchdog timer value.
> +               Default value is 30 seconds.
> + allow_kdump - allows the user to save off a kernel dump image after an =
NMI.
> +               Default value is 1/ON
>   nowayout    - basic watchdog parameter that does not allow the timer to
>                 be restarted or an impending ASR to be escaped.
> - priority    - determines whether or not the hpwdt driver is first on th=
e
> -               die_notify list to handle NMIs or last. The default value
> -               for this module parameter is 0 or LAST. If the user wants=
 to
> -               enable NMI sourcing then reload the hpwdt driver with
> -               priority=3D1 (and boot with nmi_watchdog=3D0).
> +               Default valus is set when compiling the kernel. If it=20
> + is set

s/valus/value/

> +               to "Y", then there is not way of disabling the watchdog o=
nce
> +               it has been started.
> =20
>   NOTE: More information about watchdog drivers in general, including the=
 ioctl
>         interface to /dev/watchdog can be found in
>         Documentation/watchdog/watchdog-api.txt and Documentation/IPMI.tx=
t.
> =20
> - The priority parameter was introduced due to other kernel software=20
> that relied
> - on handling NMIs (like oprofile). Keeping hpwdt's priority at 0 (or=20
> LAST)
> - enables the users of NMIs for non critical events to be work as expecte=
d.
> -
>   The NMI sourcing capability is disabled by default due to the inability=
 to
>   distinguish between "NMI Watchdog Ticks" and "HW generated NMI events" =
in the
>   Linux kernel. What this means is that the hpwdt nmi handler code is cal=
led
>   each time the NMI signal fires off. This could amount to several thousa=
nds of
>   NMIs in a matter of seconds. If a user sees the Linux kernel's "dazed a=
nd
>   confused" message in the logs or if the system gets into a hung=20
> state, then
> - the hpwdt driver can be reloaded with the "priority" module=20
> parameter set
> - (priority=3D1).
> + the hpwdt driver can be reloaded.=20
> =20
>   1. If the kernel has not been booted with nmi_watchdog turned off then
> -    edit /boot/grub/menu.lst and place the nmi_watchdog=3D0 at the end o=
f the
> -    currently booting kernel line.
> +    edit and place the nmi_watchdog=3D0 at the end of the currently boot=
ing
> +    kernel line. Depending on your Linux distribution and platform setup=
:
> +    For non-UEFI systems
> +       /boot/grub/grub.conf   or
> +       /boot/grub/menu.lst
> +    For UEFI systems
> +      /boot/efi/EFI/distroname/grub.conf   or
> +      /boot/efi/efi/distroname/elilo.conf
>   2. reboot the sever
>   3. Once the system comes up perform a rmmod hpwdt
> - 4. insmod /lib/modules/`uname=20
> -r`/kernel/drivers/char/watchdog/hpwdt.ko priority=3D1
> + 4. insmod /lib/modules/`uname -r`/kernel/drivers/watchdog/hpwdt.ko

Can you update this text to refer to modprobe / modprobe -r instead of insm=
od / rmmod ?

> =20
>   Now, the hpwdt can successfully receive and source the NMI and=20
> provide a log
> - message that details the reason for the NMI (as determined by the HP BI=
OS).
> + message that details the reason for the NMI (as determined by the HPE B=
IOS).
> =20
> - Below is a list of NMIs the HP BIOS understands along with the=20
> associated
> + Below is a list of NMIs the HPE BIOS understands along with the=20
> + associated
>   code (reason):
> =20
>  	No source found                00h
> @@ -92,4 +95,4 @@ Last reviewed: 06/02/2009
> =20
> =20
>   -- Tom Mingarelli
> -    (thomas.mingarelli@hp.com)
> +    (thomas.mingarelli@hpe.com)
> --
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-watchdog" in the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
