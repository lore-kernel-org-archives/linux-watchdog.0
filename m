Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:58976 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758872Ab1FBMnn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Jun 2011 08:43:43 -0400
Received: from newton.cujae.edu.cu (unknown [10.8.1.212])
	by mtaext1.cujae.edu.cu (Postfix) with ESMTP id 79F7A3E023
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jun 2011 08:33:33 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id DAD6F24068
	for <linux-watchdog@vger.kernel.org>;
	Thu,  2 Jun 2011 08:37:39 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000170715.msg
	for <linux-watchdog@vger.kernel.org>; Thu, 02 Jun 2011 08:30:20 -0400
Message-ID: <4DE78429.6070002@udio.cujae.edu.cu>
Date: Thu, 02 Jun 2011 08:38:01 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: linux-watchdog@vger.kernel.org
Subject: How to add a new wdt driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi
I had a watchdog timer driver for Xilinx watchdog ipcore and I want to 
share it.

Do I have to make the patch using git ??
Can I download only the files (from the git web interface) that I 
modified (Kconfig, Makefile) and make the patch using diff utility ??
I tested the patch against the 2.6.39-rc7 and it works fine...

Best regards and thanks in advance
Alejandro







Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
