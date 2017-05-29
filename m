Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36715 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdE2NbA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 May 2017 09:31:00 -0400
Subject: Re: [PATCH] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS
 dependencies
To: Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
References: <20170527012256.6005-1-mopsfelder@gmail.com>
 <2c95ae14-06a7-d3c2-aabb-1e164eb6b6e9@roeck-us.net>
 <87zidw76un.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <mopsfelder@gmail.com>
Message-ID: <dfb45854-4122-e565-6bb7-d636013f5499@gmail.com>
Date: Mon, 29 May 2017 10:30:55 -0300
MIME-Version: 1.0
In-Reply-To: <87zidw76un.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/28/2017 11:08 PM, Michael Ellerman wrote:
[...]
> We could stub out the RTAS pieces it needs. But I don't think it buys us
> much, for compile testing you may as well just build a config which has
> PPC_RTAS enabled, there are several.
> 
> So I think it should just depend on PPC_RTAS.
> 
> Murilo can you send a v2?
> 
> cheers

Thanks, Guenter and Michael, for reviewing!

I sent out a v2.

-- 
Murilo
