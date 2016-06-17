Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39374 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbcFQDKv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Jun 2016 23:10:51 -0400
Subject: Re: ALi M6117 watchdog driver
To: Craig McQueen <craig.mcqueen@innerrange.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <5500469A22567C4BAF673A6E86AFA3A4022D2A096F97@IR-CENTRAL.corp.innerrange.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57636A37.3000109@roeck-us.net>
Date: Thu, 16 Jun 2016 20:10:47 -0700
MIME-Version: 1.0
In-Reply-To: <5500469A22567C4BAF673A6E86AFA3A4022D2A096F97@IR-CENTRAL.corp.innerrange.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/16/2016 07:06 PM, Craig McQueen wrote:
> I am using a DM&P eBox mini-PC eBox-3310A, which uses the Ali M6117 watchdog.
>
> I found an old driver for that, and I've updated it for more recent Linux kernels, and using the Linux watchdog kernel API.
>
> Out-of-tree code is here:
> https://github.com/cmcqueen/alim6117_wdt
>
> Can this be integrated into the kernel tree?
>

Sure, with a little cleanup, if someone is willing to do the work.

Guenter

