Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:34628 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934287AbcAZMeB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 07:34:01 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: Paul Bolle <pebolle@tiscali.nl>
References: <20160125190942.GA6824@sophia>
 <1453799387.17181.76.camel@tiscali.nl>
Cc: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Message-ID: <56A767B7.3040806@gmail.com>
Date: Tue, 26 Jan 2016 07:33:59 -0500
MIME-Version: 1.0
In-Reply-To: <1453799387.17181.76.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2016 04:09 AM, Paul Bolle wrote:
> On ma, 2016-01-25 at 14:09 -0500, William Breathitt Gray wrote:
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
> 
>> +config EBC_C386_WDT
>> +	tristate "WinSystems EBC-C384 Watchdog Timer"
>> +	depends on X86
>> +	select WATCHDOG_CORE
>> +	help
>> +	  Enables watchdog timer support for the watchdog timer on the
>> +	  WinSystems EBC-C384 motherboard. The timeout may be configured via
>> +	  the timeout module parameter.
> 
> It's utterly trivial, but I couldn't help noticing that this supports
> the "EBC-C384" motherboard but the Kconfig symbol is EBC_C386_WDT (note
> the 6). Any particular reason?

Looks like you caught a typo of mine! I'll fix it in my next patch. Many 
thanks Paul for your good eye.                                           
                                                                         
William Breathitt Gray 

