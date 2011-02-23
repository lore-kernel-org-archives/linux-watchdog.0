Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:17193 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab1BWWTZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Feb 2011 17:19:25 -0500
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p1NMJNe3016002
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2011 14:19:23 -0800
Received: from gxk8 (gxk8.prod.google.com [10.202.11.8])
	by kpbe20.cbf.corp.google.com with ESMTP id p1NMIidA004532
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2011 14:19:21 -0800
Received: by gxk8 with SMTP id 8so1810929gxk.33
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2011 14:19:21 -0800 (PST)
Message-ID: <4D6587E6.2080009@google.com>
Date: Wed, 23 Feb 2011 14:19:18 -0800
From: Mike Waychison <mikew@google.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH 0/10] Generic Watchdog Timer Driver
References: <20110223204108.GA6327@infomag.iguana.be>
In-Reply-To: <20110223204108.GA6327@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/23/11 12:41, Wim Van Sebroeck wrote:
> Hi All,
>
> To reduce copying the same code over and over in each watchdog device driver, Alan Cox and myself constructed a new framework/API that consolidates the common watchdog timer driver functions.
>
> This framework/API consists of the following patches:
> part  1: Introduction of the WatchDog Timer Driver Core
> part  2: Add the basic ioctl functionality
> part  3: Add the WDIOC_KEEPALIVE ioctl
> part  4: Add the WDIOC_SETOPTIONS ioctl
> part  5: Add the WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT ioctl
> part  6: Add orphan control
> part  7: Add the Magic Close feature
> part  8: Add the nowayout feature
> part  9: Add support for a miscdev parent device
> part 10: Add support for extra ioctl calls
>
> Note: I still need to add the minimum and maximum timeout parameters.
> (That will become part 11).

Overall, this looks really good IMO.  It goes a long way to setting the 
stage for cleaning up the watchdog drivers themselves :)

Reviewed-by: Mike Waychison <mikew@google.com>
