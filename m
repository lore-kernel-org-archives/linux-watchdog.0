Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57569 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab1CBRiJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2011 12:38:09 -0500
Received: by bwz15 with SMTP id 15so375142bwz.19
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Mar 2011 09:38:08 -0800 (PST)
Message-ID: <4D6E8025.2030702@mvista.com>
Date: Wed, 02 Mar 2011 20:36:37 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: John Crispin <blogic@openwrt.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com> <20110302142933.GA18221@linux-mips.org> <4D6E5CA9.5090201@openwrt.org> <20110302162730.GA23666@linux-mips.org>
In-Reply-To: <20110302162730.GA23666@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

Ralf Baechle wrote:

>> Hi Ralf,
>>> While nitpicking - there should be one space between include and < in
>>> #include <blah.h>.

>> where did you see that ?

>> +#include<linux/module.h>
>> +#include<linux/fs.h>
>> +#include<linux/miscdevice.h>
>> +#include<linux/watchdog.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/uaccess.h>
>> +#include<linux/clk.h>
>> +#include<linux/io.h>
>> +
>> +#include<lantiq.h>

> But that only seems to have happened to the code quoted in Sergei's mail.

    Stupid Thunderbird is to be blamed here. :-)

>   Ralf

WBR, Sergei

