Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:51603 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab1J1PrJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Oct 2011 11:47:09 -0400
Received: from newton.cujae.edu.cu (mtaint1.cujae.edu.cu [10.8.1.212])
	by mtaext1.cujae.edu.cu (Postfix) with ESMTP id ABEF93E01E
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Oct 2011 11:25:29 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id 6027124098
	for <linux-watchdog@vger.kernel.org>;
	Fri, 28 Oct 2011 11:46:56 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000276050.msg
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Oct 2011 11:34:39 -0400
Message-ID: <4EAACE56.90209@udio.cujae.edu.cu>
Date: Fri, 28 Oct 2011 11:46:30 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>, linux-watchdog@vger.kernel.org
Subject: Re: watchdogs and kdump
References: <20111027203029.GR3452@redhat.com>
In-Reply-To: <20111027203029.GR3452@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi

I dont know kjump :), but seeing it's description I think that you could 
use a temporal thread executed in the context of kdump that ping the 
watchdog at certain intervals like watchdogd does at user-space.

Regards
Alejandro


On 10/27/2011 4:30 PM, Don Zickus wrote:
> Hi,
>
> I was assisting a customer the other day debugging a kdump[1] problem, when we
> noticed the real problem was the hardware watchdog was firing and
> rebooting the box.
>
> Of course, this can be inconvienant if the panic happens right before the
> watchdog is supposed to be kicked, leading to a spontaneous reboot before
> the second kernel finishes booting and loading the watchdog module.
>
> I was trying to think of a way to solve this and thought, one way to
> minimize the problem is to kick the watchdog before we jump into the kdump
> kernel.  Another way is to disable the watchdog entirely, but that doesn't
> work on all hardware I believe.
>
> Anyway, I was posting on the watchdog mailing list to see if anyone had any
> ideas that might help.  And if my above idea to kick the watchdog before
> jumping into the kdump kernel seems ok, then an api would need to be
> developed.
>
> I am willing to do any coding and testing necessary, but before I did, I
> wanted help to get a direction to go in first.
>
> Thoughts?
>
> Cheers,
> Don
>
> [1] - I am ignorantly assuming everyone knows what kdump is.  Kdumping is
> the ability to jump into a previously loaded kernel in the case of a
> panic.  This kdump (second) kernel would run in reserved memory, copy the
> first kernel's memory to a file and save it to a pre-determined location.
> There is no system reboot in between the first and second kernel, so no
> chance for the watchdog to disarm itself.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
