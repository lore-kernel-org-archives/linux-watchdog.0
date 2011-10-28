Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab1J1QXA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Oct 2011 12:23:00 -0400
Date: Fri, 28 Oct 2011 12:22:43 -0400
From: Don Zickus <dzickus@redhat.com>
To: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: watchdogs and kdump
Message-ID: <20111028162243.GX3452@redhat.com>
References: <20111027203029.GR3452@redhat.com>
 <4EAACE56.90209@udio.cujae.edu.cu>
 <20111028154822.GW3452@redhat.com>
 <4EAAD492.3000908@udio.cujae.edu.cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EAAD492.3000908@udio.cujae.edu.cu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 28, 2011 at 12:13:06PM -0400, Alejandro Cabrera wrote:
> On 10/28/2011 11:48 AM, Don Zickus wrote:
> >On Fri, Oct 28, 2011 at 11:46:30AM -0400, Alejandro Cabrera wrote:
> >>Hi
> >>
> >>I dont know kjump :), but seeing it's description I think that you
> >>could use a temporal thread executed in the context of kdump that
> >>ping the watchdog at certain intervals like watchdogd does at
> >>user-space.
> >Sure.  Add something like watchdogd isn't difficult.  My problem is
> >getting enough time to boot the second kernel to run that daemon.
> >Depending on when the watchdog was last kicked, the machine may reboot
> >while trying to initialize the cpu in the second kernel. :-(
> 
> You can create the daemon in kdump before the second kernel boots
> and manage that daemon as a kdump thread.

Unfortunately, you can't do that as only one kernel runs at any given
time.  When the first kernel panics, it does some quick and dirty
shutdowns of platform specific chips, forces all the cpus into a halt
state and then longjmps into the second kernel.

Cheers,
Don

> 
> While the second kernel is booting kdump will act as the owner of
> the watchdog device and when the second kernel is stable, kdump
> passes the control  of it to the watchdog kernel device driver.
> If is not problem, that two threads (kdump daemon and second kernel
> watchdog driver) access to the device simultaneously and without
> sync (I think IMMO that for pinging the watchdog it is not a issue)
> you can bypass the part that second kernel wdt drivers waits a
> notification from kdump to start working with the watchdog device.
> 
> Regards
> Alejandro
> 
> 
> Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
> Habana, Cuba: http://www.congresouniversidad.cu
> Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu
> 
> Participe en el Segundo Congreso Medio Ambiente Construido y
> Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de
> 2011, Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
