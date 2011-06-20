Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext2.cujae.edu.cu ([200.55.139.27]:60308 "EHLO
	mtaext2.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab1FTUnn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Jun 2011 16:43:43 -0400
Received: from newton.cujae.edu.cu (mtaint2.cujae.edu.cu [10.8.1.213])
	by mtaext2.cujae.edu.cu (Postfix) with ESMTP id 50BDB3E05C
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jun 2011 17:45:03 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id F3A38240B0
	for <linux-watchdog@vger.kernel.org>;
	Mon, 20 Jun 2011 15:14:38 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000184316.msg
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jun 2011 16:32:26 -0400
Message-ID: <4DFFB0BD.3050101@udio.cujae.edu.cu>
Date: Mon, 20 Jun 2011 16:42:37 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: linux-watchdog@vger.kernel.org
Subject: About internal heartbeat timer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi

I have a doubt about the use of internal timer to reset the wdt when the 
watchdog device was closed from userspace and it doesn't support 
stopping the wdt.
I think, in my modest opinion, that if the watchdog device was closed at 
userspace it means that something is wrong at userspace and the system 
needs to be rebooted.

I think that  the internal timer can be useful in the following scenario:
If an user reboot the system, then the internal timer must ensure that 
the watchdog didn't reset the system during the reboot process and it 
send ticks to the wdt until the user/clean reboot process get finished.
Maybe a reboot notifier can be used to detect when the user reboot the 
system manually.

thanks and feel free to comment about this
Alejandro




Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
