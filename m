Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45926 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1CCLW1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2011 06:22:27 -0500
Received: by bwz15 with SMTP id 15so1040951bwz.19
        for <linux-watchdog@vger.kernel.org>; Thu, 03 Mar 2011 03:22:26 -0800 (PST)
Message-ID: <4D6F79A0.6050903@mvista.com>
Date: Thu, 03 Mar 2011 14:21:04 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Jamie Iles <jamie@jamieiles.com>
CC: John Crispin <blogic@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com> <20110303101527.GE2955@pulham.picochip.com>
In-Reply-To: <20110303101527.GE2955@pulham.picochip.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

On 03-03-2011 13:15, Jamie Iles wrote:

>>> +static int
>>> +ltq_wdt_remove(struct platform_device *dev)

>>     __exit?

> No, I think this should be __devexit and the probe function should be
> __devinit.  When assigning the exit function to the platform_driver it
> should be surrounded with __devexit_p().

    Why? Is WDT really a hotplug device?

> Jamie

WBR, Sergei
