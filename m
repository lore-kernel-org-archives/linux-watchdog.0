Return-path: <alexander.stein@systec-electronic.com>
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: watchdog timeout in sub-seconds?
Date: Tue, 14 Apr 2015 10:15:44 +0200
Message-ID: <4398543.5EAQg64u7T@ws-stein>
In-Reply-To: <552BCA3E.5010305@roeck-us.net>
References: <3042537.C3OUI66IzY@ws-stein> <552BCA3E.5010305@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Monday 13 April 2015 06:53:02, Guenter Roeck wrote:
> On 04/13/2015 06:33 AM, Alexander Stein wrote:
> > Hi,
> >
> > is there a specific reason that the timeout in the linux watchdog drivers is
> > only provided in seconds resolution? What about timeouts in ms area/precision?
> >
> 
> The question would probably be why not. On a loaded system, sub-second
> watchdog timeouts are quite unreasonable.
> 
> In other words, you would have to provide a very good argument for
> sub-second timeouts if you see the need for it. That some hardware
> may require it is not really an argument here - this is all about
> user space - kernel interface, not about limitations of specific
> hardware.

Well, after discussing this a bit why the hardware watchdog has ms resolution support it turns out this is mainly for safety related devices which seem to require such short timeouts. It doesn't seem to be required on this linux based board though. So this issue has been cleared itself.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
