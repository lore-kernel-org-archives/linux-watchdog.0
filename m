Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40088 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbcDDP1Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 11:27:25 -0400
Date: Mon, 4 Apr 2016 08:27:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Croxon, Nigel" <nigel.croxon@hpe.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH V2] watchdog: hpwdt: Adjust documentation to match kernel
 module parameters
Message-ID: <20160404152718.GB19188@roeck-us.net>
References: <A4930445748CDC43B8495613130746F44ECE06A5@G9W0341.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4930445748CDC43B8495613130746F44ECE06A5@G9W0341.americas.hpqcorp.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 04, 2016 at 02:59:31PM +0000, Croxon, Nigel wrote:
> From: Nigel Croxon <nigel.croxon@hpe.com>
> Date: Mon, 4 Apr 2016 10:33:25 -0400
> Subject: [PATCH V2] watchdog: hpwdt: Adjust documentation to match latest kernel module parameters.
> 
> Adjust documentation to match latest kernel module parameters.
> 
> V2 - Changed insmod / rmmod to modprobe / modprobe -r
> 
Is this supposed to be v2 of the patch, or a reply to v2 ?

Please send as proper patch with a proper subject line to avoid confusing
everyone.

Thanks,
Guenter

> Signed-off-by: Nigel Croxon <nigel.croxon@hpe.com>
> ---
>  Documentation/watchdog/hpwdt.txt |   57 ++++++++++++++++++++------------------
>  1 files changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
> index 9488078..3521e8b 100644
> --- a/Documentation/watchdog/hpwdt.txt
> +++ b/Documentation/watchdog/hpwdt.txt
> @@ -1,64 +1,67 @@
> -Last reviewed: 06/02/2009
> +Last reviewed: 04/04/2016
>  
> -                     HP iLO2 NMI Watchdog Driver
> -              NMI sourcing for iLO2 based ProLiant Servers
> +                     HPE iLO NMI Watchdog Driver
> +              NMI sourcing for iLO based ProLiant Servers
>                       Documentation and Driver by
> -              Thomas Mingarelli <thomas.mingarelli@hp.com>
> +              Thomas Mingarelli <thomas.mingarelli@hpe.com>
>  
> - The HP iLO2 NMI Watchdog driver is a kernel module that provides basic
> + The HPE iLO NMI Watchdog driver is a kernel module that provides basic
>   watchdog functionality and the added benefit of NMI sourcing. Both the
>   watchdog functionality and the NMI sourcing capability need to be enabled
>   by the user. Remember that the two modes are not dependent on one another.
>   A user can have the NMI sourcing without the watchdog timer and vice-versa.
> + All references to iLO in this document imply it also works on iLO2 and all
> + subsequent generations.
>  
>   Watchdog functionality is enabled like any other common watchdog driver. That
>   is, an application needs to be started that kicks off the watchdog timer. A
>   basic application exists in the Documentation/watchdog/src directory called
>   watchdog-test.c. Simply compile the C file and kick it off. If the system
> - gets into a bad state and hangs, the HP ProLiant iLO 2 timer register will
> + gets into a bad state and hangs, the HPE ProLiant iLO timer register will
>   not be updated in a timely fashion and a hardware system reset (also known as
>   an Automatic Server Recovery (ASR)) event will occur.
>  
> - The hpwdt driver also has four (4) module parameters. They are the following:
> + The hpwdt driver also has three (3) module parameters. They are the following:
>  
> - soft_margin - allows the user to set the watchdog timer value
> - allow_kdump - allows the user to save off a kernel dump image after an NMI
> + soft_margin - allows the user to set the watchdog timer value.
> +               Default value is 30 seconds.
> + allow_kdump - allows the user to save off a kernel dump image after an NMI.
> +               Default value is 1/ON
>   nowayout    - basic watchdog parameter that does not allow the timer to
>                 be restarted or an impending ASR to be escaped.
> - priority    - determines whether or not the hpwdt driver is first on the
> -               die_notify list to handle NMIs or last. The default value
> -               for this module parameter is 0 or LAST. If the user wants to
> -               enable NMI sourcing then reload the hpwdt driver with
> -               priority=1 (and boot with nmi_watchdog=0).
> +               Default valus is set when compiling the kernel. If it is set
> +               to "Y", then there is not way of disabling the watchdog once
> +               it has been started.
>  
>   NOTE: More information about watchdog drivers in general, including the ioctl
>         interface to /dev/watchdog can be found in
>         Documentation/watchdog/watchdog-api.txt and Documentation/IPMI.txt.
>  
> - The priority parameter was introduced due to other kernel software that relied
> - on handling NMIs (like oprofile). Keeping hpwdt's priority at 0 (or LAST)
> - enables the users of NMIs for non critical events to be work as expected.
> -
>   The NMI sourcing capability is disabled by default due to the inability to
>   distinguish between "NMI Watchdog Ticks" and "HW generated NMI events" in the
>   Linux kernel. What this means is that the hpwdt nmi handler code is called
>   each time the NMI signal fires off. This could amount to several thousands of
>   NMIs in a matter of seconds. If a user sees the Linux kernel's "dazed and
>   confused" message in the logs or if the system gets into a hung state, then
> - the hpwdt driver can be reloaded with the "priority" module parameter set
> - (priority=1).
> + the hpwdt driver can be reloaded. 
>  
>   1. If the kernel has not been booted with nmi_watchdog turned off then
> -    edit /boot/grub/menu.lst and place the nmi_watchdog=0 at the end of the
> -    currently booting kernel line.
> +    edit and place the nmi_watchdog=0 at the end of the currently booting
> +    kernel line. Depending on your Linux distribution and platform setup:
> +    For non-UEFI systems
> +       /boot/grub/grub.conf   or
> +       /boot/grub/menu.lst
> +    For UEFI systems
> +      /boot/efi/EFI/distroname/grub.conf   or
> +      /boot/efi/efi/distroname/elilo.conf
>   2. reboot the sever
> - 3. Once the system comes up perform a rmmod hpwdt
> - 4. insmod /lib/modules/`uname -r`/kernel/drivers/char/watchdog/hpwdt.ko priority=1
> + 3. Once the system comes up perform a modprobe -r hpwdt
> + 4. modprobe /lib/modules/`uname -r`/kernel/drivers/watchdog/hpwdt.ko 
>  
>   Now, the hpwdt can successfully receive and source the NMI and provide a log
> - message that details the reason for the NMI (as determined by the HP BIOS).
> + message that details the reason for the NMI (as determined by the HPE BIOS).
>  
> - Below is a list of NMIs the HP BIOS understands along with the associated
> + Below is a list of NMIs the HPE BIOS understands along with the associated
>   code (reason):
>  
>  	No source found                00h
> @@ -92,4 +95,4 @@ Last reviewed: 06/02/2009
>  
>  
>   -- Tom Mingarelli
> -    (thomas.mingarelli@hp.com)
> +    (thomas.mingarelli@hpe.com)
> -- 
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
