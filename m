Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:36557 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab1CBPmu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2011 10:42:50 -0500
Message-ID: <4D6E65C8.4020500@openwrt.org>
Date: Wed, 02 Mar 2011 16:44:08 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@mvista.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com>
In-Reply-To: <4D6E286D.9050100@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sergei,

thanks for the comments, one question below
>> +    /* we do not need to enable the clock as it is always running */
>> +    clk = clk_get(&pdev->dev, "io");
>
>    clk_get() may fail...
>

lantiq socs have 2 static clock that are always running. so i think it
is safe to assume that this wont fail unless someone renames the clocks.

alternatively i could add a

if (!clk)
   BUG();

but i am not sure if it is required.

thanks,
John
