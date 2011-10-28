Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:41053 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1J1QHH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Oct 2011 12:07:07 -0400
Received: from newton.cujae.edu.cu (mtaint1.cujae.edu.cu [10.8.1.212])
	by mtaext1.cujae.edu.cu (Postfix) with ESMTP id 671B33E088
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Oct 2011 11:52:06 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id 6871A24037
	for <linux-watchdog@vger.kernel.org>;
	Fri, 28 Oct 2011 12:13:33 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000276127.msg
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Oct 2011 12:01:16 -0400
Message-ID: <4EAAD492.3000908@udio.cujae.edu.cu>
Date: Fri, 28 Oct 2011 12:13:06 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>, linux-watchdog@vger.kernel.org
Subject: Re: watchdogs and kdump
References: <20111027203029.GR3452@redhat.com>
	<4EAACE56.90209@udio.cujae.edu.cu>
	<20111028154822.GW3452@redhat.com>
In-Reply-To: <20111028154822.GW3452@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/28/2011 11:48 AM, Don Zickus wrote:
> On Fri, Oct 28, 2011 at 11:46:30AM -0400, Alejandro Cabrera wrote:
>> Hi
>>
>> I dont know kjump :), but seeing it's description I think that you
>> could use a temporal thread executed in the context of kdump that
>> ping the watchdog at certain intervals like watchdogd does at
>> user-space.
> Sure.  Add something like watchdogd isn't difficult.  My problem is
> getting enough time to boot the second kernel to run that daemon.
> Depending on when the watchdog was last kicked, the machine may reboot
> while trying to initialize the cpu in the second kernel. :-(

You can create the daemon in kdump before the second kernel boots and 
manage that daemon as a kdump thread.

While the second kernel is booting kdump will act as the owner of the 
watchdog device and when the second kernel is stable, kdump passes the 
control  of it to the watchdog kernel device driver.
If is not problem, that two threads (kdump daemon and second kernel 
watchdog driver) access to the device simultaneously and without sync (I 
think IMMO that for pinging the watchdog it is not a issue) you can 
bypass the part that second kernel wdt drivers waits a notification from 
kdump to start working with the watchdog device.

Regards
Alejandro


Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
