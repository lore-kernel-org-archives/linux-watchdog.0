Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42949 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335Ab1CBRgY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2011 12:36:24 -0500
Received: by bwz15 with SMTP id 15so373221bwz.19
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Mar 2011 09:36:23 -0800 (PST)
Message-ID: <4D6E7FBC.6040805@mvista.com>
Date: Wed, 02 Mar 2011 20:34:52 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: John Crispin <blogic@openwrt.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com> <20110302142933.GA18221@linux-mips.org>
In-Reply-To: <20110302142933.GA18221@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

Ralf Baechle wrote:

>>> +	switch (cmd) {
>>> +	case WDIOC_GETSUPPORT:
>>> +		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
>>> +				sizeof(ident)) ? -EFAULT : 0;

>>    Doesn't copy_to_user() return 0 or -EFAULT?

> No and that's a common cause of bugs.  copy_{from,to}_user returns the
> number of characters that could be be copied so the conversion to an
> error code is needed here.

    But then the code above would be wrong. Actually, it returns the number of 
bytes that could NOT be copied as I now see.

> The function takes a void argument and there is no benefit from casting
> to the full struct watchdog_info __user * pointer type other than maybe
> clarity to the human reader.

    Indeed.

>   Ralf

WBR, Sergei
